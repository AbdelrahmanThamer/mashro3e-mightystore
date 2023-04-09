import 'package:nb_utils/nb_utils.dart';

const AppName = 'MightyStore';

///OneSignalAppID
const mOneSignalAPPKey = 'ADD YOUR ONESIGNALAPP KEY';

///ADMob Id
const bannerAdIdForAndroid = "ADD YOUR ADMOB BANNER ID";
const bannerAdIdForIos = "ADD YOUR ADMOB BANNER ID FOR IOS";
const InterstitialAdIdForAndroid = "ADD YOUR INTERSTITIAL AD ID FOR ANDROID";
const interstitialAdIdForIos = "ADD YOUR INTERSTITIAL AD ID FOR IOS";

/// PAYMENT METHOD ENABLE/DISABLE
const IS_STRIPE = true;
const IS_RAZORPAY = true;
const IS_PAY_STACK = true;
const IS_FLUTTER_WAVE = true;
const IS_PAY_FROM_WALLET = true;

///RazorPay
const razorKey = "ADD YOUR RAZORPAY KEY";

///StripPayment
const stripPaymentKey = 'ADD YOUR STRIP PAYMENT SECRET KEY';
const stripPaymentPublishKey = 'ADD YOUR STRIPPAYMENT PUBLISHKEY';

///FlutterWave
const flutterWavePublicKey = 'ADD YOUR FLUTTER WAVE PUBLIC KEY';
const flutterWaveSecretKey = 'ADD YOUR FLUTTER WAVE SECRET KEY';
const flutterWaveEncryptionKey = 'FLUTTER WAVE ENCRYPTIONKEY';

///PAY STACK DETAIL
const payStackPublicKey = 'ADD YOUR PAYSTACK PUBLIC KEY';

///Terms&Condition
const TERMS_CONDITION_URL = "ADD YOUR TERMS AND CONDITION URL";
const PRIVACY_POLICY_URL = "ADD YOURPRIVCACY POLICY URL";


/// SharedPreferences Keys
const IS_LOGGED_IN = 'IS_LOGGED_IN';
const IS_SOCIAL_LOGIN = 'IS_SOCIAL_LOGIN';
const IS_GUEST_USER = 'IS_GUEST_USER';
const THEME_COLOR = 'THEME_COLOR';
const DASHBOARD_DATA = 'DASHBOARD_DATA';
const SLIDER_DATA = 'SLIDER_DATA';
const CROSS_AXIS_COUNT = 'CROSS_AXIS_COUNT';
const CATEGORY_CROSS_AXIS_COUNT = 'CATEGORY_CROSS_AXIS_COUNT';
const msg = 'message';
const CART_DATA = 'CART_DATA';
const WISH_LIST_DATA = 'WISH_LIST_DATA';
const GUEST_USER_DATA = 'GUEST_USER_DATA';
const TOKEN = 'TOKEN';
const USERNAME = 'USERNAME';
const FIRST_NAME = 'FIRST_NAME';
const LAST_NAME = 'LAST_NAME';
const USER_DISPLAY_NAME = 'USER_DISPLAY_NAME';
const USER_ID = 'USER_ID';
const USER_EMAIL = 'USER_EMAIL';
const USER_ROLE = 'USER_ROLE';
const AVATAR = 'AVATAR';
const PASSWORD = 'PASSWORD';
const PROFILE_IMAGE = 'PROFILE_IMAGE';
const BILLING = 'BILLING';
const SHIPPING = 'SHIPPING';
const COUNTRIES = 'COUNTRIES';
const LANGUAGE = 'LANGUAGE';
const CARTCOUNT = 'CARTCOUNT';
const WHATSAPP = 'WHATSAPP';
const FACEBOOK = 'FACEBOOK';
const TWITTER = 'TWITTER';
const INSTAGRAM = 'INSTAGRAM';
const CONTACT = 'CONTACT';
const PRIVACY_POLICY = 'PRIVACY_POLICY';
const TERMS_AND_CONDITIONS = 'TERMS_AND_CONDITIONS';
const COPYRIGHT_TEXT = 'COPYRIGHT_TEXT';
const PAYMENTMETHOD = 'PAYMENTMETHOD';
const ENABLECOUPON = 'ENABLECOUPON';
const PAYMENT_METHOD_NATIVE = "native";
const DEFAULT_CURRENCY = 'DEFAULT_CURRENCY';
const CURRENCY_CODE = 'CURRENCY_CODE';
const IS_NOTIFICATION_ON = "IS_NOTIFICATION_ON";
const DETAIL_PAGE_VARIANT = 'DetailPageVariant';
const IS_REMEMBERED = "IS_REMEMBERED";
const IS_DOKAN_ACTIVE = 'IS_DOKAN_ACTIVE';
const PLAYER_ID = 'PLAYER_ID';
const WALLET = 'WALLET';

