import 'package:flutter/material.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/candidate/introduce_yourself/introduce_yourself_controller.dart';
import 'package:freelancer_app/widgets/custom_textfield_changpw.dart';
import 'package:freelancer_app/widgets/custom_textinput_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/rectangle.dart';
import 'package:freelancer_app/widgets/select_drop_list.dart';
import 'package:freelancer_app/widgets/top_ongoing_project.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class IntroduceYourselfScreen extends StatelessWidget {
  IntroduceYourselfScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<IntroduceYourselfController>(
            init: IntroduceYourselfController(),
            builder: (controller) => Column(
              children: [
                TopOnGoingProject(
                  onPress: (){
                    Get.back();
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 2, color: AppColors.blue)),
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 8,
                          ),
                          child: Text(
                            "... / Giới thiệu bản thân",
                            style: AppTextStyles.regularW500(context, size: 18),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              child: Rectangle(
                                height: 30,
                                title: "Giới thiệu bản thân",
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                            ),
                            CustomTextFieldChangPW(
                              text: "Kinh nghiệm làm việc",
                            ),
                            SelectDropList(
                              paddingVertical: 0,
                              itemList: controller.selectedExp,
                              list: controller.listExp.listItem,
                              index: 1,
                              currentIndex: controller.currentIndex,
                              onOption: (item) {
                                controller.changeSelected(item);
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Giới thiệu bản thân",
                              style: AppTextStyles.regularW700(context,
                                  size: 16, color: AppColors.black),
                            ),
                            CustomEditTextFreelancerRecruitment(
                              isIcon: false,
                              isReadOnly: false,
                              maxLines: 20,
                              controller: controller.introduceController,
                              padding: const EdgeInsets.only(top: 10, bottom: 30),
                            ),
                            Center(
                              child: Container(
                                width: width * 0.35,
                                height: height * 0.05,
                                margin: const EdgeInsets.only(bottom: 30),
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.updateIntro(token: SpUtil.getString(ConstString.token), expWork: controller.selectedExp.id.toString(), introSelf: controller.textIntro);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                          AppColors.orange)),
                                  child: Text(
                                    "Cập nhật",
                                    style: AppTextStyles.regularW700(context,
                                        size: 17),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
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
}
