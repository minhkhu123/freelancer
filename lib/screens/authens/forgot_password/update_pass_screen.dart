import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/forgot_password/forgot_password_controller.dart';
import 'package:freelancer_app/screens/authens/forgot_password/update_pass_success_screen.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/widgets/custom_button.dart';
import 'package:freelancer_app/widgets/custom_textfield_register.dart';
import 'package:get/get.dart';

class UpdatePassScreen extends StatelessWidget {
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
                        SvgPicture.asset(Images.logo_update_pass),
                        SizedBox(height: 30),
                        Text(
                          'Cập nhật mật khẩu',
                          style: AppTextStyles.regularW500(context, size: 26, color: AppColors.black),
                        ),
                        SizedBox(height: 20),
                        CustomTextFieldRegister(
                          isPassword: controller.isNewPassword.value,
                          textEditingController: controller.newPassTextEditingController,
                          hintText: 'Nhập mật khẩu mới',
                          iconData: controller.isNewPassword.value
                              ? SvgPicture.asset(
                                  Images.ic_eye_close,
                                  color: AppColors.black,
                                )
                              : SvgPicture.asset(
                                  Images.ic_eye,
                                  color: AppColors.black,
                                ),
                          onPressed: () {
                            controller.changeShow();
                          },
                          error: controller.checkValidPassword(),
                          inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                        ),
                        CustomTextFieldRegister(
                          isPassword: controller.isConfirmNewPassword.value,
                          hintText: 'Nhập lại mật khẩu',
                          iconData: controller.isConfirmNewPassword.value
                              ? SvgPicture.asset(
                                  Images.ic_eye_close,
                                  color: AppColors.black,
                                )
                              : SvgPicture.asset(
                                  Images.ic_eye,
                                  color: AppColors.black,
                                ),
                          onPressed: () {
                            controller.changeShowConfirm();
                          },
                          error: controller.checkValidConfirmPassword(),
                          inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: CustomButton(
                            title: 'Cập nhật mật khẩu',
                            onPressed:
                                waitLoginController.checkWhoUR.value ? () => controller.updatePasswordUV() : () => controller.updatePasswordNTD(),
                          ),
                        ),
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
