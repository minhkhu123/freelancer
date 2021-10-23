import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils.dart';
 class ChatNotUse extends StatefulWidget {
  @override
  _ChatNotUseState createState() => _ChatNotUseState();
}

class _ChatNotUseState extends State<ChatNotUse> {
  DateTime currentBackPressTime;
   @override
   Widget build(BuildContext context) {
     var height = MediaQuery.of(context).size.height;
     return WillPopScope(
       onWillPop: () => onWillPop(),
       child: Scaffold(
         backgroundColor: AppColors.white,
         body: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             SizedBox(height: height * 0.3),
             Center(child: Text('Thông báo',style: AppTextStyles.regularW500(context, size: 24,color: AppColors.black),)),
             SizedBox(height: 30),
             SvgPicture.asset(Images.chat_not_use),
             SizedBox(height: 31),
             Text('Chức năng đang được phát triển',style: AppTextStyles.regularW400(context, size: 20,color: AppColors.black46),),
           ],
         ),
       ),
     );
   }

   Future<void> onWillPop() {
     DateTime now = DateTime.now();
     if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
       currentBackPressTime = now;
       Utils.showToast('Bấm trở về lần nữa để thoát app');
       return Future.value();
     }
     return Future.value(exit(0));
   }
}
