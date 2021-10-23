import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/card_job_freelancer.dart';
import 'package:freelancer_app/widgets/dialog_bid.dart';
import 'package:freelancer_app/widgets/dialog_login.dart';
import 'package:get/get.dart';

class ListJobBySkill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.whiteDot,
          appBar: AppBar(
            backgroundColor: AppColors.blue,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                navigationController.clearList();
                Get.back();
              },
            ),
            title: Text(
              'Việc làm Freelancer',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    // height: height * 0.55,
                    constraints: BoxConstraints(
                      minHeight: 100,
                      maxHeight: height * 0.87,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.84,
                          child: ListView.builder(
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
                              }),
                        ),
                        InkWell(
                          onTap: () {
                            controller.loadMoreJob();
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
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
