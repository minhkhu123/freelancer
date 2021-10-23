import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/latest_jobs_listing/latest_jobs_listing_controller.dart';
import 'package:freelancer_app/widgets/item_list_freelances_setting_new_sprice.dart';
import 'package:freelancer_app/widgets/item_list_lastest_job_listtings.dart';
import 'package:freelancer_app/widgets/top_employer_profile.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class LatestJobsListingScreen extends StatelessWidget {
  const LatestJobsListingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<LatestJobsListingController>(
          init: LatestJobsListingController(),
          builder: (controller) => ListView(
            children: [
              TopEmployerProfile(
                onPress: () {
                  Get.back();
                },
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
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
                        "Danh sách việc làm mới nhất",
                        style: AppTextStyles.regularW500(context, size: 19),
                      ),
                    ),
                    controller.listLatestJobs.isEmpty
                        ? Container(
                            height: height * 0.45,
                            child: Center(
                              child: Text(
                                controller.messageNotificationLatestJobs,
                                style: AppTextStyles.regularW700(context,
                                    size: 16, color: AppColors.black),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  children: List.generate(
                                      controller.listLatestJobs.length,
                                      (index) => ItemListLatestJobListings(
                                            element: controller
                                                .listLatestJobs[index],
                                          )),
                                ),
                              ),
                              controller.messageNotificationLatestJobs.isEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                              child: Text(
                                                "Xem thêm",
                                                style:
                                                    AppTextStyles.regularW700(
                                                        context,
                                                        size: 15,
                                                        color:
                                                            AppColors.orange),
                                              ),
                                              onTap: () {
                                                controller
                                                    .countLoadTimeLatestJobs
                                                    .value++;
                                                controller.getLatestJobsListing(
                                                    token: SpUtil.getString(ConstString.token),
                                                    xemThem: controller
                                                        .countLoadTimeLatestJobs
                                                        .value);
                                              },
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
                              SizedBox(height: 15)
                            ],
                          )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
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
                        "Danh sách Freelancer đặt giá mới...",
                        style: AppTextStyles.regularW500(context, size: 18),
                      ),
                    ),
                    controller.listSetLatestPrice.isEmpty
                        ? Container(
                            height: height * 0.45,
                            child: Center(
                              child: Text(
                                controller.messageNotificationLatestPrice,
                                style: AppTextStyles.regularW700(context,
                                    size: 16, color: AppColors.black),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                //height: (item1 < 2) ? height * 0.432 : height * 0.5,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  children: List.generate(
                                      controller.listSetLatestPrice.length,
                                      (index) =>
                                          ItemListFreelancerSettingNewSprice(
                                            datGia: controller
                                                .listSetLatestPrice[index],
                                          )),
                                ),
                              ),
                              controller.messageNotificationLatestPrice.isEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .countLoadTimeLatestPrice
                                                    .value++;
                                                controller
                                                    .getFreelanceSetLatestPrice(
                                                        token: SpUtil.getString(ConstString.token),
                                                        xemThem: controller
                                                            .countLoadTimeLatestPrice
                                                            .value);
                                              },
                                              child: Text(
                                                "Xem thêm",
                                                style:
                                                    AppTextStyles.regularW700(
                                                        context,
                                                        size: 15,
                                                        color:
                                                            AppColors.orange),
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
                              SizedBox(height: 15)
                            ],
                          ),
                  ],
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
