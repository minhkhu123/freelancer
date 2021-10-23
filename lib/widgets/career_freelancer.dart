import 'package:flutter/material.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class CareerFreelancer extends StatelessWidget {
  final String name;
  final VoidCallback onPress;

  const CareerFreelancer({
    Key key,
    this.name,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 25,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        margin: EdgeInsets.only(right: 7),
        decoration: BoxDecoration(
          color: AppColors.white2,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.grey),
        ),
        child: Center(
            child: Text(
              name,
              style: AppTextStyles.regularW400(context, size: 13, color: AppColors.grey3),
            )),
      ),
    );
  }
}
