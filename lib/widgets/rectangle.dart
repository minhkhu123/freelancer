import 'package:flutter/material.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class Rectangle extends StatelessWidget {
  final double height;
  final String title;
  const Rectangle({Key key, this.height, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: height,
          width: 6,
          color: AppColors.orange,
          child: Text(" "),
        ),
        SizedBox(width: 15,),
        Expanded(
          child: Text(title,
          style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
          ),
        ),
      ],
    );
  }
}
