import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class FileWith extends StatelessWidget {
  final String link;

  const FileWith({
    Key key,
    this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SvgPicture.asset(Images.ic_file_lock),
          SizedBox(width: 9),
          Text(
            link,
            style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
          ),
        ],
      ),
    );
  }
}