// ignore_for_file: prefer_final_fields

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopo/const/app_colors.dart';
import 'package:shopo/model/product_model.dart';
import 'package:shopo/screens/all_product_screen.dart';
import 'package:shopo/screens/category_screen.dart';
import 'package:shopo/screens/user_screen.dart';
import 'package:shopo/services/api_handler.dart';
import 'package:shopo/utilities/routes.dart';
import 'package:shopo/widget/appbaricons.dart';
import 'package:shopo/widget/product_card.dart';
import 'package:shopo/widget/sale_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  final List<SaleWidget> saleShoWAd = const [
    SaleWidget(
        title: "Get the special discount",
        image: "assets/images/shoes.png",
        off: "50%\nOFF"),
    SaleWidget(
        title: "Discount on casual jeans",
        image: "assets/images/jeans.png",
        off: "40%\nOFF"),
    SaleWidget(
        title: "Discount on casual shirts",
        image: "assets/images/shirts.png",
        off: "35%\nOFF"),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("SHOPO"),
          leading: AppBarIcon(
              function: () {
                Routes.instance
                    .push(context: context, newScreen: const CategoryScreen());
              },
              icon: IconlyBold.category),
          actions: [
            AppBarIcon(
                function: () {
                  Routes.instance
                      .push(context: context, newScreen: const UserScreen());
                },
                icon: IconlyBold.user3),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              TextFormField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  suffixIcon: Icon(
                    IconlyLight.search,
                    color: iconsColor,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 173.h,
                        child: Swiper(
                          autoplay: true,
                          itemCount: saleShoWAd.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SaleWidget(
                                title: saleShoWAd[index].title.toString(),
                                image: saleShoWAd[index].image.toString(),
                                off: saleShoWAd[index].off.toString(),
                              ),
                            );
                          },
                          pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.white,
                                  activeColor: Colors.red)),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          const Text(
                            "All Products",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          AppBarIcon(
                              function: () {
                                Routes.instance.push(
                                    context: context,
                                    newScreen: const AllProductsScreen());
                              },
                              icon: IconlyBold.arrowRight2),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      FutureBuilder<List<ProductModel>>(
                          future: ApiHandler.getAllProducts(
                              context: context, limit: "4"),
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
                                          crossAxisSpacing: 7.0,
                                          mainAxisSpacing: 7.0,
                                          childAspectRatio: 0.59),
                                  itemBuilder: (context, index) {
                                    return ChangeNotifierProvider.value(
                                        value: snapshot.data![index],
                                        child: const ProductCard());
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
                          })),
                      SizedBox(height: 10.h)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }
}
