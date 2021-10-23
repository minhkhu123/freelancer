import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'card_job_freelancer.dart';

class DialogBid extends StatelessWidget {
  final String name;
  final String dateEnd;

  const DialogBid({Key key, this.name, this.dateEnd}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GetBuilder<NavigationController>(
      init: NavigationController(),
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
            height: height * 0.7,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Text(
                      'ĐẶT GIÁ',
                      style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black2),
                    ),
                  ),
                  Divider(
                    color: AppColors.line,
                    thickness: 0.5,
                  ),
                  // Spacer(),
                  SizedBox(height: height * 0.02),
                  RichText(
                      text: TextSpan(
                          text: 'Đặt giá cho công việc ',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.black, height: 1.4, wordSpacing: 1.3),
                          children: <TextSpan>[
                            TextSpan(
                                text: name,
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppColors.blue2, height: 1.4)),
                            TextSpan(
                              text: ' để có mức giá phù hợp với bạn nhất!',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.black, height: 1.4),
                            )
                          ])),
                  // Spacer(),
                  SizedBox(height: height * 0.04),
                  TextFieldDialog(
                    hintText: 'Nhập mức lương mong muốn',
                    textEditingController: controller.salaryWantTextEditingController,
                    keyboardType: TextInputType.number,
                    error: controller.checkValidSalary(),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  TextFieldDialog(
                    hintText: 'Nhập địa chỉ Email của bạn',
                    textEditingController: controller.yourEmailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    error: controller.checkValidEmail(),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.white3,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Đặt giá kết thúc ngày $dateEnd',
                        style: AppTextStyles.regularW400(context, size: 14, color: AppColors.blue2),
                      )),
                  // Spacer(flex: 3,),
                  SizedBox(height: height * 0.09),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.dealSalary();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 21, vertical: 15),
                            decoration: BoxDecoration(
                              color: AppColors.orange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                                child: Text(
                                  'Đặt giá',
                                  style: AppTextStyles.regularW500(context, size: 16, color: AppColors.white),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.salaryWantTextEditingController.clear();
                            controller.yourEmailTextEditingController.clear();
                            controller.checkDeal.value = false;
                            controller.checkDealer();
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
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
                  // Spacer(),
                ],
              ),
            ),
          )),
    );
  }
}
