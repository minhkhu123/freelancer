import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/chat/chat_not_use.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';

class CommentSalary extends StatelessWidget {
  const CommentSalary({
    Key key,
    this.urlAvatar,
    this.name,
    this.job,
    this.rate,
    this.deal,
    this.desc,
    this.onPress,
  }) : super(key: key);

  final String name;
  final String job;
  final String deal;
  final double rate;
  final String desc;
  final String urlAvatar;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: onPress,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: urlAvatar,
                      height: 83,
                      width: 83,
                      placeholder: (context, url) => SizedBox(
                        child: CircularProgressIndicator(),
                        width: 72,
                        height: 72,
                      ),
                      errorWidget: (context, url, error) => SvgPicture.asset(
                        Images.logo_user,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: onPress,
                      child: Text(
                        name,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: AppColors.black),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          job,
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.blue),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                            onTap: () => controller.changePageOut(ChatNotUse()),
                            child: SvgPicture.asset(Images.ic_chat)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Đặt giá:',
                style: AppTextStyles.regularW400(context, size: 14, color: AppColors.black),
              ),
              SizedBox(width: 9),
              Text(
                '$dealđ',
                style: AppTextStyles.regularW400(context, size: 14, color: AppColors.green),
              ),
              SizedBox(width: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  '${controller.rate.value}',
                  style: AppTextStyles.regularW700(context, size: 12),
                ),
              ),
              SizedBox(width: 11),
              RatingBar.builder(
                initialRating: rate,
                itemSize: 20,
                minRating: 0,
                ignoreGestures: true,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                unratedColor: AppColors.greyBorder,
                onRatingUpdate: (rating) {
                  controller.rate.value = rating;
                  controller.updateRate();
                  print(rating);
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Text(
              desc,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.grey6B, height: 1.4),
            ),
          ),
          // Text('(Xem thêm)',style: AppTextStyles.regularW400(context, size: 14,color: AppColors.blue2),),
          SizedBox(height: 10),
          Divider(
            thickness: 0.5,
            color: AppColors.grey,
          )
        ],
      ),
    );
  }
}
