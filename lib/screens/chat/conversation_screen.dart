import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/chat/chat_controller.dart';
import 'package:freelancer_app/widgets/message_tile.dart';
import 'package:get/get.dart';

class ConversationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: GetBuilder<ChatController>(
          init: ChatController(),
          builder: (controller) => Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18,vertical: 6),
                color: AppColors.lightBlue,
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
                        Row(
                          children: [
                            Text('Hoàng Đăng',style: AppTextStyles.regularW700(context, size: 20,color: AppColors.black),),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text('Vừa mới truy cập',style: AppTextStyles.regularW400(context, size: 14,color: AppColors.black3),),
                      ],
                    ),
                    Spacer(),
                   GestureDetector(
                     onTap: () => Get.back(),
                       child: Container(
                         padding: EdgeInsets.all(7),
                           child: SvgPicture.asset(Images.ic_close_chat))),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: controller.isChat.value ? 7 : 9,
                child: Container(
                  height: height * 0.66,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        MessageTile('Xin chào Nguyễn Thu Quỳnh, tôi muốn liên hệ với bạn để tìm hiểu về công việc của bạn đang tìm kiếm', false),
                        MessageTile('Xin chào', true),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: controller.isChat.value ? 3 : 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: height*0.3,
                        width: controller.isChat.value ? width*0.88 : width*0.73,
                        // padding: EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          focusNode: controller.focusNode,
                          // onChanged: (value) {
                          // },
                          keyboardType: TextInputType.text,
                          maxLines: 40,
                          // controller: textEditingController,
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.hintText),
                          decoration: InputDecoration(
                            hintText: 'Nhập nội dung',
                            hintStyle: TextStyle(color: AppColors.hintText),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                            suffixIcon: IconButton(
                              icon: SvgPicture.asset(Images.ic_send_mess),
                              onPressed: () {},
                            ),
                            prefixIcon: IconButton(
                              icon: SvgPicture.asset(Images.ic_emoji),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                      controller.isChat.value ? Container() : Container(
                        height: 45,
                        width: 45,
                        margin: EdgeInsets.only(left: 11),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.greyEC,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: SvgPicture.asset(Images.ic_document,height: 30,width: 25,),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
