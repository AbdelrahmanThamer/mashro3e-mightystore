import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mightystore/component/HomeScreenComponent3/DashBoard3AppWidget.dart';
import 'package:mightystore/main.dart';
import 'package:mightystore/models/ProductResponse.dart';
import 'package:mightystore/screen/ProductDetail/ProductDetailScreen1.dart';
import 'package:mightystore/screen/ProductDetail/ProductDetailScreen2.dart';
import 'package:mightystore/screen/ProductDetail/ProductDetailScreen3.dart';
import 'package:mightystore/utils/ProductWishListExtension.dart';
import 'package:mightystore/utils/app_Widget.dart';
import 'package:mightystore/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class DashBoard3Product extends StatefulWidget {
  static String tag = '/Product';
  final double? width;
  final ProductResponse? mProductModel;

  DashBoard3Product({Key? key, this.width, this.mProductModel}) : super(key: key);

  @override
  DashBoard3ProductState createState() => DashBoard3ProductState();
}

class DashBoard3ProductState extends State<DashBoard3Product> {
  bool mIsInWishList = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var productWidth = MediaQuery.of(context).size.width;

    String? img = widget.mProductModel!.images!.isNotEmpty ? widget.mProductModel!.images!.first.src : '';

    return GestureDetector(
      onTap: () async {
        setState(() {
          onClickProduct(context, widget.mProductModel!);
        });
      },
      child: Container(
        width: widget.width,
        margin: EdgeInsets.all(4),
        decoration: boxDecorationWithShadow(boxShadow: [BoxShadow(blurRadius: 0.3, spreadRadius: 0.2, color: gray.withOpacity(0.3))], backgroundColor: Theme.of(context).cardTheme.color!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: boxDecorationWithRoundedCorners(borderRadius: radius(0.0), backgroundColor: Theme.of(context).colorScheme.background),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  commonCacheImageWidget(img.validate(), height: 180, width: productWidth, fit: BoxFit.cover),
                  mDashBoard3Sale(widget.mProductModel!),
                  ProductWishListExtension(mProductModel: widget.mProductModel!)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8),
              width: productWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  4.height,
                  Text(widget.mProductModel!.name, style: primaryTextStyle(), maxLines: 1),
                  2.height,
                  Row(
                    children: [
                      PriceWidget(
                        price: widget.mProductModel!.onSale == true
                            ? widget.mProductModel!.salePrice.validate().isNotEmpty
                                ? double.parse(widget.mProductModel!.salePrice.toString()).toStringAsFixed(2)
                                : double.parse(widget.mProductModel!.price.validate()).toStringAsFixed(2)
                            : widget.mProductModel!.regularPrice!.isNotEmpty
                                ? double.parse(widget.mProductModel!.regularPrice.validate().toString()).toStringAsFixed(2)
                                : double.parse(widget.mProductModel!.price.validate().toString()).toStringAsFixed(2),
                        size: 14,
                        color: primaryColor,
                      ),
                      4.width,
                      PriceWidget(
                        price: widget.mProductModel!.regularPrice.validate().toString(),
                        size: 12,
                        isLineThroughEnabled: true,
                        color: Theme.of(context).textTheme.subtitle1!.color,
                      ).visible(widget.mProductModel!.salePrice.validate().isNotEmpty && widget.mProductModel!.onSale == true),
                    ],
                  ).visible(!widget.mProductModel!.type!.contains("grouped") && !widget.mProductModel!.type!.contains("variable")).paddingOnly(bottom: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
