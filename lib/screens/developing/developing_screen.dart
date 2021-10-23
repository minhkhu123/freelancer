
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class DevelopingScreen extends StatelessWidget {
  const DevelopingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 200, right: 20, left: 20,bottom: 300),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: AppColors.blue
          ),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.only(top: 60, bottom: 30),child: Center(child: Text('Thông báo', style: AppTextStyles.regularW500(context, size: 24,color: AppColors.black),))),
            SvgPicture.asset(Images.ic_growth),
            SizedBox(height: 30),
            Text('Chức năng đang được phát triển', style: AppTextStyles.regularW400(context, size: 15, color: AppColors.black),)
          ],
        ),
      ),
    );
  }
}
