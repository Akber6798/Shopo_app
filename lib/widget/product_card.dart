import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopo/const/app_colors.dart';
import 'package:shopo/model/product_model.dart';
import 'package:shopo/screens/product_detail_screen.dart';
import 'package:shopo/utilities/app_text_style.dart';
import 'package:shopo/utilities/routes.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProductModel productProvider = Provider.of<ProductModel>(context);
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          Routes.instance.push(
              context: context,
              newScreen: ProductDetailScreen(
                id: productProvider.id.toString(),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          text: '\$ ',
                          style: AppTextStyle.instance
                              .textStyle(18, iconsColor, FontWeight.w700),
                          children: <TextSpan>[
                            TextSpan(
                                text: productProvider.price.toString(),
                                style: AppTextStyle.instance
                                    .textStyle(17, textColor, FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                    const Icon(IconlyBold.heart),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  height: 160.h,
                  width: double.infinity,
                  imageUrl: productProvider.images![0],
                  errorWidget: const Icon(IconlyBold.danger,
                      color: Colors.red, size: 28),
                  boxFit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 8.h),
              Text(productProvider.title.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTextStyle.instance
                      .textStyle(17, textColor, FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