//Start AppSetup
const APP_NAME = 'appName';
const PRIMARY_COLOR = 'primaryColor';
const SECONDARY_COLOR = 'secondaryColor';
const TEXT_PRIMARY_COLOR = 'textPrimaryColor';
const TEXT_SECONDARY_COLOR = 'textSecondaryColor';
const BACKGROUND_COLOR = 'backgroundColor';
const CONSUMER_KEY = 'consumerKey';
const CONSUMER_SECRET = 'consumerSecret';
const APP_URL = 'appUrl';
//End AppSetup

//Date Format
const orderDateFormat = 'dd-MM-yyyy';
const reviewDateFormat = 'dd MMM yy  hh:mm a';
const CreateDateFormat = 'MMM dd, yyyy';

const accessAllowed = true;
const demoPurposeMsg = 'This action is not allowed in demo app.';

const COMPLETED = "completed";
const REFUNDED = "refunded";
const CANCELED = "cancelled";
const TRASH = "trash";
const FAILED = "failed";
const SUCCESS = 'Success';

/* Theme Mode Type */
const ThemeModeLight = 0;
const ThemeModeDark = 1;
const ThemeModeSystem = 2;

const defaultLanguage = 'en';

const VideoTypeCustom = 'custom_url';
const VideoTypeYouTube = 'youtube';
const VideoTypeIFrame = 'iframe';

const enableSignWithGoogle = true;
const enableSignWithApple = true;
const enableSignWithOtp = true;
const enableSocialSign = true;
const enableAdsLoading = true;
const enableAds = true;

const enableBlog = true;
const enableMultiDemo = false;
const enableDashboardVariant = true;
bool get enableTeraWallet => getBoolAsync(WALLET);

// Set per page item
const TOTAL_ITEM_PER_PAGE = 50;
const TOTAL_CATEGORY_PER_PAGE = 50;
const TOTAL_SUB_CATEGORY_PER_PAGE = 50;
const TOTAL_DASHBOARD_ITEM = 4;
const TOTAL_BLOG_ITEM = 6;

const WISHLIST_ITEM_LIST = 'WISHLIST_ITEM_LIST';
const CART_ITEM_LIST = 'CART_ITEM_LIST';

const DASHBOARD_PAGE_VARIANT = 'DashboardPageVariant';
const PRODUCT_DETAIL_VARIANT = 'ProductDetailVariant';

const streamRefresh = "streamRefresh";

// Set Theme
bool get isHalloween => getBoolAsync(HALLOWEEN_ENABLE);
const HALLOWEEN_ENABLE = 'halloween_enable';

// Halloween Theme
const base_URL = "https://meetmighty.com/mobile/halloween/wp-json/";
const consumerKey = "ck_74b86eff5a9e8b495ea9bf13d352ab6d343e4293";
const consumerSecret = "cs_5d9a58c45b58e19f61054577f8d8ba6cab1e6e40";
