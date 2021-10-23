import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/forgot_password/forgot_password_controller.dart';
import 'package:freelancer_app/screens/authens/forgot_password/otp_forgot_password_screen.dart';
import 'package:freelancer_app/screens/authens/forgot_password/update_pass_screen.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/widgets/custom_button.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: GetBuilder<ForgotPasswordController>(
          init: ForgotPasswordController(),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Quên mật khẩu',
                          style: AppTextStyles.regularW500(context, size: 26, color: AppColors.black),
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          // onChanged: (value) {
                          // },
                          keyboardType: TextInputType.emailAddress,
                          controller: controller.emailTextEditingController,
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.hintText),
                          decoration: InputDecoration(
                            hintText: 'Nhập Email',
                            hintStyle: TextStyle(color: AppColors.hintText),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.blue2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.blue2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.blue2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                            prefixIcon: IconButton(
                              icon: SvgPicture.asset(Images.ic_email),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Mời bạn nhập Email đã đăng ký tài khoản trên Timviec365.com. Chúng tôi sẽ gửi mã OTP tới tài khoản Email của bạn.',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, height: 1.3),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 70),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: CustomButton(
                              title: 'Xác nhận',
                              onPressed:
                                  waitLoginController.checkWhoUR.value ? () => controller.forgotPasswordUV() : () => controller.forgotPasswordNTD()),
                        ),
                        SizedBox(height: 70),
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
