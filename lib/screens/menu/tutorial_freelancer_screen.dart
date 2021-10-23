import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/menu/post_project_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';

class TutorialFreelancerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        height: 28,
                        width: 5,
                        decoration: BoxDecoration(
                          color: AppColors.orange,
                        ),
                      ),
                      SizedBox(width: 14),
                      Text(
                        'Hướng dẫn Freelancer đặt giá',
                        style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                      ),
                    ],
                  ),
                  Text('Sau khi xem thông tin chi tiết của công việc bạn muốn đặt giá\nPhía dưới thông tin của công việc, bạn hãy điền thông tin vào theo hướng dẫn sau:',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: AppColors.grey78,height: 1.4)),
                  SizedBox(height: 20),
                  Image.asset(Images.tutorial_pic_4),
                  SizedBox(height: 30),
                  WillPopScope(
                    onWillPop: () {
                      navigationController.changePage(4);
                      navigationController.isBackApp.value = true;
                    },
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
