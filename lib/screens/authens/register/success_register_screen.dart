import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/login/login_screen.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/widgets/custom_button.dart';
import 'package:get/get.dart';

class SuccessRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: GetBuilder<RegisterController>(
          init: RegisterController(),
          builder: (controller) => Column(
            children: [
              Image.asset(Images.top_route_1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: () => Get.back(), icon: SvgPicture.asset(Images.ic_back)),
                    Column(
                      children: [
                        SvgPicture.asset(Images.ic_create_success),
                        SizedBox(height: 50),
                        Text(
                          'Đăng ký thành công',
                          style: AppTextStyles.regularW500(context, size: 26, color: AppColors.black),
                        ),
                        SizedBox(height: 30),
                        Text(
                          controller.whoYouAre
                              ? 'Bạn đã đăng ký làm Freelancer thành công. Bạn vui lòng đăng nhập.' : 'Bạn đã đăng ký thuê Freelancer thành công. Bạn vui lòng đăng nhập.',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.3),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: CustomButton(
                            title: 'Đăng nhập',
                            onPressed: () {
                              Get.to(LoginScreen());
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
