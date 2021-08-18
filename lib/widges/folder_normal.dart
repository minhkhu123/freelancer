import 'package:album_app/common/images.dart';
import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FolderNormal extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool favorite;

  const FolderNormal({Key key, this.title, this.onPress, this.favorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: [
          Container(
            height: 300,
            width: width * 0.4,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: AppColors.blue1,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                favorite ? Image.asset(Images.favor_folder) : SvgPicture.asset(Images.folder),
                // Image.asset(Images.favor_folder),
                SizedBox(height: 10),
                Text(
                  title,
                  style: AppTextStyles.regularW400(context, size: 14, color: AppColors.black),
                ),
              ],
            ),
          ),
          Positioned(
            top: -2,
            right: 10,
            child: Container(height: 20, width: 20, child: SvgPicture.asset(Images.ic_delete)),
          ),
          Positioned(
            top: 0,
            left: 3,
            child: Container(
                height: 20,
                width: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.star_border,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
