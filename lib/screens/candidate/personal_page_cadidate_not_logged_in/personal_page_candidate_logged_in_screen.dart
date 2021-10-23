import 'package:flutter/material.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/login/login_screen.dart';
import 'package:freelancer_app/screens/authens/register/register_screen.dart';
import 'package:freelancer_app/screens/candidate/candidate_profile/candidate_profile_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/routes/app_routes.dart';
import 'package:sp_util/sp_util.dart';

class PersonalPageCandidateLoggedInScreen extends StatelessWidget {
  const PersonalPageCandidateLoggedInScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    NavigationController navigationController = Get.put(NavigationController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
                child: Text(
                  "Việc làm Freelancer - Làm online, nhận tiền nhanh chóng.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regularW500(context,
                      size: 18, color: AppColors.blue, lineHeight: 30),
                ),
              ),
              Image.asset(Images.img_candidate),
              SizedBox(height: 50),
              Container(
                height: height * 0.06,
                width: width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    // Get.offAll(() => LoginScreen());
                    Get.to(LoginScreen());
                    SpUtil.putBool(ConstString.WHO_YOU_ARE, navigationController.wur);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.orange)
                  ),
                  child: Text(
                    "Đăng nhập",
                    style: AppTextStyles.regularW700(context, size: 17),
                  ),
                ),
              ),
              SizedBox(height: 30),
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
                    onTap: () {
                      Get.to(RegisterScreen());
                      // Get.offAllNamed(Routes.REGISTER);
                      SpUtil.putBool(ConstString.WHO_YOU_ARE, navigationController.wur);
                    },
                    child: Text(
                      "ĐĂNG KÝ NGAY",
                      style: AppTextStyles.regularW700(context,
                          size: 16, color: AppColors.orange),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
