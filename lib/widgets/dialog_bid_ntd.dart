import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/chat/chat_not_use.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';

class DialogBidNTD extends StatelessWidget {
  final VoidCallback onPressCall;

  const DialogBidNTD({Key key, this.onPressCall}) : super(key: key);

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
            height: height * 0.4,
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Text(
                    'Liên hệ',
                    style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black2),
                  ),
                ),
                Divider(
                  color: AppColors.line,
                  thickness: 0.5,
                ),
                SizedBox(height: 20),
                Text(
                  'Liên hệ với Freelancer qua',
                  style: AppTextStyles.regularW400(context, size: 15, color: AppColors.black),
                ),
                Spacer(),
                InkWell(
                  onTap: onPressCall,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 11),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.grey),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          color: AppColors.blue,
                        ),
                        Text(
                          'Số điện thoại',
                          style: AppTextStyles.regularW500(context, size: 16, color: AppColors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Get.back();
                    controller.changePageOut(ChatNotUse());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 15),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Images.ic_chat,
                          color: AppColors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Chat với Freelancer',
                          style: AppTextStyles.regularW500(context, size: 16, color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          )),
    );
  }
}
