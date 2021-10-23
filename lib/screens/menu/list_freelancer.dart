import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/home/filter_screen.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/card_job_freelancer.dart';
import 'package:freelancer_app/widgets/card_job_ntd.dart';
import 'package:freelancer_app/widgets/drop_list_model_freelancer.dart';
import 'package:freelancer_app/widgets/select_drop_list_freelancer.dart';
import 'package:get/get.dart';

class ListFreelancerScreen extends StatefulWidget {
  @override
  _ListFreelancerScreenState createState() => _ListFreelancerScreenState();
}

class _ListFreelancerScreenState extends State<ListFreelancerScreen> {
  @override
  Widget build(BuildContext context) {
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
          'Danh sách Freelancer',
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
                              itemCount: controller.listFreelancer.length,
                              itemBuilder: (context, index) {
                                return CardJobNTD(
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
                                    controller.clearListCongViecDaDang();
                                    controller.indexIdFreelancer.value = controller.listFreelancer[index].maUser;
                                    controller.listTopFlc.clear();
                                    Get.back();
                                    Get.back();
                                    controller.detailFreelancer();
                                  },
                                );
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () => controller.loadMoreFreelancer(),
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

class filterJob extends StatelessWidget {
  final String name;

  const filterJob({
    Key key,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      constraints: BoxConstraints(maxWidth: width * 0.4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        name,
        style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
