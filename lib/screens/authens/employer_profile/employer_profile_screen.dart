import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/screens/authens/message_posted/message_posted_screen.dart';
import 'package:freelancer_app/screens/home/search_screen.dart';
import 'package:freelancer_app/screens/latest_jobs_listing/latest_jobs_listing_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/select_drop_list_account_management.dart';
import 'package:freelancer_app/widgets/select_drop_list_records_management.dart';
import 'package:freelancer_app/widgets/select_drop_listfreelancer.dart';
import 'package:freelancer_app/widgets/top_employer_profile.dart';
import 'package:get/get.dart';

class EmployerProfileScreen extends StatefulWidget {
  @override
  _EmployerProfileScreenState createState() => _EmployerProfileScreenState();
}

class _EmployerProfileScreenState extends State<EmployerProfileScreen> {
  DateTime currentBackPressTime;
  NavigationController navigationController = Get.put(NavigationController());

  String s;

  final DropListModel _listFreelancerModels = DropListModel(
    listItem: [
      OptionItem(id: 1, title: "Đăng việc theo dự án"),
      OptionItem(id: 2, title: "Đăng việc bán thời gian")
    ],
  );

  final DropListModel _listRecordsManagementModels = DropListModel(listItem: [
    OptionItem(id: 1, title: "Freelancer đặt giá"),
    OptionItem(id: 2, title: "Freelancer đang làm việc"),
    OptionItem(id: 3, title: "Freelancer đã lưu"),
  ]);

  final DropListModel _listAccountManagementModels = DropListModel(listItem: [
    OptionItem(id: 1, title: 'Cập nhật thông tin'),
    OptionItem(id: 2, title: 'Đổi mật khẩu'),
    OptionItem(id: 3, title: 'Đăng xuất'),
  ]);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopEmployerProfile(
                  isBack: false,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: AppColors.blue),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Get.to(LatestJobsListingScreen());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                          decoration: BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                  colors: [AppColors.lightBlue, AppColors.blue],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                          child: Row(
                            children: [
                              SvgPicture.asset(Images.menu),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Quản lý chung",
                                style: AppTextStyles.regularW500(context, size: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Column(
                          children: [
                            SelectDrlFreelancer(
                              listFreelancerModel: _listFreelancerModels,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(MessagePostedScreen());
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(Images.dangTin),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 10),
                                    child: Text(
                                      "Tin đã đăng",
                                      style: AppTextStyles.regularW400(context,
                                          size: 16, color: AppColors.black3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                navigationController.searchTextEditingController.clear();
                                navigationController.clearListSearch();
                                navigationController.getListFreelancer();
                                navigationController.changePageOut(SearchScreen());
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(Images.timFreelancer),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 10),
                                    child: Text(
                                      "Tìm kiếm Freelancer",
                                      style: AppTextStyles.regularW400(context,
                                          size: 16, color: AppColors.black3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SelectDropListRecordsManagement(
                              listRecordsManagementModel:
                                  _listRecordsManagementModels,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SelectDropListAccountManagement(
                              listAccountManagementModel:
                                  _listAccountManagementModels,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
