import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/home/filter_screen.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/home/watch_detail_freelancer_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/card_job_freelancer.dart';
import 'package:freelancer_app/widgets/card_job_ntd.dart';
import 'package:freelancer_app/widgets/drop_list_model_freelancer.dart';
import 'package:freelancer_app/widgets/select_drop_list_freelancer.dart';
import 'package:get/get.dart';

class MoreJobNTDScreen extends StatefulWidget {
  @override
  _MoreJobNTDScreenState createState() => _MoreJobNTDScreenState();
}

class _MoreJobNTDScreenState extends State<MoreJobNTDScreen> {
  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
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
                      'Freelancer mới nhất',
                      style: AppTextStyles.regularW500(context, size: 18),
                      overflow: TextOverflow.ellipsis,
                    )
                  : navigationController.indexFreelancer.value == 13
                      ? Text(
                          'Freelancer nổi bật',
                          style: AppTextStyles.regularW500(context, size: 18),
                          overflow: TextOverflow.ellipsis,
                        )
                      : Text(
                          'Freelancer làm việc theo ngành nghề',
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
                builder: (controller) => Column(children: [
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.watchMore.value
                              ? SelectDropListFreelancer(
                                  controller.optionItemSelectedFreelancer,
                                  controller.dropListModelFreelancer,
                                  (optionItem) {
                                    controller.optionItemSelectedFreelancer = optionItem;
                                    controller.changeOrderByValue();
                                    controller.listFreelancer.clear();
                                    controller.getListFreelancer();
                                    setState(() {});
                                  },
                                )
                              : Container(),
                          Container(
                            height: controller.watchMore.value ? height * 0.59 : height * 0.713,
                            child: controller.indexFreelancer.value == 0
                                ? Scrollbar(
                                    child: ListView.builder(
                                        itemCount: controller.listFreelancer.length,
                                        itemBuilder: (context, index) {
                                          return CardJobNTD(
                                            name: controller.listFreelancer[index].hoTen,
                                            address: controller.listFreelancer[index].diaChi,
                                            urlImage: controller.listFreelancer[index].path + controller.listFreelancer[index].avatar,
                                            job: controller.listFreelancer[index].ngheNghiep,
                                            exp: controller.listFreelancer[index].kinhNghiem,
                                            check: true,
                                            checkButton: true,
                                            rateStar: controller.listFreelancer[index].rateStar,
                                            career: 'IT & Lập trình',
                                            phoneCall: controller.listFreelancer[index].sdt,
                                            userId: controller.listFreelancer[index].maUser,
                                            viewed: controller.listFreelancer[index].viewed,
                                            listSkill: controller.getSkillFreelancer(index, 2),
                                            onPress: () {
                                              controller.indexIdFreelancer.value = controller.listFreelancer[index].maUser;
                                              controller.detailFreelancer();
                                            },
                                          );
                                        }),
                                  )
                                : controller.indexFreelancer.value == 1
                                    ? Scrollbar(
                                        child: ListView.builder(
                                            itemCount: controller.listFreelancer.length,
                                            itemBuilder: (context, index) {
                                              return CardJobNTD(
                                                name: controller.listFreelancer[index].hoTen,
                                                address: controller.listFreelancer[index].diaChi,
                                                urlImage: controller.listFreelancer[index].path + controller.listFreelancer[index].avatar,
                                                job: controller.listFreelancer[index].ngheNghiep,
                                                exp: controller.listFreelancer[index].kinhNghiem,
                                                check: true,
                                                checkButton: true,
                                                rateStar: double.parse(controller.listFreelancer[index].rateStar.toString()),
                                                career: 'Thiết kế',
                                                phoneCall: controller.listFreelancer[index].sdt,
                                                userId: controller.listFreelancer[index].maUser,
                                                viewed: controller.listFreelancer[index].viewed,
                                                listSkill: controller.getSkillFreelancer(index, 2),
                                                onPress: () {
                                                  controller.indexIdFreelancer.value = controller.listFreelancer[index].maUser;
                                                  controller.detailFreelancer();
                                                },
                                              );
                                            }),
                                      )
                                    : controller.indexFreelancer.value == 2
                                        ? Scrollbar(
                                            child: ListView.builder(
                                                itemCount: controller.listFreelancer.length,
                                                itemBuilder: (context, index) {
                                                  return CardJobNTD(
                                                    name: controller.listFreelancer[index].hoTen,
                                                    address: controller.listFreelancer[index].diaChi,
                                                    urlImage: controller.listFreelancer[index].path + controller.listFreelancer[index].avatar,
                                                    job: controller.listFreelancer[index].ngheNghiep,
                                                    exp: controller.listFreelancer[index].kinhNghiem,
                                                    check: true,
                                                    checkButton: true,
                                                    rateStar: double.parse(controller.listFreelancer[index].rateStar.toString()),
                                                    career: 'Viết lách',
                                                    phoneCall: controller.listFreelancer[index].sdt,
                                                    userId: controller.listFreelancer[index].maUser,
                                                    viewed: controller.listFreelancer[index].viewed,
                                                    listSkill: controller.getSkillFreelancer(index, 2),
                                                    onPress: () {
                                                      controller.indexIdFreelancer.value = controller.listFreelancer[index].maUser;
                                                      controller.detailFreelancer();
                                                    },
                                                  );
                                                }),
                                          )
                                        : controller.indexFreelancer.value == 3
                                            ? Scrollbar(
                                                child: ListView.builder(
                                                    itemCount: controller.listFreelancer.length,
                                                    itemBuilder: (context, index) {
                                                      return CardJobNTD(
                                                        name: controller.listFreelancer[index].hoTen,
                                                        address: controller.resultFreelancer.data.listFlc[index].diaChi != null ? controller.listFreelancer[index].diaChi : '',
                                                        urlImage: controller.listFreelancer[index].path + controller.listFreelancer[index].avatar,
                                                        job: controller.listFreelancer[index].ngheNghiep,
                                                        exp: controller.listFreelancer[index].kinhNghiem,
                                                        check: true,
                                                        checkButton: true,
                                                        rateStar: double.parse(controller.listFreelancer[index].rateStar.toString()),
                                                        career: 'Video',
                                                        phoneCall: controller.listFreelancer[index].sdt,
                                                        userId: controller.listFreelancer[index].maUser,
                                                        viewed: controller.listFreelancer[index].viewed,
                                                        listSkill: controller.getSkillFreelancer(index, 2),
                                                        onPress: () {
                                                          controller.indexIdFreelancer.value = controller.listFreelancer[index].maUser;
                                                          controller.detailFreelancer();
                                                        },
                                                      );
                                                    }),
                                              )
                                            : controller.indexFreelancer.value == 4
                                                ? Scrollbar(
                                                    child: ListView.builder(
                                                        itemCount: controller.listFreelancer.length,
                                                        itemBuilder: (context, index) {
                                                          return CardJobNTD(
                                                            name: controller.listFreelancer[index].hoTen,
                                                            address: controller.listFreelancer[index].diaChi,
                                                            urlImage: controller.listFreelancer[index].path + controller.listFreelancer[index].avatar,
                                                            job: controller.listFreelancer[index].ngheNghiep,
                                                            exp: controller.listFreelancer[index].kinhNghiem,
                                                            check: true,
                                                            checkButton: true,
                                                            rateStar: double.parse(controller.listFreelancer[index].rateStar.toString()),
                                                            career: 'Kiến trúc',
                                                            phoneCall: controller.listFreelancer[index].sdt,
                                                            userId: controller.listFreelancer[index].maUser,
                                                            viewed: controller.listFreelancer[index].viewed,
                                                            listSkill: controller.getSkillFreelancer(index, 2),
                                                            onPress: () {
                                                              controller.indexIdFreelancer.value = controller.listFreelancer[index].maUser;
                                                              controller.detailFreelancer();
                                                            },
                                                          );
                                                        }),
                                                  )
                                                : controller.indexFreelancer.value == 5
                                                    ? Scrollbar(
                                                        child: ListView.builder(
                                                            itemCount: controller.listFreelancer.length,
                                                            itemBuilder: (context, index) {
                                                              return CardJobNTD(
                                                                name: controller.listFreelancer[index].hoTen,
                                                                address: controller.listFreelancer[index].diaChi,
                                                                urlImage:
                                                                    controller.listFreelancer[index].path + controller.listFreelancer[index].avatar,
                                                                job: controller.listFreelancer[index].ngheNghiep,
                                                                exp: controller.listFreelancer[index].kinhNghiem,
                                                                check: true,
                                                                checkButton: true,
                                                                rateStar: double.parse(controller.listFreelancer[index].rateStar.toString()),
                                                                career: 'Dịch thuật',
                                                                phoneCall: controller.listFreelancer[index].sdt,
                                                                userId: controller.listFreelancer[index].maUser,
                                                                viewed: controller.listFreelancer[index].viewed,
                                                                listSkill: controller.getSkillFreelancer(index, 2),
                                                                onPress: () {
                                                                  controller.indexIdFreelancer.value = controller.listFreelancer[index].maUser;
                                                                  controller.detailFreelancer();
                                                                },
                                                              );
                                                            }),
                                                      )
                                                    : controller.indexFreelancer.value == 6
                                                        ? Scrollbar(
                                                            child: ListView.builder(
                                                                itemCount: controller.listFreelancer.length,
                                                                itemBuilder: (context, index) {
                                                                  return CardJobNTD(
                                                                    name: controller.listFreelancer[index].hoTen,
                                                                    address: controller.resultFreelancer.data != null ? controller.listFreelancer[index].diaChi : '',
                                                                    urlImage: controller.listFreelancer[index].path +
                                                                        controller.listFreelancer[index].avatar,
                                                                    job: controller.listFreelancer[index].ngheNghiep,
                                                                    exp: controller.listFreelancer[index].kinhNghiem,
                                                                    check: true,
                                                                    checkButton: true,
                                                                    rateStar: double.parse(controller.listFreelancer[index].rateStar.toString()),
                                                                    career: 'Kinh doanh',
                                                                    phoneCall: controller.listFreelancer[index].sdt,
                                                                    userId: controller.listFreelancer[index].maUser,
                                                                    viewed: controller.listFreelancer[index].viewed,
                                                                    listSkill: controller.getSkillFreelancer(index, 2),
                                                                    onPress: () {
                                                                      controller.indexIdFreelancer.value = controller.listFreelancer[index].maUser;
                                                                      controller.detailFreelancer();
                                                                    },
                                                                  );
                                                                }),
                                                          )
                                                        : controller.indexFreelancer.value == 7
                                                            ? Scrollbar(
                                                                child: ListView.builder(
                                                                    itemCount: controller.listFreelancer.length,
                                                                    itemBuilder: (context, index) {
                                                                      return CardJobNTD(
                                                                        name: controller.listFreelancer[index].hoTen,
                                                                        address: controller.listFreelancer[index].diaChi,
                                                                        urlImage: controller.listFreelancer[index].path +
                                                                            controller.listFreelancer[index].avatar,
                                                                        job: controller.listFreelancer[index].ngheNghiep,
                                                                        exp: controller.listFreelancer[index].kinhNghiem,
                                                                        check: true,
                                                                        checkButton: true,
                                                                        rateStar: double.parse(controller.listFreelancer[index].rateStar.toString()),
                                                                        career: 'Xây dựng',
                                                                        phoneCall: controller.listFreelancer[index].sdt,
                                                                        userId: controller.listFreelancer[index].maUser,
                                                                        viewed: controller.listFreelancer[index].viewed,
                                                                        listSkill: controller.getSkillFreelancer(index, 2),
                                                                        onPress: () {
                                                                          controller.indexIdFreelancer.value =
                                                                              controller.listFreelancer[index].maUser;
                                                                          controller.detailFreelancer();
                                                                        },
                                                                      );
                                                                    }),
                                                              )
                                                            : controller.indexFreelancer.value == 8
                                                                ? Scrollbar(
                                                                    child: ListView.builder(
                                                                        itemCount: controller.listFreelancer.length,
                                                                        itemBuilder: (context, index) {
                                                                          return CardJobNTD(
                                                                            name: controller.listFreelancer[index].hoTen,
                                                                            address: controller.listFreelancer[index].diaChi,
                                                                            urlImage: controller.listFreelancer[index].path +
                                                                                controller.listFreelancer[index].avatar,
                                                                            job: controller.listFreelancer[index].ngheNghiep,
                                                                            exp: controller.listFreelancer[index].kinhNghiem,
                                                                            check: true,
                                                                            checkButton: true,
                                                                            rateStar:
                                                                                double.parse(controller.listFreelancer[index].rateStar.toString()),
                                                                            career: 'Nhập liệu',
                                                                            phoneCall: controller.listFreelancer[index].sdt,
                                                                            userId: controller.listFreelancer[index].maUser,
                                                                            viewed: controller.listFreelancer[index].viewed,
                                                                            listSkill: controller.getSkillFreelancer(index, 2),
                                                                            onPress: () {
                                                                              controller.indexIdFreelancer.value =
                                                                                  controller.listFreelancer[index].maUser;
                                                                              controller.detailFreelancer();
                                                                            },
                                                                          );
                                                                        }),
                                                                  )
                                                                : controller.indexFreelancer.value == 9
                                                                    ? Scrollbar(
                                                                        child: ListView.builder(
                                                                            itemCount: controller.listFreelancer.length,
                                                                            itemBuilder: (context, index) {
                                                                              return CardJobNTD(
                                                                                name: controller.listFreelancer[index].hoTen,
                                                                                address: controller.listFreelancer[index].diaChi,
                                                                                urlImage: controller.listFreelancer[index].path +
                                                                                    controller.listFreelancer[index].avatar,
                                                                                job: controller.listFreelancer[index].ngheNghiep,
                                                                                exp: controller.listFreelancer[index].kinhNghiem,
                                                                                check: true,
                                                                                checkButton: true,
                                                                                rateStar: double.parse(
                                                                                    controller.listFreelancer[index].rateStar.toString()),
                                                                                career: 'Kế toán',
                                                                                phoneCall: controller.listFreelancer[index].sdt,
                                                                                userId: controller.listFreelancer[index].maUser,
                                                                                viewed: controller.listFreelancer[index].viewed,
                                                                                listSkill: controller.getSkillFreelancer(index, 2),
                                                                                onPress: () {
                                                                                  controller.indexIdFreelancer.value =
                                                                                      controller.listFreelancer[index].maUser;
                                                                                  controller.detailFreelancer();
                                                                                },
                                                                              );
                                                                            }),
                                                                      )
                                                                    : controller.indexFreelancer.value == 10
                                                                        ? Scrollbar(
                                                                            child: ListView.builder(
                                                                                itemCount: controller.listFreelancer.length,
                                                                                itemBuilder: (context, index) {
                                                                                  return CardJobNTD(
                                                                                    name: controller.listFreelancer[index].hoTen,
                                                                                    address: controller.listFreelancer[index].diaChi,
                                                                                    urlImage: controller.listFreelancer[index].path +
                                                                                        controller.listFreelancer[index].avatar,
                                                                                    job: controller.listFreelancer[index].ngheNghiep,
                                                                                    exp: controller.listFreelancer[index].kinhNghiem,
                                                                                    check: true,
                                                                                    checkButton: true,
                                                                                    rateStar: double.parse(
                                                                                        controller.listFreelancer[index].rateStar.toString()),
                                                                                    career: 'Luật',
                                                                                    phoneCall: controller.listFreelancer[index].sdt,
                                                                                    userId: controller.listFreelancer[index].maUser,
                                                                                    viewed: controller.listFreelancer[index].viewed,
                                                                                    listSkill: controller.getSkillFreelancer(index, 2),
                                                                                    onPress: () {
                                                                                      controller.indexIdFreelancer.value =
                                                                                          controller.listFreelancer[index].maUser;
                                                                                      controller.detailFreelancer();
                                                                                    },
                                                                                  );
                                                                                }),
                                                                          )
                                                                        : controller.indexFreelancer.value == 11
                                                                            ? Scrollbar(
                                                                                child: ListView.builder(
                                                                                    itemCount: controller.listFreelancer.length,
                                                                                    itemBuilder: (context, index) {
                                                                                      return CardJobNTD(
                                                                                        name: controller.listFreelancer[index].hoTen,
                                                                                        address: controller.listFreelancer[index].diaChi,
                                                                                        urlImage: controller.listFreelancer[index].path +
                                                                                            controller.listFreelancer[index].avatar,
                                                                                        job: controller.listFreelancer[index].ngheNghiep,
                                                                                        exp: controller.listFreelancer[index].kinhNghiem,
                                                                                        check: true,
                                                                                        checkButton: true,
                                                                                        rateStar: double.parse(
                                                                                            controller.listFreelancer[index].rateStar.toString()),
                                                                                        career: 'Lĩnh vực khác',
                                                                                        phoneCall: controller.listFreelancer[index].sdt,
                                                                                        userId: controller.listFreelancer[index].maUser,
                                                                                        viewed: controller.listFreelancer[index].viewed,
                                                                                        listSkill: controller.getSkillFreelancer(index, 2),
                                                                                        onPress: () {
                                                                                          controller.indexIdFreelancer.value =
                                                                                              controller.listFreelancer[index].maUser;
                                                                                          controller.detailFreelancer();
                                                                                        },
                                                                                      );
                                                                                    }),
                                                                              )
                                                                            : controller.indexFreelancer.value == 12
                                                                                ? Scrollbar(
                                                                                    child: ListView.builder(
                                                                                        itemCount: controller.listFreelancer.length,
                                                                                        itemBuilder: (context, index) {
                                                                                          return CardJobNTD(
                                                                                            name: controller.listFreelancer[index].hoTen,
                                                                                            address: controller.listFreelancer[index].diaChi,
                                                                                            urlImage: controller.listFreelancer[index].path +
                                                                                                controller.listFreelancer[index].avatar,
                                                                                            job: controller.listFreelancer[index].ngheNghiep,
                                                                                            exp: controller.listFreelancer[index].kinhNghiem,
                                                                                            check: false,
                                                                                            checkButton: true,
                                                                                            rateStar: double.parse(
                                                                                                controller.listFreelancer[index].rateStar.toString()),
                                                                                            career: 'Mới nhất',
                                                                                            phoneCall: controller.listFreelancer[index].sdt,
                                                                                            userId: controller.listFreelancer[index].maUser,
                                                                                            viewed: controller.listFreelancer[index].viewed,
                                                                                            listSkill: controller.getSkillFreelancer(index, 2),
                                                                                            onPress: () {
                                                                                              controller.indexIdFreelancer.value =
                                                                                                  controller.listFreelancer[index].maUser;
                                                                                              controller.detailFreelancer();
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  )
                                                                                : Scrollbar(
                                                                                    child: ListView.builder(
                                                                                        itemCount: controller.listFreelancer.length,
                                                                                        itemBuilder: (context, index) {
                                                                                          return CardJobNTD(
                                                                                            name: controller.listFreelancer[index].hoTen,
                                                                                            address: controller.listFreelancer[index].diaChi,
                                                                                            urlImage: controller.listFreelancer[index].path +
                                                                                                controller.listFreelancer[index].avatar,
                                                                                            job: controller.listFreelancer[index].ngheNghiep,
                                                                                            exp: controller.listFreelancer[index].kinhNghiem,
                                                                                            check: false,
                                                                                            checkButton: true,
                                                                                            rateStar: double.parse(
                                                                                                controller.listFreelancer[index].rateStar.toString()),
                                                                                            career: 'Nổi bật',
                                                                                            phoneCall: controller.listFreelancer[index].sdt,
                                                                                            userId: controller.listFreelancer[index].maUser,
                                                                                            viewed: controller.listFreelancer[index].viewed,
                                                                                            listSkill: controller.getSkillFreelancer(index, 2),
                                                                                            onPress: () {
                                                                                              controller.indexIdFreelancer.value =
                                                                                                  controller.listFreelancer[index].maUser;
                                                                                              controller.detailFreelancer();
                                                                                            },
                                                                                          );
                                                                                        }),
                                                                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onTap: () => controller.indexFreelancer.value == 12
                                  ? controller.loadMoreFreelancer()
                                  : controller.indexFreelancer.value == 13
                                      ? controller.loadMoreFreelancer()
                                      : controller.loadMoreFreelancer(),
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
                ]),
              ),
            ))));
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
