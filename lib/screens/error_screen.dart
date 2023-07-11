import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopo/const/app_colors.dart';
import 'package:shopo/screens/home_screen.dart';
import 'package:shopo/utilities/routes.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: 170.h,
              width: 170.w,
              image: const AssetImage("assets/icons/warning.png"),
            ),
            SizedBox(height: 5.h),
            const Text(
              "Something went wrong!",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
                height: 40.h,
                width: 100.w,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: iconsColor),
                    onPressed: () {
                      Routes.instance.pushReplaceMent(
                          context: context, newScreen:const HomeScreen());
                    },
                    child: const Text("Go Home")))
          ],
        ),
      ),
    );
  }
}
