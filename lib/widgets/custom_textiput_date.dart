import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class CustomEditTextDateFreelancerRecruitment extends StatelessWidget {
  final String hintText;
  final EdgeInsets padding;
  final VoidCallback onPress;
  final String error;

  const CustomEditTextDateFreelancerRecruitment({
    Key key,
    this.hintText,
    this.padding,
    this.onPress,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding == null ? EdgeInsets.all(0) : padding,
      child: TextField(
        onTap: onPress,
          readOnly: true,
          style: AppTextStyles.regularW400(context,
              size: 15, color: AppColors.black),
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyles.regularW400(context,
                  size: 15,
                  color: hintText.contains('Chọn')
                      ? AppColors.grey5
                      : AppColors.black),
              errorText: error,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              suffixIcon: IconButton(
                icon: SvgPicture.asset(Images.ic_calendar),
                onPressed: onPress,
              ))),
    );
  }
}
