import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/home/filter_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/card_job_freelancer.dart';
import 'package:freelancer_app/widgets/dialog_bid.dart';
import 'package:freelancer_app/widgets/dialog_login.dart';
import 'package:get/get.dart';

class ListJobScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteDot,
          appBar: AppBar(
            backgroundColor: AppColors.blue,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
            title: Text(
              'Danh sách tất cả công việc',
              style: AppTextStyles.regularW500(context, size: 18),
              overflow: TextOverflow.ellipsis,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GetBuilder<NavigationController>(
                init: NavigationController(),
                builder: (controller) => Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Get.to(FilterScreen());
                            },
                            child: SvgPicture.asset(Images.ic_console)),
                        controller.chooseCity.value
                            ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.white),
                          child: Text(
                            controller.nameCity.value,
                            style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                          ),
                        )
                            : Container(),
                        controller.chooseCareer.value
                            ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.white),
                          child: Text(
                            controller.nameCareer.value,
                            style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                          ),
                        )
                            : Container(),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          controller.chooseSkills.value
                              ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.white),
                            child: Text(
                              controller.nameSkills.value,
                              style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                            ),
                          )
                              : Container(),
                          controller.chooseForm.value
                              ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.white),
                            child: Text(
                              controller.nameForm.value,
                              style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                            ),
                          )
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: height * 0.75,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.713,
                            child: Scrollbar(
                              child: ListView.builder(
                                  itemCount: controller.listJob.length,
                                  itemBuilder: (context, index) {
                                    return CardJobFreelancer(
                                      title: controller.listJob[index].tenViecLam,
                                      urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                      money: controller.listJob[index].chiPhi,
                                      address: controller.listJob[index].diaDiem,
                                      career: 'Bán thời gian',
                                      check: true,
                                      turned: int.parse(controller.listJob[index].luotDatGia),
                                      dateClose:
                                      controller.listJob[index].hetHan,
                                      listSkill: controller.getSkillJob(index),
                                      onTapDeal: waitLoginController.checkLogin.value
                                          ? () {
                                        controller.indexIdJob.value =
                                            controller.listJob[index].idJob;
                                        Get.dialog(DialogBid(
                                          name: controller.listJob[index].tenViecLam,
                                          dateEnd: controller
                                              .listJob[index].hetHan,
                                        ));
                                      }
                                          : () {
                                        Get.dialog(DialogLogin());
                                      },
                                      onPress: () {
                                        controller.checkDetailProject.value = false;
                                        controller.checkDetailProjected();
                                        controller.indexIdJob.value =
                                            controller.listJob[index].idJob;
                                        controller.getDetailJob();
                                      },
                                    );
                                  }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onTap: () => controller.loadMoreJob(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Xem thêm',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  SvgPicture.asset(Images.ic_down),
                                ],
                              ),
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
        ));
  }
}
