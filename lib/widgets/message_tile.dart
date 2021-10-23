import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/chat/chat_controller.dart';
import 'package:get/get.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    return InkWell(
        onDoubleTap: () {
          isSendByMe ? null : chatController.checkIsLiked();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isSendByMe
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Stack(
                      children: [
                        Image.asset(
                          Images.logo_user,
                          height: 42,
                          width: 42,
                        ),
                        Positioned(
                            top: 30,
                            left: 30,
                            child: Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                color: AppColors.greenOnline,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: AppColors.white, width: 2),
                              ),
                            ))
                      ],
                    ),
                  ),
            Container(
              padding: EdgeInsets.only(left: isSendByMe ? 0 : 10, right: isSendByMe ? 10 : 0),
              margin: EdgeInsets.only(bottom: 15),
              width: isSendByMe ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.8,
              alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 9),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          color: isSendByMe ? AppColors.lightBlue : AppColors.chatYour,
                          borderRadius: isSendByMe ? BorderRadius.circular(10) : BorderRadius.circular(10)),
                      child: Text(message, style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black)),
                    ),
                  ),
                  chatController.isLiked.value ? isSendByMe ? Container() : SvgPicture.asset(Images.ic_like_chat) : Container(),
                ],
              ),
            ),
          ],
        ));
  }
}
