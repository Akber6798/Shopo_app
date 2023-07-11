import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopo/const/app_colors.dart';
import 'package:shopo/model/product_model.dart';
import 'package:shopo/services/api_handler.dart';
import 'package:shopo/widget/appbaricons.dart';
import 'package:shopo/widget/product_card.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  List<ProductModel> allProductsList = [];

  //for get all productdetails
  Future<void> getProductData() async {
    allProductsList = await ApiHandler.getAllProducts(
        context: context, limit: limit.toString());
    setState(() {});
  }

  // for Pagination
  int limit = 10;
  bool _isLimit = false;
  final ScrollController _scrollController = ScrollController();

  //we arrived at the end of the scrollable widget limit
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        limit += 10;
        if (limit == 200) {
          _isLimit = true;
        }
        await getProductData();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
        leading: AppBarIcon(
            function: () {
              Navigator.pop(context);
            },
            icon: IconlyBold.arrowLeft),
      ),
      body: allProductsList.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: iconsColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: allProductsList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 7.0,
                              mainAxisSpacing: 7.0,
                              childAspectRatio: 0.59),
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: allProductsList[index],
                            child: const ProductCard());
                      },
                    ),
                    SizedBox(height: 10.h),
                    if (!_isLimit)
                      Center(
                        child: CircularProgressIndicator(
                          color: iconsColor,
                        ),
                      ),SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
