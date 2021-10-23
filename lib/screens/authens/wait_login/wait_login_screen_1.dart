import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_screen_2.dart';
import 'package:get/get.dart';

class WaitLoginScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Images.top_route_1),
          SizedBox(height: 100),
          Text('Bạn là:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
          SizedBox(height: 55),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: GetBuilder<WaitLoginController>(
              init: WaitLoginController(),
              builder: (controller) => Column(
                children: [
                  InkWell(
                    onTap: () {
                      controller.checkWhoUR.value = false;
                      controller.checkWhoYouAre();
                      controller.typeUser.value = 2;
                      controller.checkTypeUser();
                      print(controller.checkWhoUR.value);
                      Get.to( () => WaitLoginScreen2());
                    },
                    child: Container(
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyBorder),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(Images.ic_imployer),
                          SizedBox(width: 20),
                          Text('Nhà Tuyển Dụng',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      controller.checkWhoUR.value = true;
                      controller.checkWhoYouAre();
                      controller.typeUser.value = 1;
                      controller.checkTypeUser();
                      print(controller.checkWhoUR.value);
                      Get.to( () => WaitLoginScreen2());
                    },
                    child: Container(
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyBorder),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(Images.ic_freelancer),
                          SizedBox(width: 20),
                          Text('Freelancer',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 27),
            child: Text('Copyright by Timviec365.com',style: AppTextStyles.regularW400(context, size: 14,color: Colors.black),),
          ),
          WillPopScope(
            onWillPop: () => exit(0),
            child: Container(),
          )
        ],
      ),
    ));
  }
}
