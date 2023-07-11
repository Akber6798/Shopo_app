import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopo/const/app_colors.dart';
import 'package:shopo/model/user_model.dart';
import 'package:shopo/services/api_handler.dart';
import 'package:shopo/widget/appbaricons.dart';
import 'package:shopo/widget/user_widget.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Users",
        ),
        leading: AppBarIcon(
            function: () {
              Navigator.pop(context);
            },
            icon: IconlyBold.arrowLeft),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: FutureBuilder<List<UserModel>>(
          future: ApiHandler.getAllUsers(context),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Center(
                  child: Text("No Data"),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          value: snapshot.data![index],
                          child: const UserWidget());
                    });
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
      ),
    );
  }
}
