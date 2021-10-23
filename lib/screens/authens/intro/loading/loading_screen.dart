import 'package:flutter/material.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/screens/authens/intro/loading/loading_controller.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.blue,
          body: GetBuilder<LoadingController>(
            init: LoadingController(),
            builder: (controller) => Container(
              height: height,
                width: width,
                child: Image.asset(Images.loading)
            ),
          ),
    ));
  }
}
