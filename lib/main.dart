import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mightystore/AppTheme.dart';
import 'package:mightystore/Store/AppStore.dart';
import 'package:mightystore/Store/WishListStore/WishListStore.dart';
import 'package:mightystore/app_localizations.dart';
import 'package:mightystore/models/BuilderResponse.dart';
import 'package:mightystore/models/CartModel.dart';
import 'package:mightystore/models/LanguageModel.dart';
import 'package:mightystore/models/WishListResponse.dart';
import 'package:mightystore/screen/ChristmasScreens/ChristmasSplashScreen.dart';
import 'package:mightystore/screen/NoInternetScreen.dart';
import 'package:mightystore/screen/SplashScreen.dart';
import 'package:mightystore/utils/colors.dart';
import 'package:mightystore/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'Store/CartStore/CartStore.dart';

BuilderResponse builderResponse = BuilderResponse();
Color? primaryColor;
Color? colorAccent;
Color? textPrimaryColour;
Color? textSecondaryColour;
Color? backgroundColor;
String? baseUrl;
// ignore: non_constant_identifier_names
String? ConsumerKey;
// ignore: non_constant_identifier_names
String? ConsumerSecret;
AppStore appStore = AppStore();
WishListStore wishListStore = WishListStore();
CartStore cartStore = CartStore();
Language? language;
List<Language> languages = Language.getLanguages();

Future<String> loadBuilderData() async {
  return await rootBundle.loadString('assets/builder.json');
}

Future<BuilderResponse> loadContent() async {
  String jsonString = await loadBuilderData();
  final jsonResponse = json.decode(jsonString);
  return BuilderResponse.fromJson(jsonResponse);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().catchError((e) {});

  await initialize();

  Stripe.publishableKey = stripPaymentPublishKey;
  if (isIos) {
    Stripe.merchantIdentifier = "YOUR_App_Identifier";
    await Stripe.instance.applySettings();
  }

  if (isMobile) {
    //await setupRemoteConfig();

    await OneSignal.shared.setAppId(mOneSignalAPPKey);
    OneSignal.shared.consentGranted(true);
    OneSignal.shared.promptUserForPushNotificationPermission();
    final status = await OneSignal.shared.getDeviceState();
    await setValue(PLAYER_ID, status?.userId.toString());

    MobileAds.instance.initialize();
    //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  appStore.setCount(getIntAsync(CARTCOUNT, defaultValue: 0));
  appStore.setNotification(getBoolAsync(IS_NOTIFICATION_ON, defaultValue: true));

  await setValue(DASHBOARD_PAGE_VARIANT, 1);
  await setValue(PRODUCT_DETAIL_VARIANT, 1);

  builderResponse = await loadContent();

  if (isHalloween) {
    await setValue(PRIMARY_COLOR, mChristmasBg);
    if (base_URL.isEmpty) {
      await setValue(APP_URL, builderResponse.appsetup!.appUrl);
      await setValue(CONSUMER_KEY, builderResponse.appsetup!.consumerKey);
      await setValue(CONSUMER_SECRET, builderResponse.appsetup!.consumerSecret);
    } else {
      await setValue(APP_URL, base_URL);
      await setValue(CONSUMER_KEY, consumerKey);
      await setValue(CONSUMER_SECRET, consumerSecret);
    }
  } else {
    await setValue(PRIMARY_COLOR, builderResponse.appsetup!.primaryColor);
    await setValue(APP_URL, builderResponse.appsetup!.appUrl);
    await setValue(CONSUMER_KEY, builderResponse.appsetup!.consumerKey);
    await setValue(CONSUMER_SECRET, builderResponse.appsetup!.consumerSecret);
  }

  await setValue(BACKGROUND_COLOR, builderResponse.appsetup!.backgroundColor);
  await setValue(SECONDARY_COLOR, builderResponse.appsetup!.secondaryColor);
  await setValue(TEXT_PRIMARY_COLOR, builderResponse.appsetup!.textPrimaryColor);
  await setValue(TEXT_SECONDARY_COLOR, builderResponse.appsetup!.textSecondaryColor);

  if (isHalloween) {
    if (getIntAsync(THEME_MODE_INDEX) == ThemeModeDark) {
      primaryColor = Colors.white;
    } else {
      primaryColor = getColorFromHex(getStringAsync(PRIMARY_COLOR), defaultColor: appColorPrimary);
    }
  } else {
    primaryColor = getColorFromHex(getStringAsync(PRIMARY_COLOR), defaultColor: appColorPrimary);
  }

  colorAccent = getColorFromHex(getStringAsync(SECONDARY_COLOR), defaultColor: appColorAccent);
  textPrimaryColour = getColorFromHex(getStringAsync(TEXT_PRIMARY_COLOR), defaultColor: textColorPrimary);
  textSecondaryColour = getColorFromHex(getStringAsync(TEXT_SECONDARY_COLOR), defaultColor: textColorSecondary);
  backgroundColor = getColorFromHex(getStringAsync(BACKGROUND_COLOR), defaultColor: itemBackgroundColor);

  String cartString = getStringAsync(CART_ITEM_LIST);
  if (cartString.isNotEmpty) {
    cartStore.addAllCartItem(jsonDecode(cartString).map<CartModel>((e) => CartModel.fromJson(e)).toList());
  }

  String wishListString = getStringAsync(WISHLIST_ITEM_LIST);
  if (wishListString.isNotEmpty) {
    wishListStore.addAllWishListItem(jsonDecode(wishListString).map<WishListResponse>((e) => WishListResponse.fromJson(e)).toList());
  }

  baseUrl = getStringAsync(APP_URL);
  ConsumerKey = getStringAsync(CONSUMER_KEY);
  ConsumerSecret = getStringAsync(CONSUMER_SECRET);

  int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
  if (themeModeIndex == ThemeModeLight) {
    appStore.setDarkMode(aIsDarkMode: false);
  } else if (themeModeIndex == ThemeModeDark) {
    appStore.setDarkMode(aIsDarkMode: true);
  }

  appStore.setLanguage(getStringAsync(LANGUAGE, defaultValue: defaultLanguage));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() async {
      await 1.seconds.delay;
      if (!await isNetworkAvailable()) {
        log('not connected');
        push(NoInternetScreen());
      }

      _connectivitySubscription = Connectivity().onConnectivityChanged.listen((e) {
        if (e == ConnectivityResult.none) {
          log('not connected');
          push(NoInternetScreen());
        } else {
          pop();
          log('connected');
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          navigatorKey: navigatorKey,
          themeMode: appStore.isDarkMode! ? ThemeMode.dark : ThemeMode.light,
          supportedLocales: Language.languagesLocale(),
          localizationsDelegates: [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
          localeResolutionCallback: (locale, supportedLocales) => locale,
          locale: Locale(appStore.selectedLanguageCode),
          home: isHalloween ? ChristmasSplashScreen() : SplashScreen(),
          builder: scrollBehaviour(),
        );
      },
    );
  }
}
