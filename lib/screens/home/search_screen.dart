import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/home/filter_screen.dart';
import 'package:freelancer_app/screens/menu/menu_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/card_job_freelancer.dart';
import 'package:freelancer_app/widgets/card_job_ntd.dart';
import 'package:freelancer_app/widgets/custom_textfield_search.dart';
import 'package:freelancer_app/widgets/dialog_bid.dart';
import 'package:freelancer_app/widgets/dialog_login.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    RegisterController registerController = Get.put(RegisterController());
    MenuController menuController = Get.put(MenuController());
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: waitLoginController.checkWhoUR.value
                      ? CustomTextFieldSearch(
                          hintText: 'Tìm kiếm việc làm, nhà tuyển dụng',
                          textEditingController: controller.searchTextEditingController,
                          focusNode: controller.focusNode,
                          onPressed: () {
                            controller.clearListSearch();
                            controller.getListJob();
                          },
                        )
                      : CustomTextFieldSearch(
                          hintText: 'Tìm kiếm Freelancer',
                          textEditingController: controller.searchTextEditingController,
                          focusNode: controller.focusNode,
                        ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.to(FilterScreen());
                        },
                        child: SvgPicture.asset(Images.ic_console)),
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
                SizedBox(height: 10),
                Container(
                    // height: height * 0.55,
                    constraints: BoxConstraints(
                      minHeight: 100,
                      maxHeight: height * 0.65,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.62,
                          child: waitLoginController.checkWhoUR.value
                              ? ListView.builder(
                            shrinkWrap: true,
                                  itemCount: controller.listJob.length,
                                  itemBuilder: (context, index) {
                                    return CardJobFreelancer(
                                      urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                      title: controller.listJob[index].tenViecLam,
                                      address: controller.listJob[index].diaDiem,
                                      money: controller.listJob[index].chiPhi,
                                      dateClose: controller.listJob[index].hetHan,
                                      career: controller.listJob[index].loaiViecLam,
                                      listSkill: controller.getSkillJob(index),
                                      onTapDeal: waitLoginController.checkLogin.value
                                          ? () {
                                              controller.indexIdJob.value = controller.listJob[index].idJob;
                                              Get.dialog(DialogBid(
                                                name: controller.listJob[index].tenViecLam,
                                                dateEnd: controller.listJob[index].hetHan,
                                              ));
                                            }
                                          : () {
                                              Get.dialog(DialogLogin());
                                            },
                                      check: true,
                                      turned: int.parse(controller.listJob[index].luotDatGia),
                                      onPress: () {
                                        controller.checkDetailProject.value = false;
                                        controller.checkDetailProjected();
                                        controller.indexIdJob.value = controller.listJob[index].idJob;
                                        controller.getDetailJob();
                                      },
                                    );
                                  })
                              : ListView.builder(
                            shrinkWrap: true,
                                  itemCount: controller.listFreelancer.length,
                                  itemBuilder: (context, index) => CardJobNTD(
                                    urlImage: controller.listFreelancer[index].path + controller.listFreelancer[index].avatar,
                                    name: controller.listFreelancer[index].hoTen,
                                    address: controller.listFreelancer[index].diaChi,
                                    job: controller.listFreelancer[index].ngheNghiep,
                                    exp: controller.listFreelancer[index].kinhNghiem,
                                    career: 'Kỹ năng',
                                    phoneCall: controller.listFreelancer[index].sdt,
                                    userId: controller.listFreelancer[index].maUser,
                                    viewed: controller.listFreelancer[index].viewed,
                                    rateStar: double.parse(controller.listFreelancer[index].rateStar.toString()),
                                    listSkill: controller.getSkillFreelancer(index, 2),
                                    check: false,
                                    checkButton: true,
                                    onPress: () {
                                      controller.indexIdFreelancer.value = controller.listFreelancer[index].maUser;
                                      controller.detailFreelancer();
                                    },
                                  ),
                                ),
                        ),
                        InkWell(
                          onTap: waitLoginController.checkWhoUR.value
                              ? () {
                                  controller.loadMoreJob();
                                }
                              : () {
                                  controller.loadMoreFreelancer();
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Xem thêm',
                                style: AppTextStyles.regularW400(context, size: 11, color: AppColors.black),
                              ),
                              SizedBox(width: 5),
                              SvgPicture.asset(Images.ic_down),
                            ],
                          ),
                        )
                      ],
                    )),
                WillPopScope(
                  onWillPop: () {
                    controller.changePage(0);
                    controller.isBackApp.value = true;
                  },
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class tagMostFounded extends StatelessWidget {
  final String name;
  final Color color;

  const tagMostFounded({
    Key key,
    this.name,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: color), color: AppColors.white),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SvgPicture.asset(
              Images.ic_tag,
              color: color,
            ),
            SizedBox(width: 10),
            Text(
              name,
              style: AppTextStyles.regularW500(context, size: 14, color: color),
            )
          ],
        ),
      ),
    );
  }
}
