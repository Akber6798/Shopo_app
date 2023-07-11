import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopo/const/app_colors.dart';
import 'package:shopo/model/product_model.dart';
import 'package:shopo/services/api_handler.dart';
import 'package:shopo/utilities/app_text_style.dart';
import 'package:shopo/widget/appbaricons.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details", overflow: TextOverflow.ellipsis),
        leading: AppBarIcon(
            function: () {
              Navigator.pop(context);
            },
            icon: IconlyBold.arrowLeft),
      ),
      body: FutureBuilder<ProductModel>(
        future: ApiHandler.getProductById(id: id, context: context),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            if (snapshot.data == null) {
              return const Center(
                child: Text("No Data"),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text(snapshot.data!.category!.name.toString(),
                          style: AppTextStyle.instance
                              .textStyle(20, iconsColor, FontWeight.w500)),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Text(snapshot.data!.title.toString(),
                                textAlign: TextAlign.start,
                                style: AppTextStyle.instance
                                    .textStyle(25, textColor, FontWeight.bold)),
                          ),
                          Flexible(
                            flex: 1,
                            child: RichText(
                              text: TextSpan(
                                text: '\$ ',
                                style: AppTextStyle.instance
                                    .textStyle(20, iconsColor, FontWeight.w700),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: snapshot.data!.price.toString(),
                                    style: AppTextStyle.instance.textStyle(
                                        18, textColor, FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 250.h,
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return FancyShimmerImage(
                              width: double.infinity,
                              imageUrl:
                                  snapshot.data!.images![index].toString(),
                              boxFit: BoxFit.fill,
                            );
                          },
                          autoplay: true,
                          itemCount: 3,
                          pagination: const SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                              color: Colors.white,
                              activeColor: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        "Description",
                        textAlign: TextAlign.start,
                        style: AppTextStyle.instance
                            .textStyle(20, iconsColor, FontWeight.w600),
                      ),
                      SizedBox(height: 20.h),
                      Text(snapshot.data!.description.toString(),
                          textAlign: TextAlign.start,
                          style: AppTextStyle.instance
                              .textStyle(20, textColor, FontWeight.w300)),
                      SizedBox(height: 10.h)
                    ],
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: iconsColor,
              ),
            );
          }
        }),
      ),
    );
  }
}
