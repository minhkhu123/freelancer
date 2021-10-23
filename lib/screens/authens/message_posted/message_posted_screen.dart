import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/message_posted/message_posted_controller.dart';
import 'package:freelancer_app/widgets/item_list_message_posted.dart';
import 'package:freelancer_app/widgets/top_employer_profile.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class MessagePostedScreen extends StatelessWidget {
  const MessagePostedScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<MessagePostedController>(
          init: MessagePostedController(),
          builder: (controller) => SingleChildScrollView(
            child: Column(
              children: [
                TopEmployerProfile(
                  onPress: () {
                    Get.back();
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16,bottom: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 2, color: AppColors.blue)),
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15,
                          ),
                          child: Text(
                            "Tin đã đăng",
                            style: AppTextStyles.regularW500(context, size: 19),
                          ),
                        ),
                      ),
                      controller.listPostedNew.isEmpty
                          ? Obx(
                          () => Container(
                            height: height * 0.47,
                            child: Center(
                              child: Text(
                                controller.messageError.value,
                                style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),
                              ),
                            ),
                          )
                      )
                          : Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    children: List.generate(
                                        controller.listPostedNew.length,
                                        (index) => ItemListMessagePosted(
                                              postedNew: controller.listPostedNew[index],
                                            )),
                                  ),
                                ),
                                Obx(
                                  () => controller.messageError.value.isEmpty
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller.countLoadTime.value++;
                                                    controller.getPostNews(
                                                        token: SpUtil.getString(ConstString.token), xemThem: controller.countLoadTime.value);
                                                  },
                                                  child: Text(
                                                    "Xem thêm",
                                                    style: AppTextStyles.regularW700(context, size: 15, color: AppColors.orange),
                                                  ),
                                                ),
                                                Container(
                                                  height: 2,
                                                  width: 65,
                                                  color: AppColors.orange,
                                                  child: Text(" "),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            SvgPicture.asset(Images.ic_doubleDown)
                                          ],
                                        )
                                      : SizedBox(),
                                ),
                                SizedBox(height: 15)
                              ],
                            )
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
