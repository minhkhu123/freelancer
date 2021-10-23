import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class Selection extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onPress;
  const Selection({Key key, @required this.icon, @required this.title, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25,left: 13),
      child: InkWell(
        onTap: onPress,
        child: Row(
          children: [
            SvgPicture.asset(icon),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Text(
                title,
                style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
