import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/home/more_job_freelancer_screen.dart';
import 'package:freelancer_app/screens/home/more_job_ntd_screen.dart';
import 'package:freelancer_app/screens/home/search_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/card_job_freelancer.dart';
import 'package:freelancer_app/widgets/card_job_ntd.dart';
import 'package:freelancer_app/widgets/dialog_bid.dart';
import 'package:freelancer_app/widgets/dialog_login.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // var convert0 = NumberFormat('###,###,###,###,###,##0', 'en_US');
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: AppColors.whiteDot,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GetBuilder<NavigationController>(
              init: NavigationController(),
              builder: (controller) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  InkWell(
                    onTap: waitLoginController.checkWhoUR.value
                        ? () {
                      print(waitLoginController.checkWhoUR.value);
                            controller.resetFilter();
                            controller.clearListSearch();
                            controller.getListJob();
                            // controller.checkWhoUR.value = waitLoginController.checkWhoUR.value;
                            navigationController.changePageOut(SearchScreen());
                          }
                        : () {
                      print(waitLoginController.checkWhoUR.value);
                            controller.resetFilter();
                            controller.clearListSearch();
                            controller.getListFreelancer();
                            // controller.checkWhoUR.value = waitLoginController.checkWhoUR.value;
                            navigationController.changePageOut(SearchScreen());
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: SvgPicture.asset(
                              Images.ic_search,
                              color: AppColors.hintText96,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          SizedBox(width: 10),
                          waitLoginController.checkWhoUR.value
                              ? Text(
                                  'T??m ki???m vi???c l??m, nh?? tuy???n d???ng',
                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.hintText96),
                                )
                              : Text(
                                  'T??m ki???m Freelancer',
                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.hintText96),
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    constraints: BoxConstraints(minHeight: 300),
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.blue,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: waitLoginController.checkWhoUR.value
                              ? Text(
                                  'Vi???c l??m Freelancer theo ng??nh ngh???',
                                  style: AppTextStyles.regularW500(context, size: 14),
                                )
                              : Text(
                                  'Freelancer l??m vi???c theo ng??nh ngh???',
                                  style: AppTextStyles.regularW500(context, size: 14),
                                ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Column(
                              children: [
                                InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 0;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 1;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'IT & L???p tr??nh';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 0;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 1;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'IT & L???p tr??nh';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.watchMore.value = true;
                                          controller.showWatchMore();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: customCareerTile(
                                    name: 'IT & L???p tr??nh',
                                    logo: SvgPicture.asset(Images.ic_it),
                                    color: controller.indexFreelancer.value == 0 ? AppColors.orange : AppColors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 3;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 7;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Video';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 3;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 7;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Video';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.watchMore.value = true;
                                          controller.showWatchMore();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: customCareerTile(
                                    name: 'Video',
                                    logo: SvgPicture.asset(Images.ic_video),
                                    color: controller.indexFreelancer.value == 3 ? AppColors.orange : AppColors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 6;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 19;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Kinh doanh';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 6;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 19;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Kinh doanh';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.watchMore.value = true;
                                          controller.showWatchMore();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: customCareerTile(
                                    name: 'Kinh doanh',
                                    logo: SvgPicture.asset(Images.ic_business),
                                    color: controller.indexFreelancer.value == 6 ? AppColors.orange : AppColors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 9;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 21;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'K??? to??n';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 9;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 21;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'K??? to??n';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.watchMore.value = true;
                                          controller.showWatchMore();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: customCareerTile(
                                    name: 'K??? to??n',
                                    logo: SvgPicture.asset(Images.ic_accounting),
                                    color: controller.indexFreelancer.value == 9 ? AppColors.orange : AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 1;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 2;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Thi???t k???';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 1;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 2;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Thi???t k???';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.watchMore.value = true;
                                          controller.showWatchMore();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: customCareerTile(
                                    name: 'Thi???t k???',
                                    logo: SvgPicture.asset(Images.ic_design),
                                    color: controller.indexFreelancer.value == 1 ? AppColors.orange : AppColors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 4;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 23;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Ki???n tr??c';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 4;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 23;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Ki???n tr??c';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.watchMore.value = true;
                                          controller.showWatchMore();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: customCareerTile(
                                    name: 'Ki???n tr??c',
                                    logo: SvgPicture.asset(Images.ic_construct),
                                    color: controller.indexFreelancer.value == 4 ? AppColors.orange : AppColors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 7;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 24;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'X??y d???ng';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 7;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 24;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'X??y d???ng';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.watchMore.value = true;
                                          controller.showWatchMore();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: customCareerTile(
                                    name: 'X??y d???ng',
                                    logo: SvgPicture.asset(Images.ic_build),
                                    color: controller.indexFreelancer.value == 7 ? AppColors.orange : AppColors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 10;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 22;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Lu???t';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 10;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 22;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Lu???t';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.watchMore.value = true;
                                          controller.showWatchMore();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: customCareerTile(
                                    name: 'Lu???t',
                                    logo: SvgPicture.asset(Images.ic_loyer),
                                    color: controller.indexFreelancer.value == 10 ? AppColors.orange : AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 2;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 17;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Vi???t l??ch';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 2;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 17;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Vi???t l??ch';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.watchMore.value = true;
                                          controller.showWatchMore();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: customCareerTile(
                                    name: 'Vi???t l??ch',
                                    logo: SvgPicture.asset(Images.ic_write),
                                    color: controller.indexFreelancer.value == 2 ? AppColors.orange : AppColors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 5;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 18;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'D???ch thu???t';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 5;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 18;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'D???ch thu???t';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.watchMore.value = true;
                                          controller.showWatchMore();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: customCareerTile(
                                    name: 'D???ch thu???t',
                                    logo: SvgPicture.asset(Images.ic_note),
                                    color: controller.indexFreelancer.value == 5 ? AppColors.orange : AppColors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 8;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 20;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Nh???p li???u';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 8;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 20;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'Nh???p li???u';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.watchMore.value = true;
                                          controller.showWatchMore();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: customCareerTile(
                                    name: 'Nh???p li???u',
                                    logo: SvgPicture.asset(Images.ic_input),
                                    color: controller.indexFreelancer.value == 8 ? AppColors.orange : AppColors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 11;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 8;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'L??nh v???c kh??c';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 11;
                                          controller.checkIndexFreelancer();
                                          controller.indexCategory.value = 8;
                                          controller.checkCategory();
                                          controller.nameCareer.value = 'L??nh v???c kh??c';
                                          controller.chooseCareer.value = true;
                                          controller.listTag.clear();
                                          controller.chooseSkills.value = false;
                                          controller.showSkills();
                                          controller.getTagFromCategory(controller.indexCategory.value);
                                          controller.showCareer();
                                          controller.watchMore.value = true;
                                          controller.showWatchMore();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: customCareerTile(
                                    name: 'L??nh v???c kh??c',
                                    logo: SvgPicture.asset(Images.ic_another),
                                    color: controller.indexFreelancer.value == 11 ? AppColors.orange : AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(height: 30)
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              waitLoginController.checkWhoUR.value
                                  ? Text(
                                      'Vi???c l??m Freelancer theo d??? ??n',
                                      style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                                    )
                                  : Text(
                                      'Freelancer m???i nh???t',
                                      style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                                    ),
                              Spacer(),
                              InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 12;
                                          controller.checkIndexFreelancer();
                                          controller.indexOrderByValue.value = 1;
                                          controller.checkIndexOrderByValue();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 12;
                                          controller.checkIndexFreelancer();
                                          controller.indexOrderByValue.value = 1;
                                          controller.checkIndexOrderByValue();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: Text(
                                    'Xem th??m',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        waitLoginController.checkWhoUR.value
                            ? Container(
                                constraints: BoxConstraints(minHeight: 100),
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.listJobProjectHome.length,
                                  itemBuilder: (context, index) => CardJobFreelancer(
                                    title: controller.listJobProjectHome[index].ten,
                                    urlImage: controller.listJobProjectHome[index].logo,
                                    money: controller.listJobProjectHome[index].chiPhi,
                                    address: controller.listJobProjectHome[index].noiLamViec,
                                    career: 'D??? ??n',
                                    check: false,
                                    listSkill: navigationController.getSkillJobByProject(index),
                                    onTapDeal: waitLoginController.checkLogin.value
                                        ? () {
                                            controller.indexIdJob.value = controller.listJobProjectHome[index].id;
                                            Get.dialog(DialogBid(
                                              name: controller.listJobProjectHome[index].ten,
                                              dateEnd: controller.listJobProjectHome[index].datGiaKt,
                                            ));
                                          }
                                        : () {
                                            Get.dialog(DialogLogin());
                                          },
                                    onPress: () {
                                      controller.checkDetailProject.value = false;
                                      controller.checkDetailProjected();
                                      controller.indexIdJob.value = controller.listJobProjectHome[index].id;
                                      controller.getDetailJob();
                                    },
                                  ),
                                ))
                            : Container(
                                constraints: BoxConstraints(minHeight: 100),
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.listFreelancerLatestHome.length,
                                  itemBuilder: (context, index) => CardJobNTD(
                                    name: controller.listFreelancerLatestHome[index].hoTen,
                                    urlImage: controller.listFreelancerLatestHome[index].path + controller.listFreelancerLatestHome[index].avatar,
                                    address: controller.listFreelancerLatestHome[index].diaChi ?? '',
                                    job: controller.listFreelancerLatestHome[index].ngheNghiep,
                                    rateStar: double.parse(controller.listFreelancerLatestHome[index].rateStar.toString()),
                                    exp: controller.listFreelancerLatestHome[index].kinhNghiem,
                                    career: 'M???i nh???t',
                                    phoneCall: controller.listFreelancerLatestHome[index].sdt,
                                    userId: controller.listFreelancerLatestHome[index].maUser,
                                    viewed: controller.listFreelancerLatestHome[index].viewed,
                                    check: false,
                                    checkButton: true,
                                    listSkill: navigationController.getSkillLatestOfFreelancer(index, 4),
                                    onPress: () {
                                      controller.indexIdFreelancer.value = controller.listFreelancerLatestHome[index].maUser;
                                      controller.detailFreelancer();
                                    },
                                  ),
                                ))
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              waitLoginController.checkWhoUR.value
                                  ? Text(
                                      'Vi???c l??m Freelancer b??n th???i gian',
                                      style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                                    )
                                  : Text(
                                      'Freelancer n???i b???t nh???t',
                                      style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                                    ),
                              Spacer(),
                              InkWell(
                                  onTap: waitLoginController.checkWhoUR.value
                                      ? () {
                                          controller.indexFreelancer.value = 13;
                                          controller.checkIndexFreelancer();
                                          controller.indexOrderByValue.value = 2;
                                          controller.checkIndexOrderByValue();
                                          controller.getListJob();
                                          Get.to(MoreJobFreelancerScreen());
                                        }
                                      : () {
                                          controller.indexFreelancer.value = 13;
                                          controller.checkIndexFreelancer();
                                          controller.indexOrderByValue.value = 2;
                                          controller.checkIndexOrderByValue();
                                          controller.getListFreelancer();
                                          Get.to(MoreJobNTDScreen());
                                        },
                                  child: Text(
                                    'Xem th??m',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        waitLoginController.checkWhoUR.value
                            ? Container(
                                constraints: BoxConstraints(minHeight: 100),
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.listJobPartimeHome.length,
                                  itemBuilder: (context, index) => CardJobFreelancer(
                                    title: controller.listJobPartimeHome[index].ten,
                                    urlImage: controller.listJobPartimeHome[index].logo,
                                    money: controller.listJobPartimeHome[index].chiPhi,
                                    address: controller.listJobPartimeHome[index].noiLamViec,
                                    career: 'BTG',
                                    check: false,
                                    listSkill: navigationController.getSkillJobByTime(index),
                                    onTapDeal: waitLoginController.checkLogin.value
                                        ? () {
                                            controller.indexIdJob.value = controller.listJobPartimeHome[index].id;
                                            Get.dialog(DialogBid(
                                              name: controller.listJobPartimeHome[index].ten,
                                              dateEnd: controller.listJobPartimeHome[index].datGiaKt,
                                            ));
                                          }
                                        : () {
                                            Get.dialog(DialogLogin());
                                          },
                                    onPress: () {
                                      controller.checkDetailProject.value = false;
                                      controller.checkDetailProjected();
                                      controller.indexIdJob.value = controller.listJobPartimeHome[index].id;
                                      controller.getDetailJob();
                                    },
                                  ),
                                ))
                            : Container(
                                constraints: BoxConstraints(minHeight: 100),
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.listFreelancerOutstandingHome.length,
                                  itemBuilder: (context, index) => CardJobNTD(
                                    name: controller.listFreelancerOutstandingHome[index].hoTen,
                                    urlImage:
                                        controller.listFreelancerOutstandingHome[index].path + controller.listFreelancerOutstandingHome[index].avatar,
                                    address: controller.listFreelancerOutstandingHome[index].diaChi,
                                    job: controller.listFreelancerOutstandingHome[index].ngheNghiep,
                                    rateStar: double.parse(controller.listFreelancerOutstandingHome[index].rateStar.toString()),
                                    exp: controller.listFreelancerOutstandingHome[index].kinhNghiem,
                                    career: 'N???i b???t nh???t',
                                    phoneCall: controller.listFreelancerOutstandingHome[index].sdt,
                                    userId: controller.listFreelancerOutstandingHome[index].maUser,
                                    viewed: controller.listFreelancerOutstandingHome[index].viewed,
                                    check: false,
                                    checkButton: true,
                                    listSkill: navigationController.getSkillOutstandingOfFreelancer(index, 2),
                                    onPress: () {
                                      controller.indexIdFreelancer.value = controller.listFreelancerOutstandingHome[index].maUser;
                                      controller.detailFreelancer();
                                    },
                                  ),
                                ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Future<void> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Utils.showToast('B???m tr??? v??? l???n n???a ????? tho??t app');
      return Future.value();
    }
    return Future.value(exit(0));
  }
}

class customCareerTile extends StatelessWidget {
  final String name;
  final SvgPicture logo;
  final Color color;
  final isColorText;

  const customCareerTile({Key key, @required this.name, @required this.logo, @required this.color, this.isColorText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          logo,
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            height: 4,
            width: width * 0.2,
            decoration: BoxDecoration(
              color: color,
            ),
          ),
          Text(
            name,
            style: AppTextStyles.regularW400(context, size: 14, color: isColorText ? AppColors.black3 : AppColors.white),
          ),
        ],
      ),
    );
  }
}
