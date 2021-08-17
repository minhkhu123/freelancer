import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FolderNormal extends StatelessWidget {
  final String title;
  final VoidCallback onPress;

  const FolderNormal({Key key, this.title, this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height * 0.07,
        width: width * 0.4,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: AppColors.blue1,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SvgPicture.asset(Images.folder),
            // Image.asset(Images.favor_folder),
            SizedBox(height: 10),
            Text(title,style: AppTextStyles.regularW400(context, size: 14,color: AppColors.black),),
          ],
        ),
      ),
    );
  }
}
