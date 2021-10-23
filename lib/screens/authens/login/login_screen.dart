import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/home/home_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import '../forgot_password/forgot_password_screen.dart';
import 'package:freelancer_app/screens/authens/login/login_controller.dart';
import 'package:freelancer_app/screens/authens/register/register_screen.dart';
import 'package:freelancer_app/widgets/custom_button.dart';
import 'package:freelancer_app/widgets/custom_textfield_login.dart';
import 'package:freelancer_app/widgets/custom_textfield_login_unicon.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WaitLoginController _waitLoginController = Get.put(WaitLoginController());
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(Images.top_route_1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: GetBuilder<LoginController>(
                init: LoginController(),
                builder: (controller) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: () => Get.back(), icon: SvgPicture.asset(Images.ic_back)),
                    _waitLoginController.checkWhoUR.value ? Image.asset(Images.logo_login_freelancer) : Image.asset(Images.logo_login_ntd),
                    SizedBox(height: 30),
                    CustomTextFieldLoginUnIcon(
                      isPassword: true,
                      hintText: 'Nhập Email',
                      textEditingController: controller.emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      iconPre: SvgPicture.asset(Images.ic_email),
                      error: controller.checkValidEmail(),
                    ),
                    SizedBox(height: 30),
                    CustomTextFieldLogin(
                      textEditingController: controller.passwordTextEditingController,
                      isPassword: controller.isPassword.value,
                      hintText: 'Nhập Mật Khẩu',
                      iconPre: SvgPicture.asset(Images.ic_lock),
                      iconData: controller.isPassword.value
                          ? SvgPicture.asset(
                              Images.ic_eye_close,
                            )
                          : SvgPicture.asset(
                              Images.ic_eye,
                              color: AppColors.blue,
                            ),
                      onPressed: () {
                        controller.changeShow();
                      },
                      error: controller.checkValidPassword(),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.to(ForgotPasswordScreen());
                            },
                            child: Text(
                              'Quên mật khẩu?',
                              style: AppTextStyles.regularW400(context, size: 14, color: AppColors.hintText),
                            ))
                      ],
                    ),
                    SizedBox(height: 60),
                    CustomButton(
                        title: 'Đăng nhập',
                        onPressed: _waitLoginController.checkWhoUR.value ? () {
                          controller.loginCandidate();
                        } : () => controller.loginCompany()),
                    SizedBox(height: 27),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Bạn chưa có tài khoản?   ',
                            style: AppTextStyles.regularW400(context, size: 15, color: Colors.black),
                          ),
                          InkWell(
                              onTap: () {
                                Get.to(RegisterScreen());
                                controller.emailTextEditingController.clear();
                                controller.passwordTextEditingController.clear();
                              },
                              child: Text(
                                'ĐĂNG KÝ NGAY',
                                style: AppTextStyles.regularW700(context, size: 16, color: AppColors.orange),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
