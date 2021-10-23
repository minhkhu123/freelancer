import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/routes/app_routes.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/home/more_job_freelancer_screen.dart';
import 'package:freelancer_app/screens/menu/list_freelancer.dart';
import 'package:freelancer_app/screens/menu/menu_controller.dart';
import 'package:freelancer_app/screens/menu/post_project_screen.dart';
import 'package:freelancer_app/screens/menu/tutorial_freelancer_screen.dart';
import 'package:freelancer_app/screens/menu/tutorial_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  DateTime currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: GetBuilder<MenuController>(
              init: MenuController(),
              builder: (controller) => waitLoginController.checkWhoUR.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.indexMenuFlc.value = 1;
                            controller.checkIndexMenuFlc();
                            controller.showJobFreelancer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Text(
                                  'Việc làm Freelancer',
                                  style: AppTextStyles.regularW700(context,
                                      size: 18, color: controller.indexMenuFlc.value == 1 ? AppColors.orange : AppColors.black),
                                ),
                                Spacer(),
                                SvgPicture.asset(Images.ic_down),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.greyDivider,
                        ),
                        controller.showJobFreelance.value
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: InkWell(
                                      onTap: () {
                                        navigationController.indexFreelancer.value = 12;
                                        navigationController.checkIndexFreelancer();
                                        navigationController.indexOrderByValue.value = 1;
                                        navigationController.checkIndexOrderByValue();
                                        navigationController.getListJob();
                                        Get.toNamed(Routes.MORE_JOB_FREELANCER);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                          'Việc làm Freelancer theo dự án',
                                          style: AppTextStyles.regularW400(context, size: 14, color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: InkWell(
                                      onTap: () {
                                        navigationController.indexFreelancer.value = 13;
                                        navigationController.checkIndexFreelancer();
                                        navigationController.indexOrderByValue.value = 2;
                                        navigationController.checkIndexOrderByValue();
                                        navigationController.getListJob();
                                        Get.to(() => MoreJobFreelancerScreen());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                          'Việc làm Freelancer bán thời gian',
                                          style: AppTextStyles.regularW400(context, size: 14, color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        controller.showJobFreelance.value
                            ? Divider(
                                thickness: 1,
                                color: AppColors.greyDivider,
                              )
                            : Container(),
                        InkWell(
                          onTap: () {
                            controller.indexMenuFlc.value = 2;
                            controller.checkIndexMenuFlc();
                            navigationController.changePageOut(TutorialFreelancerScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Hướng dẫn',
                              style: AppTextStyles.regularW700(context,
                                  size: 18, color: controller.indexMenuFlc.value == 2 ? AppColors.orange : AppColors.black),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            navigationController.resetFilter();
                            navigationController.clearListSearch();
                            navigationController.getListFreelancer();
                            controller.indexMenuNTD.value = 1;
                            controller.checkIndexMenuNTD();
                            Get.to(ListFreelancerScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              'Danh sách Freelancer',
                              style: AppTextStyles.regularW700(context,
                                  size: 18, color: controller.indexMenuNTD.value == 1 ? AppColors.orange : AppColors.black),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.greyDivider,
                        ),
                        InkWell(
                          onTap: () {
                            controller.indexMenuNTD.value = 2;
                            controller.checkIndexMenuNTD();
                            navigationController.changePageOut(TutorialScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Hướng dẫn',
                              style: AppTextStyles.regularW700(context,
                                  size: 18, color: controller.indexMenuNTD.value == 2 ? AppColors.orange : AppColors.black),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.greyDivider,
                        ),
                        InkWell(
                          onTap: () {
                            controller.indexMenuNTD.value = 3;
                            controller.checkIndexMenuNTD();
                            navigationController.changePageOut(PostProjectScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'Đăng dự án',
                              style: AppTextStyles.regularW700(context,
                                  size: 18, color: controller.indexMenuNTD.value == 3 ? AppColors.orange : AppColors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
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
