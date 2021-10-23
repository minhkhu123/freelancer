import 'package:flutter/material.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/routes/app_routes.dart';
import 'package:freelancer_app/screens/authens/login/login_screen.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

DialogLogin() {
  BuildContext context = Get.context;
  NavigationController navigationController = Get.put(NavigationController());
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  return GetBuilder<HomeController>(
    init: HomeController(),
    builder: (controller) => Dialog(
        insetPadding: EdgeInsets.only(top: 10.0),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          margin: EdgeInsets.symmetric(horizontal: 14),
          padding: EdgeInsets.symmetric(horizontal: 35),
          height: height * 0.35,
          width: width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  'Thông báo',
                  style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black2),
                ),
              ),
              Divider(
                color: AppColors.line,
                thickness: 0.5,
              ),
              Spacer(),
              Text(
                'Vui lòng đăng nhập để đặt giá cho công việc này!',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, height: 1.4),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        // Get.offAllNamed(Routes.LOGIN);
                        Get.to(LoginScreen());
                        SpUtil.putBool(ConstString.WHO_YOU_ARE, navigationController.wur);
                        print(SpUtil.getBool(ConstString.WHO_YOU_ARE));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 21, vertical: 15),
                        decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                            child: Text(
                          'Đăng nhập',
                          style: AppTextStyles.regularW500(context, size: 16, color: AppColors.white),
                        )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.grey),
                        ),
                        child: Center(
                            child: Text(
                          'Hủy',
                          style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                        )),
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        )),
  );
}
