import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/theme/app_color.dart';
import '../common/theme/app_text_style.dart';

class CustomTextFieldOnGoingProject extends StatelessWidget {
  final String text;
  final double height;
  final String icon;

  CustomTextFieldOnGoingProject({this.text, this.height, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.orange,
      width: MediaQuery.of(context).size.width * 0.31,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: (icon != null)? 75 : 111,
            child: Text(
              text,
              style: AppTextStyles.regularW700(context, size: 16),
              textAlign: TextAlign.center,
            ),
          ),
          (icon != null) ? SvgPicture.asset(icon) : SizedBox()
        ],
      ),
    );
  }
}
