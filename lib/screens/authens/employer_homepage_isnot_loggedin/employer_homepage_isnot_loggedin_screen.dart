import 'package:flutter/material.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/login/login_screen.dart';
import 'package:freelancer_app/screens/authens/register/register_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/routes/app_routes.dart';
import 'package:sp_util/sp_util.dart';

class EmployerHomePageIsNotLoggedInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 30, right: 30, bottom: 50),
              child: Text(
                "Hàng ngàn dự án đã đăng và thuê được Freelancer thành công.",
                style: AppTextStyles.regularW500(context,
                    size: 18, color: AppColors.blue, lineHeight: 30),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(Images.img_NTD),
            Container(
              margin: const EdgeInsets.only(top: 50, bottom: 15),
              height: 43,
              width: 230,
              child: ElevatedButton(
                onPressed: () {
                  // Get.offAll(() => LoginScreen());
                  Get.to(() => LoginScreen());
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.orange),
                ),
                child: Text(
                  "Đăng nhập",
                  style: AppTextStyles.regularW700(context, size: 17),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bạn chưa có tài khoản?",
                  style: AppTextStyles.regularW400(context,
                      size: 15, color: AppColors.blue),
                ),
                SizedBox(width: 5),
                InkWell(
                  onTap: () => Get.toNamed(Routes.REGISTER),
                  child: Text(
                    "ĐĂNG KÍ NGAY",
                    style: AppTextStyles.regularW700(context,
                        size: 16, color: AppColors.orange),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
