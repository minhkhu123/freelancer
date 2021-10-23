import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/tile_notification.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/screens/notification/notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  DateTime currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: SingleChildScrollView(
        child: GetBuilder<NotificationController>(
          init: NotificationController(),
          builder: (controller) => Column(
            children: [
              Container(
                height: height*0.8,
                child: waitLoginController.checkWhoUR.value ? ListView.builder(
                  itemCount: controller.listNotifyCandidate.length,
                    itemBuilder: (context, index) => TileNotification(
                      urlAvatar: controller.listNotifyCandidate[index].linkAvt,
                      name: controller.listNotifyCandidate[index].name,
                      textNotify: controller.listNotifyCandidate[index].textNotify,
                      timeNotify: controller.listNotifyCandidate[index].timeNotify,
                    )
                ) : ListView.builder(
                    itemCount: controller.listNotifyCompany.length,
                    itemBuilder: (context, index) => TileNotification(
                      urlAvatar: controller.listNotifyCompany[index].linkAvt,
                      name: controller.listNotifyCompany[index].name,
                      textNotify: controller.listNotifyCompany[index].textNotify,
                      timeNotify: controller.listNotifyCompany[index].timeNotify,
                    )
                ),
              ),
              InkWell(
                onTap: () {
                  waitLoginController.checkWhoUR.value ? controller.deleteNotifyCandidate() : controller.deleteNotifyCompany();
                },
                child: Container(
                  height: height*0.05,
                  width: width*0.7,
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(child: Text('Xóa tất cả thông báo',style: AppTextStyles.regularW500(context, size: 15),),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Utils.showToast('Bấm trở về lần nữa để thoát app');
      return Future.value();
    }
    return Future.value(exit(0));
  }
}
