import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class CustomEditTextFreelancerRecruitment extends StatelessWidget {
  final String hintText;
  final bool isIcon;
  final bool isSubText;
  final bool isReadOnly;
  final EdgeInsets padding;
  final int maxLines;
  final VoidCallback onPress;
  final dynamic id;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String value;
  final String textError;
  final FocusNode myFocusNode;
  final int maxLength;
  final List<TextInputFormatter> inputFormatters;

  CustomEditTextFreelancerRecruitment({
    Key key,
    this.hintText,
    this.id,
    this.isIcon = true,
    this.isReadOnly = true,
    this.padding,
    this.maxLines = 1,
    this.isSubText = false,
    this.onPress,
    this.controller,
    this.textInputType,
    this.value,
    this.textError,
    this.maxLength,
    this.myFocusNode,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding == null ? EdgeInsets.all(0) : padding,
      child: TextFormField(
        onTap: onPress,
        keyboardType: textInputType != null ? textInputType : null,
        controller: controller,
        readOnly: isReadOnly,
        minLines: 1,
        maxLines: maxLines,
        initialValue: value,
        focusNode: myFocusNode,
        style: AppTextStyles.regularW400(context, size: 15, color: AppColors.black),
        decoration: InputDecoration(
          counter: SizedBox.shrink(),
          errorText: textError,
          hintText: hintText,
          suffix: isSubText
              ? Text(
                  "VNĐ",
                  style: AppTextStyles.regularW400(context, size: 15, color: AppColors.black),
                )
              : null,
          hintStyle: AppTextStyles.regularW400(context, size: 15, color: id == null ? AppColors.hintText : AppColors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: isIcon
              ? IconButton(
                  icon: SvgPicture.asset(Images.ic_down),
                  onPressed: () {},
                )
              : null,
        ),
        maxLength: maxLength,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
