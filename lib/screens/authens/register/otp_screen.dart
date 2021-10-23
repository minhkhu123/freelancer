import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/screens/authens/register/success_register_screen.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/widgets/custom_button.dart';
import 'package:get/get.dart';

class OTPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Xác thực mã OTP',
                          style: AppTextStyles.regularW500(context, size: 26, color: AppColors.black),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Mã OTP đã được gửi đến Email của bạn.',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                        waitLoginController.checkWhoUR.value
                            ? Text(
                                'Bạn vui lòng kiểm tra Email đã đăng ký và nhập mã OTP để xác nhận',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                'Bạn vui lòng kiểm tra Email đã đăng ký và nhập mã OTP để xác nhận đăng ký thuê Freelancer.',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, height: 1.5),
                                textAlign: TextAlign.center,
                              ),
                        SizedBox(height: 25),
                        TextFormField(
                          // onChanged: (value) {
                          // },
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          controller: controller.otpTextEditingController,
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.hintText),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'Nhập mã xác nhận',
                              hintStyle: TextStyle(color: AppColors.hintText),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              isDense: true,
                              errorText: controller.checkValidOTP(),
                              counter: SizedBox.shrink()),
                          maxLength: 6,
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: CustomButton(
                            title: 'Xác nhận',
                            onPressed: controller.whoYouAre ? () => controller.confirmOTPUV() : () => controller.confirmOTPNTD(),
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn đã nhận được mã? ',
                    style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey),
                  ),
                  InkWell(
                    onTap: waitLoginController.checkWhoUR.value ? () => controller.resendOTPUV() : () => controller.resendOTPNTD(),
                    child: Text(
                      'GỬI LẠI MÃ',
                      style: AppTextStyles.regularW700(context, size: 16, color: AppColors.blue2),
                    ),
                  ),
                  // SizedBox(width: 5),
                  // Text(
                  //   '(50)',
                  //   style: AppTextStyles.regularW400(context, size: 16, color: AppColors.orange),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
