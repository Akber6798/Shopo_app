import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopo/const/app_colors.dart';
import 'package:shopo/services/api_handler.dart';
import 'package:shopo/widget/appbaricons.dart';
import 'package:shopo/widget/category_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Categories",
        ),
        leading: AppBarIcon(
            function: () {
              Navigator.pop(context);
            },
            icon: IconlyBold.arrowLeft),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              FutureBuilder(
                future: ApiHandler.getAllCategories(context),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text("No Data"),
                      );
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 0.75),
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                              value: snapshot.data![index],
                              child: const CategoryWidget());
                        },
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
            ],
          ),
        ),
      ),
    );
  }
}
