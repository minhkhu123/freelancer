import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/screens/authens/ongoing_project/ongoing_project_controller.dart';
import 'package:freelancer_app/widgets/item_list_ongoing_project.dart';
import 'package:freelancer_app/widgets/item_list_save_project.dart';
import 'package:freelancer_app/widgets/top_ongoing_project.dart';
import 'package:get/get.dart';

import '../../../common/theme/app_color.dart';
import '../../../common/theme/app_text_style.dart';

class OngoingProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<OnGoingProjectController>(
          init: OnGoingProjectController(),
          builder: (controller) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopOnGoingProject(
                    onPress: controller.checkOnGoingProject
                        ? () {
                            controller.listJob.clear();
                            Get.back();
                          }
                        : () {
                            controller.listProjectSave.clear();
                            Get.back();
                          }),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: AppColors.blue),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            )),
                        child: Text(
                          controller.checkOnGoingProject ? "Dự án đang thực hiện" : "Dự án đã lưu",
                          style: AppTextStyles.regularW500(context, size: 20),
                        ),
                      ),
                      controller.checkOnGoingProject
                          ? Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: controller.listJob.isEmpty
                                  ? Container(
                                        height: height * 0.45,
                                        child: Center(
                                          child: Text(
                                            'Không có dự án nào đang được thực hiện',
                                            style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),
                                          ),
                                        ),
                                      )
                                  : Column(
                                      children: [
                                        for (var item in controller.listJob)
                                          ItemListOnGoingProject(
                                            itemListJob: item,
                                            onGoingProjectController: controller,
                                            index: controller.listJob.indexOf(item),
                                          ),
                                        controller.listJob.isEmpty
                                            ? Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      InkWell(
                                                        child: Text(
                                                          "Xem thêm",
                                                          style: AppTextStyles.regularW700(context, size: 15, color: AppColors.orange),
                                                        ),
                                                        onTap: controller.loadTimeListJob,
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
                                            : SizedBox()
                                      ],
                                    ),
                            )
                          : Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: controller.listProjectSave.isEmpty
                                  ? Container(
                                      height: height * 0.45,
                                      child: Center(
                                        child: Text(
                                          "Bạn chưa lưu việc làm nào",
                                          style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),
                                        ),
                                      ),
                                    )
                                  : Column(children: [
                                      for (var item in controller.listProjectSave) ItemListSaveProject(result: item),
                                      controller.listProjectSave.isEmpty
                                          ? Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      child: Text(
                                                        "Xem thêm",
                                                        style: AppTextStyles.regularW700(context, size: 15, color: AppColors.orange),
                                                      ),
                                                      onTap: controller.loadTimeSavedProject,
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
                                          : SizedBox()
                                    ]),
                            ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                WillPopScope(
                  onWillPop: controller.checkOnGoingProject
                      ? () {
                    controller.listJob.clear();
                    Get.back();
                  }
                      : () {
                    controller.listProjectSave.clear();
                    Get.back();
                  },
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
