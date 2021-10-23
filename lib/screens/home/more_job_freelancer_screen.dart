import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class MoreJobFreelancerScreen extends StatelessWidget {
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
            navigationController.resetFilter();
            navigationController.clearList();
            Get.back();
          },
        ),
        title: navigationController.indexFreelancer.value == 12
            ? Text(
                'Việc làm Freelancer theo dự án',
                style: AppTextStyles.regularW500(context, size: 18),
              )
            : navigationController.indexFreelancer.value == 13
                ? Text(
                    'Việc làm Freelancer bán thời gian',
                    style: AppTextStyles.regularW500(context, size: 18),
                  )
                : Text(
                    'Việc làm Freelancer theo ngành nghề',
                    style: AppTextStyles.regularW500(context, size: 18),
                  ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GetBuilder<NavigationController>(
            init: NavigationController(),
            builder: (controller) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  SizedBox(height: 15),
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
                  SizedBox(height: 22),
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
                          child: controller.indexFreelancer.value == 0
                              ? Scrollbar(
                                  child: ListView.builder(
                                      itemCount: controller.listJob.length,
                                      itemBuilder: (context, index) {
                                        return CardJobFreelancer(
                                          title: controller.listJob[index].tenViecLam,
                                          urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                          money: controller.listJob[index].chiPhi,
                                          address: controller.listJob[index].diaDiem,
                                          career: 'IT & Lập trình',
                                          check: true,
                                          turned: int.parse(controller.listJob[index].luotDatGia),
                                          dateClose: controller.listJob[index].hetHan,
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
                                          onPress: () {
                                            controller.checkDetailProject.value = false;
                                            controller.checkDetailProjected();
                                            controller.indexIdJob.value = controller.listJob[index].idJob;
                                            controller.getDetailJob();
                                          },
                                        );
                                      }),
                                )
                              : controller.indexFreelancer.value == 1
                                  ? Scrollbar(
                                      child: ListView.builder(
                                          itemCount: controller.listJob.length,
                                          itemBuilder: (context, index) {
                                            return CardJobFreelancer(
                                              title: controller.listJob[index].tenViecLam,
                                              urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                              money: controller.listJob[index].chiPhi,
                                              address: controller.listJob[index].diaDiem,
                                              career: 'Thiết kế',
                                              check: true,
                                              turned: int.parse(controller.listJob[index].luotDatGia),
                                              dateClose: controller.listJob[index].hetHan,
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
                                              onPress: () {
                                                controller.checkDetailProject.value = false;
                                                controller.checkDetailProjected();
                                                controller.indexIdJob.value = controller.listJob[index].idJob;
                                                controller.getDetailJob();
                                              },
                                            );
                                          }),
                                    )
                                  : controller.indexFreelancer.value == 2
                                      ? Scrollbar(
                                          child: ListView.builder(
                                              itemCount: controller.listJob.length,
                                              itemBuilder: (context, index) {
                                                return CardJobFreelancer(
                                                  title: controller.listJob[index].tenViecLam,
                                                  urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                                  money: controller.listJob[index].chiPhi,
                                                  address: controller.listJob[index].diaDiem,
                                                  career: 'Viết lách',
                                                  check: true,
                                                  turned: int.parse(controller.listJob[index].luotDatGia),
                                                  dateClose: controller.listJob[index].hetHan,
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
                                                  onPress: () {
                                                    controller.checkDetailProject.value = false;
                                                    controller.checkDetailProjected();
                                                    controller.indexIdJob.value = controller.listJob[index].idJob;
                                                    controller.getDetailJob();
                                                  },
                                                );
                                              }),
                                        )
                                      : controller.indexFreelancer.value == 3
                                          ? Scrollbar(
                                              child: ListView.builder(
                                                  itemCount: controller.listJob.length,
                                                  itemBuilder: (context, index) {
                                                    return CardJobFreelancer(
                                                      title: controller.listJob[index].tenViecLam,
                                                      urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                                      money: controller.listJob[index].chiPhi,
                                                      address: controller.listJob[index].diaDiem,
                                                      career: 'Video',
                                                      check: true,
                                                      turned: int.parse(controller.listJob[index].luotDatGia),
                                                      dateClose: controller.listJob[index].hetHan,
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
                                                      onPress: () {
                                                        controller.checkDetailProject.value = false;
                                                        controller.checkDetailProjected();
                                                        controller.indexIdJob.value = controller.listJob[index].idJob;
                                                        controller.getDetailJob();
                                                      },
                                                    );
                                                  }),
                                            )
                                          : controller.indexFreelancer.value == 4
                                              ? Scrollbar(
                                                  child: ListView.builder(
                                                      itemCount: controller.listJob.length,
                                                      itemBuilder: (context, index) {
                                                        return CardJobFreelancer(
                                                          title: controller.listJob[index].tenViecLam,
                                                          urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                                          money: controller.listJob[index].chiPhi,
                                                          address: controller.listJob[index].diaDiem,
                                                          career: 'Kiến trúc',
                                                          check: true,
                                                          turned: int.parse(controller.listJob[index].luotDatGia),
                                                          dateClose: controller.listJob[index].hetHan,
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
                                                          onPress: () {
                                                            controller.checkDetailProject.value = false;
                                                            controller.checkDetailProjected();
                                                            controller.indexIdJob.value = controller.listJob[index].idJob;
                                                            controller.getDetailJob();
                                                          },
                                                        );
                                                      }),
                                                )
                                              : controller.indexFreelancer.value == 5
                                                  ? Scrollbar(
                                                      child: ListView.builder(
                                                          itemCount: controller.listJob.length,
                                                          itemBuilder: (context, index) {
                                                            return CardJobFreelancer(
                                                              title: controller.listJob[index].tenViecLam,
                                                              urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                                              money: controller.listJob[index].chiPhi,
                                                              address: controller.listJob[index].diaDiem,
                                                              career: 'Dịch thuật',
                                                              check: true,
                                                              turned: int.parse(controller.listJob[index].luotDatGia),
                                                              dateClose: controller.listJob[index].hetHan,
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
                                                              onPress: () {
                                                                controller.checkDetailProject.value = false;
                                                                controller.checkDetailProjected();
                                                                controller.indexIdJob.value = controller.listJob[index].idJob;
                                                                controller.getDetailJob();
                                                              },
                                                            );
                                                          }),
                                                    )
                                                  : controller.indexFreelancer.value == 6
                                                      ? Scrollbar(
                                                          child: ListView.builder(
                                                              itemCount: controller.listJob.length,
                                                              itemBuilder: (context, index) {
                                                                return CardJobFreelancer(
                                                                  title: controller.listJob[index].tenViecLam,
                                                                  urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                                                  money: controller.listJob[index].chiPhi,
                                                                  address: controller.listJob[index].diaDiem,
                                                                  career: 'Kinh doanh',
                                                                  check: true,
                                                                  turned: int.parse(controller.listJob[index].luotDatGia),
                                                                  dateClose: controller.listJob[index].hetHan,
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
                                                                  onPress: () {
                                                                    controller.checkDetailProject.value = false;
                                                                    controller.checkDetailProjected();
                                                                    controller.indexIdJob.value = controller.listJob[index].idJob;
                                                                    controller.getDetailJob();
                                                                  },
                                                                );
                                                              }),
                                                        )
                                                      : controller.indexFreelancer.value == 7
                                                          ? Scrollbar(
                                                              child: ListView.builder(
                                                                  itemCount: controller.listJob.length,
                                                                  itemBuilder: (context, index) {
                                                                    return CardJobFreelancer(
                                                                      title: controller.listJob[index].tenViecLam,
                                                                      urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                                                      money: controller.listJob[index].chiPhi,
                                                                      address: controller.listJob[index].diaDiem,
                                                                      career: 'Xây dựng',
                                                                      check: true,
                                                                      turned: int.parse(controller.listJob[index].luotDatGia),
                                                                      dateClose: controller.listJob[index].hetHan,
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
                                                                      onPress: () {
                                                                        controller.checkDetailProject.value = false;
                                                                        controller.checkDetailProjected();
                                                                        controller.indexIdJob.value = controller.listJob[index].idJob;
                                                                        controller.getDetailJob();
                                                                      },
                                                                    );
                                                                  }),
                                                            )
                                                          : controller.indexFreelancer.value == 8
                                                              ? Scrollbar(
                                                                  child: ListView.builder(
                                                                      itemCount: controller.listJob.length,
                                                                      itemBuilder: (context, index) {
                                                                        return CardJobFreelancer(
                                                                          title: controller.listJob[index].tenViecLam,
                                                                          urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                                                          money: controller.listJob[index].chiPhi,
                                                                          address: controller.listJob[index].diaDiem,
                                                                          career: 'Nhập liệu',
                                                                          check: true,
                                                                          turned: int.parse(controller.listJob[index].luotDatGia),
                                                                          dateClose: controller.listJob[index].hetHan,
                                                                          listSkill: controller.getSkillJob(index),
                                                                          onTapDeal: waitLoginController.checkLogin.value
                                                                              ? () {
                                                                                  controller.indexIdJob.value =
                                                                                      controller.listJob[index].idJob;
                                                                                  Get.dialog(DialogBid(
                                                                                    name: controller.listJob[index].tenViecLam,
                                                                                    dateEnd: controller.listJob[index].hetHan,
                                                                                  ));
                                                                                }
                                                                              : () {
                                                                                  Get.dialog(DialogLogin());
                                                                                },
                                                                          onPress: () {
                                                                            controller.checkDetailProject.value = false;
                                                                            controller.checkDetailProjected();
                                                                            controller.indexIdJob.value = controller.listJob[index].idJob;
                                                                            controller.getDetailJob();
                                                                          },
                                                                        );
                                                                      }),
                                                                )
                                                              : controller.indexFreelancer.value == 9
                                                                  ? Scrollbar(
                                                                      child: ListView.builder(
                                                                          itemCount: controller.listJob.length,
                                                                          itemBuilder: (context, index) {
                                                                            return CardJobFreelancer(
                                                                              title: controller.listJob[index].tenViecLam,
                                                                              urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                                                              money: controller.listJob[index].chiPhi,
                                                                              address: controller.listJob[index].diaDiem,
                                                                              career: 'Kế toán',
                                                                              check: true,
                                                                              turned: int.parse(controller.listJob[index].luotDatGia),
                                                                              dateClose: controller.listJob[index].hetHan,
                                                                              listSkill: controller.getSkillJob(index),
                                                                              onTapDeal: waitLoginController.checkLogin.value
                                                                                  ? () {
                                                                                      controller.indexIdJob.value =
                                                                                          controller.listJob[index].idJob;
                                                                                      Get.dialog(DialogBid(
                                                                                        name: controller.listJob[index].tenViecLam,
                                                                                        dateEnd:
                                                                                            controller.listJob[index].hetHan,
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
                                                                    )
                                                                  : controller.indexFreelancer.value == 10
                                                                      ? Scrollbar(
                                                                          child: ListView.builder(
                                                                              itemCount: controller.listJob.length,
                                                                              itemBuilder: (context, index) {
                                                                                return CardJobFreelancer(
                                                                                  title: controller.listJob[index].tenViecLam,
                                                                                  urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                                                                  money: controller.listJob[index].chiPhi,
                                                                                  address: controller.listJob[index].diaDiem,
                                                                                  career: 'Luật',
                                                                                  check: true,
                                                                                  turned: int.parse(controller.listJob[index].luotDatGia),
                                                                                  dateClose: controller.listJob[index].hetHan,
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
                                                                        )
                                                                      : controller.indexFreelancer.value == 11
                                                                          ? Scrollbar(
                                                                              child: ListView.builder(
                                                                                  itemCount: controller.listJob.length,
                                                                                  itemBuilder: (context, index) {
                                                                                    return CardJobFreelancer(
                                                                                      title: controller.listJob[index].tenViecLam,
                                                                                      urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                                                                      money: controller.listJob[index].chiPhi,
                                                                                      address: controller.listJob[index].diaDiem,
                                                                                      career: 'Lĩnh vực khác',
                                                                                      check: true,
                                                                                      turned: int.parse(controller.listJob[index].luotDatGia),
                                                                                      dateClose: controller.listJob[index].hetHan,
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
                                                                            )
                                                                          : controller.indexFreelancer.value == 12
                                                                              ? Scrollbar(
                                                                                  child: ListView.builder(
                                                                                      itemCount: controller.listJob.length,
                                                                                      itemBuilder: (context, index) {
                                                                                        return CardJobFreelancer(
                                                                                          title: controller.listJob[index].tenViecLam,
                                                                                          urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                                                                          money: controller.listJob[index].chiPhi,
                                                                                          address: controller.listJob[index].diaDiem,
                                                                                          career: 'Dự án',
                                                                                          check: true,
                                                                                          turned: int.parse(controller.listJob[index].luotDatGia),
                                                                                          listSkill: controller.getSkillJob(index),
                                                                                          dateClose:
                                                                                              controller.listJob[index].hetHan,
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
                                                                                )
                                                                              : Scrollbar(
                                                                                  child: ListView.builder(
                                                                                      itemCount: controller.listJob.length,
                                                                                      itemBuilder: (context, index) {
                                                                                        return CardJobFreelancer(
                                                                                          title: controller.listJob[index].tenViecLam,
                                                                                          urlImage: controller.listJob[index].pathLogo + controller.listJob[index].anhLogo,
                                                                                          money: controller.listJob[index].chiPhi,
                                                                                          address: controller.listJob[index].diaDiem,
                                                                                          career: 'BTG',
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
                            onTap: () => controller.indexFreelancer.value == 12
                                ? controller.loadMoreJob()
                                : controller.indexFreelancer.value == 13
                                    ? controller.loadMoreJob()
                                    : controller.loadMoreJob(),
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
                  WillPopScope(
                    onWillPop: () {
                      navigationController.resetFilter();
                      navigationController.clearList();
                      Get.back();
                    },
                    child: Container(),
                  )
                ],
              ),
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
