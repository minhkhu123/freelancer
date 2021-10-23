import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/screens/authens/change_password/change_password_screen.dart';
import 'package:freelancer_app/screens/authens/ongoing_project/ongoing_project_controller.dart';
import 'package:freelancer_app/screens/authens/ongoing_project/ongoing_project_screen.dart';
import 'package:freelancer_app/screens/developing/developing_screen.dart';
import 'package:freelancer_app/widgets/dialog_logout.dart';
import 'package:freelancer_app/widgets/select_drop_list_management.dart';
import 'package:freelancer_app/widgets/selection.dart';
import 'package:freelancer_app/widgets/top_ongoing_project.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class CandidateProfileScreen extends StatefulWidget {
  CandidateProfileScreen({Key key}) : super(key: key);

  @override
  _CandidateProfileScreenState createState() => _CandidateProfileScreenState();
}

class _CandidateProfileScreenState extends State<CandidateProfileScreen> {
  DateTime currentBackPressTime;
  OnGoingProjectController controller = Get.put(OnGoingProjectController());

  final DropListModel listManagementModel = DropListModel(listItem: [
    OptionItem(id: 1, title: "Hoàn thiện hồ sơ"),
    OptionItem(id: 2, title: "Tất cả việc làm")
  ]);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopOnGoingProject(
                  onPress: () {
                    Get.back();
                  },
                  isBack: false,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: AppColors.blue),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      SelectDropListManagement(
                          listManagementModel: listManagementModel),
                      Selection(
                        icon: Images.send,
                        title: "Dự án đang thực hiện",
                        onPress: () {
                          controller.checkOnGoingProject = true;
                          controller.getProjectFreelancerIsDoing(token: SpUtil.getString(ConstString.token));
                          Get.to(OngoingProjectScreen());
                        },
                      ),
                      Selection(
                        icon: Images.ic_heart,
                        title: "Dự án đã lưu",
                        onPress: () {
                          controller.checkOnGoingProject = false;
                          controller.getProjectFreelanceSave(token: SpUtil.getString(ConstString.token));
                          Get.to(OngoingProjectScreen());
                        },
                      ),
                      Selection(
                        icon: Images.ic_pen,
                        title: "Kinh nghiệm Freelancer",
                        onPress: () {
                          Get.to(DevelopingScreen());
                        },
                      ),
                      Selection(
                        icon: Images.ic_key,
                        title: "Đổi mật khẩu",
                        onPress: () {
                          Get.to(ChangePasswordScreen(
                            checkWhoUr: true,
                          ));
                        },
                      ),
                      Selection(
                        icon: Images.ic_logout,
                        title: "Đăng xuất",
                        onPress: () {
                          Get.dialog(DialogLogOut());
                        },
                      )
                    ],
                  ),
                )
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
