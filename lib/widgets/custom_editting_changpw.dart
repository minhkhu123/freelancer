import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';

class CustomEditTextChangePW extends StatelessWidget {
  final bool isEye;
  final VoidCallback changeEyePW;
  final String textError;
  final TextEditingController controller;
  final String hintText;

  const CustomEditTextChangePW({
    Key key,
    this.isEye,
    this.changeEyePW,
    this.textError,
    this.controller,
    this.hintText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        obscureText: isEye,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
            hintText: hintText,
            suffixIcon: IconButton(
              icon: isEye
                  ? SvgPicture.asset(Images.ic_eye, color: AppColors.blue)
                  : SvgPicture.asset(Images.ic_eye_close),
              onPressed: changeEyePW,
            ),
            errorText: textError),
      ),
    );
  }
}
