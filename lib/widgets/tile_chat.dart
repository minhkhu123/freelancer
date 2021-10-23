import 'package:flutter/material.dart';
import 'package:freelancer_app/screens/chat/conversation_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class TileChat extends StatelessWidget {
  const TileChat({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    return Padding(padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: InkWell(
        onTap: () => Get.to(ConversationScreen()),
        child: Row(
          children: [
            Stack(
              children: [
                Image.asset(Images.logo_user,height: 60,width: 60,),
                Positioned(
                    top: 43,
                    left: 43,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: AppColors.greenOnline,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColors.white,width: 2),
                      ),
                    ))
              ],
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hoàng Đăng',style: AppTextStyles.regularW700(context, size: 16,color: AppColors.black),),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text('Xin chào Nguyễn Thu Quỳnh',style: AppTextStyles.regularW400(context, size: 14,color: AppColors.black3),),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 3,
                      width: 3,
                      decoration: BoxDecoration(
                        color: AppColors.black3,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    Text('14:00',style: AppTextStyles.regularW400(context, size: 14,color: AppColors.black3),),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}