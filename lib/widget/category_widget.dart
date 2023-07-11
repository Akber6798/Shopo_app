import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopo/const/app_colors.dart';
import 'package:shopo/model/category_model.dart';
import 'package:shopo/utilities/app_text_style.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryModel categoryProvider = Provider.of<CategoryModel>(context);
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FancyShimmerImage(
              imageUrl: categoryProvider.image!,
              errorWidget:
                  const Icon(IconlyBold.danger, color: Colors.red, size: 28),
              boxFit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(categoryProvider.name.toString(),
                textAlign: TextAlign.center,
                style: AppTextStyle.instance.textStyle(
                    20.sp, cardColor, FontWeight.w400),),
          )
        ],
      ),
    );
  }
}
