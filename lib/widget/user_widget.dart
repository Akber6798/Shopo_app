import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopo/const/app_colors.dart';
import 'package:shopo/model/user_model.dart';
import 'package:shopo/utilities/app_text_style.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel userProvider = Provider.of<UserModel>(context);
    return ListTile(
      leading: FancyShimmerImage(
        height: 45.h,
        width: 45.w,
        imageUrl: userProvider.avatar.toString(),
        errorWidget: const Icon(IconlyBold.danger, color: Colors.red, size: 28),
        boxFit: BoxFit.fill,
      ),
      title: Text(userProvider.name.toString()),
      subtitle: Text(userProvider.email.toString()),
      trailing: Text(userProvider.role.toString(),
          style:
              AppTextStyle.instance.textStyle(14, iconsColor, FontWeight.bold)),
    );
  }
}
