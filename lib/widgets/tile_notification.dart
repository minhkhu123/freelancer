import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class TileNotification extends StatelessWidget {
  const TileNotification({
    Key key,
    this.urlAvatar,
    this.name,
    this.textNotify,
    this.timeNotify,
  }) : super(key: key);

  final String urlAvatar;
  final String name;
  final String textNotify;
  final String timeNotify;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              height: 42,
              width: 42,
              imageUrl: urlAvatar,
              placeholder: (context, url) => SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                backgroundColor: AppColors.grey6,
                child: SvgPicture.asset(
                  Images.logo_user,
                  height: 42,
                  width: 42,
                  color: AppColors.white2,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(text: TextSpan(
                  text: name,style: AppTextStyles.regularW700(context, size: 14,color: AppColors.black),
                  children: [
                    TextSpan(
                      text: textNotify,
                      style: AppTextStyles.regularW400(context, size: 14,color: AppColors.black),
                    )
                  ]
              )),
              SizedBox(height: 5),
              Text(timeNotify,style: AppTextStyles.regularW400(context, size: 12,color: AppColors.black6),)
            ],
          )
        ],
      ),
    );
  }
}