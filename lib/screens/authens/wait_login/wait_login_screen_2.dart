import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/routes/app_routes.dart';
import 'package:freelancer_app/screens/authens/login/login_screen.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/screens/authens/register/register_screen.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/home/home_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_screen.dart';
import 'package:get/get.dart';

class WaitLoginScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Image.asset(Images.top_route_1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                        icon: SvgPicture.asset(Images.ic_back)),
                    Image.asset(Images.logo_wait_login),
                    SizedBox(height: 60),
                    InkWell(
                      onTap: () => Get.to( () => LoginScreen()),
                      child: Container(
                        height: height*0.07,
                        width: width*0.9,
                        decoration: BoxDecoration(
                          color: AppColors.white1,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Center(child: Text('Đăng Nhập',style: AppTextStyles.regularW500(context, size: 18,color: Colors.black),)),
                      ),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        Get.to( () => RegisterScreen());
                        },
                      child: Container(
                        height: height*0.07,
                        width: width*0.9,
                        decoration: BoxDecoration(
                            color: AppColors.white1,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Center(child: Text('Tạo Tài Khoản',style: AppTextStyles.regularW500(context, size: 18,color: Colors.black),)),
                      ),
                    ),
                    SizedBox(height: 30),
                    GetBuilder<WaitLoginController>(
                      init: WaitLoginController(),
                      builder: (controller) => InkWell(
                        onTap: () {
                          controller.checkLogin.value = false;
                          controller.checkIsLogin();
                          controller.checkWhoYouAre();
                          controller.clearToken();
                          navigationController.currentPage.value = HomeScreen();
                          controller.checkWhoUR.value ? navigationController.listJobProjectHome.clear() : navigationController.listFreelancerLatestHome.clear();
                          controller.checkWhoUR.value ? navigationController.listJobPartimeHome.clear() : navigationController.listFreelancerOutstandingHome.clear();
                          controller.checkWhoUR.value ? navigationController.setUpFreelancer() : navigationController.setUpNTD();
                          Get.to(NavigationScreen());
                          // Get.offAll(() => NavigationScreen());
                        },
                        child: Container(
                          height: height*0.07,
                          width: width*0.9,
                          decoration: BoxDecoration(
                              color: AppColors.white1,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Center(child: Text('Truy Cập Không Cần Tài Khoản',style: AppTextStyles.regularW500(context, size: 18,color: Colors.black),)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
