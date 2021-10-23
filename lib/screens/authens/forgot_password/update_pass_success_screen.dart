import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/screens/authens/login/login_screen.dart';
import 'package:freelancer_app/widgets/custom_button.dart';
import 'package:get/get.dart';

class UpdatePassSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
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
                        'Cập nhật mật khẩu thành công',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: AppColors.black, height: 1.3),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Cập nhật mật khẩu thành công. Bạn vui lòng đăng nhập lại.',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.black, height: 1.3),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50),
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
    ));
  }
}
