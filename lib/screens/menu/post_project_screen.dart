// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/screens/home/home_screen.dart';
import 'package:freelancer_app/screens/home/more_job_ntd_screen.dart';
import 'package:freelancer_app/screens/menu/menu_controller.dart';
import 'package:freelancer_app/screens/menu/post_job_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class PostProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.whiteDot,
      body: SingleChildScrollView(
        child: GetBuilder<MenuController>(
          init: MenuController(),
          builder: (controller) => Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: Column(
                    children: [
                      Image.asset(Images.post_project_1),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Đăng việc để thuê Freelancer làm việc ngay!',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.blue, height: 1.4),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 53),
                        child: Text(
                          'Hàng ngàn dự án đã đăng và thuê được freelancer thành công. Đăng việc để thuê Freelancer làm việc ngay!',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.hintText, height: 1.4),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          // controller.getListCity();
                          // controller.getListCategory();
                          controller.whatJobUPost.value = 1;
                          controller.showWhatJobUPost();
                          SpUtil.putInt(ConstString.WHAT_U_POST, controller.whatJobUPost.value);
                          Get.to(PostJobScreen());
                        },
                        child: Container(
                          width: width * 0.77,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: AppColors.linearGradient1),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(Images.ic_rocket),
                              SizedBox(width: 20),
                              Text(
                                'Đăng việc theo dự án',
                                style: AppTextStyles.regularW700(context, size: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          // controller.getListCity();
                          // controller.getListCategory();
                          controller.whatJobUPost.value = 2;
                          controller.showWhatJobUPost();
                          SpUtil.putInt(ConstString.WHAT_U_POST, controller.whatJobUPost.value);
                          Get.to(PostJobScreen());
                        },
                        child: Container(
                          width: width * 0.77,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: AppColors.linearGradient2),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(Images.ic_clock),
                              SizedBox(width: 20),
                              Text(
                                'Đăng việc bán thời gian',
                                style: AppTextStyles.regularW700(context, size: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 21)
                    ],
                  )),
              SizedBox(height: 16),
              Container(
                constraints: BoxConstraints(
                    minHeight: 300
                ),
                width: width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.blue,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Text(
                            'Tìm Freelancer theo ngành nghề',
                            style: AppTextStyles.regularW500(context, size: 14),
                          )),
                      Row(
                        children: [
                          Spacer(),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  navigationController.indexFreelancer.value = 0;
                                  navigationController.checkIndexFreelancer();
                                  navigationController.indexCategory.value = 1;
                                  navigationController.checkCategory();
                                  navigationController.getListFreelancer();
                                  Get.to(MoreJobNTDScreen());
                                },
                                child: customCareerTile(
                                  name: 'IT & Lập trình',
                                  logo: SvgPicture.asset(Images.ic_it),
                                  color: navigationController.indexFreelancer.value == 0 ? AppColors.orange : AppColors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigationController.indexFreelancer.value = 3;
                                  navigationController.checkIndexFreelancer();
                                  navigationController.indexCategory.value = 7;
                                  navigationController.checkCategory();
                                  navigationController.getListFreelancer();
                                  Get.to(MoreJobNTDScreen());
                                },
                                child: customCareerTile(
                                  name: 'Video',
                                  logo: SvgPicture.asset(Images.ic_video),
                                  color: navigationController.indexFreelancer.value == 3 ? AppColors.orange : AppColors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigationController.indexFreelancer.value = 6;
                                  navigationController.checkIndexFreelancer();
                                  navigationController.indexCategory.value = 19;
                                  navigationController.checkCategory();
                                  navigationController.getListFreelancer();
                                  Get.to(MoreJobNTDScreen());
                                },
                                child: customCareerTile(
                                  name: 'Kinh doanh',
                                  logo: SvgPicture.asset(Images.ic_business),
                                  color: navigationController.indexFreelancer.value == 6 ? AppColors.orange : AppColors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigationController.indexFreelancer.value = 9;
                                  navigationController.checkIndexFreelancer();
                                  navigationController.indexCategory.value = 21;
                                  navigationController.checkCategory();
                                  navigationController.getListFreelancer();
                                  Get.to(MoreJobNTDScreen());
                                },
                                child: customCareerTile(
                                  name: 'Kế toán',
                                  logo: SvgPicture.asset(Images.ic_accounting),
                                  color: navigationController.indexFreelancer.value == 9 ? AppColors.orange : AppColors.white,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  navigationController.indexFreelancer.value = 1;
                                  navigationController.checkIndexFreelancer();
                                  navigationController.indexCategory.value = 2;
                                  navigationController.checkCategory();
                                  navigationController.getListFreelancer();
                                  Get.to(MoreJobNTDScreen());
                                },
                                child: customCareerTile(
                                  name: 'Thiết kế',
                                  logo: SvgPicture.asset(Images.ic_design),
                                  color: navigationController.indexFreelancer.value == 1 ? AppColors.orange : AppColors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigationController.indexFreelancer.value = 4;
                                  navigationController.checkIndexFreelancer();
                                  navigationController.indexCategory.value = 23;
                                  navigationController.checkCategory();
                                  navigationController.getListFreelancer();
                                  Get.to(MoreJobNTDScreen());
                                },
                                child: customCareerTile(
                                  name: 'Kiến trúc',
                                  logo: SvgPicture.asset(Images.ic_construct),
                                  color: navigationController.indexFreelancer.value == 4 ? AppColors.orange : AppColors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigationController.indexFreelancer.value = 7;
                                  navigationController.checkIndexFreelancer();
                                  navigationController.indexCategory.value = 24;
                                  navigationController.checkCategory();
                                  navigationController.getListFreelancer();
                                  Get.to(MoreJobNTDScreen());
                                },
                                child: customCareerTile(
                                  name: 'Xây dựng',
                                  logo: SvgPicture.asset(Images.ic_build),
                                  color: navigationController.indexFreelancer.value == 7 ? AppColors.orange : AppColors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigationController.indexFreelancer.value = 10;
                                  navigationController.checkIndexFreelancer();
                                  navigationController.indexCategory.value = 22;
                                  navigationController.checkCategory();
                                  navigationController.getListFreelancer();
                                  Get.to(MoreJobNTDScreen());
                                },
                                child: customCareerTile(
                                  name: 'Luật',
                                  logo: SvgPicture.asset(Images.ic_loyer),
                                  color: navigationController.indexFreelancer.value == 10 ? AppColors.orange : AppColors.white,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  navigationController.indexFreelancer.value = 2;
                                  navigationController.checkIndexFreelancer();
                                  navigationController.indexCategory.value = 17;
                                  navigationController.checkCategory();
                                  navigationController.getListFreelancer();
                                  Get.to(MoreJobNTDScreen());
                                },
                                child: customCareerTile(
                                  name: 'Viết lách',
                                  logo: SvgPicture.asset(Images.ic_write),
                                  color: navigationController.indexFreelancer.value == 2 ? AppColors.orange : AppColors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigationController.indexFreelancer.value = 5;
                                  navigationController.checkIndexFreelancer();
                                  navigationController.indexCategory.value = 18;
                                  navigationController.checkCategory();
                                  navigationController.getListFreelancer();
                                  Get.to(MoreJobNTDScreen());
                                },
                                child: customCareerTile(
                                  name: 'Dịch thuật',
                                  logo: SvgPicture.asset(Images.ic_note),
                                  color: navigationController.indexFreelancer.value == 5 ? AppColors.orange : AppColors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigationController.indexFreelancer.value = 8;
                                  navigationController.checkIndexFreelancer();
                                  navigationController.indexCategory.value = 20;
                                  navigationController.checkCategory();
                                  navigationController.getListFreelancer();
                                  Get.to(MoreJobNTDScreen());
                                },
                                child: customCareerTile(
                                  name: 'Nhập liệu',
                                  logo: SvgPicture.asset(Images.ic_input),
                                  color: navigationController.indexFreelancer.value == 8 ? AppColors.orange : AppColors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigationController.indexFreelancer.value = 11;
                                  navigationController.checkIndexFreelancer();
                                  navigationController.indexCategory.value = 8;
                                  navigationController.checkCategory();
                                  navigationController.getListFreelancer();
                                  Get.to(MoreJobNTDScreen());
                                },
                                child: customCareerTile(
                                  name: 'Lĩnh vực khác',
                                  logo: SvgPicture.asset(Images.ic_another),
                                  color: navigationController.indexFreelancer.value == 11 ? AppColors.orange : AppColors.white,
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
              SizedBox(height: 10),
              Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(
                        child: Text(
                      'Tại sao nên tìm Freelancer tại Timviec365.com?',
                      style: AppTextStyles.regularW700(context, size: 18, color: AppColors.black3),
                      textAlign: TextAlign.center,
                    )),
                    SizedBox(height: 40),
                    Image.asset(Images.post_project_2),
                    SizedBox(height: 40),
                    Text(
                      'Tuyển Freelancer hiệu quả nhất',
                      style: AppTextStyles.regularW700(context, size: 18, color: AppColors.blue),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset(Images.ic_box_orange),
                        SizedBox(width: 18),
                        Text(
                          'Đăng việc làm miễn phí',
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black4),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(Images.ic_box_orange),
                        SizedBox(width: 18),
                        Text(
                          'Thu hút những Freelancer giỏi nhất',
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black4),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(Images.ic_box_orange),
                        SizedBox(width: 18),
                        Text(
                          'Tiết kiệm chi phí tuyển dụng',
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black4),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Image.asset(Images.post_project_3),
                    SizedBox(height: 40),
                    Text(
                      'Chọn Freelancer ưng ý nhất',
                      style: AppTextStyles.regularW700(context, size: 18, color: AppColors.blue),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset(Images.ic_box_orange),
                        SizedBox(width: 18),
                        Text(
                          'So sánh các ứng viên',
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black4),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(Images.ic_box_orange),
                        SizedBox(width: 18),
                        Text(
                          'Dữ liệu ứng viên phong phú',
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black4),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(Images.ic_box_orange),
                        SizedBox(width: 18),
                        Text(
                          'Chọn 01 Freelancer ưng ý nhất',
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black4),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Image.asset(Images.post_project_4),
                    SizedBox(height: 40),
                    Text(
                      'Hỗ trợ 24/7',
                      style: AppTextStyles.regularW700(context, size: 18, color: AppColors.blue),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Đội ngũ chăm sóc khách hàng 24/7 luôn sẵn sàng hỗ trợ bạn để giải quyết các vân đề cấp bách giúp công việc của bản luôn trôi chảy.',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.black3, height: 1.4),
                    ),
                    SizedBox(height: 40),
                    Image.asset(Images.tutorial_pic_1),
                    SizedBox(height: 30)
                  ],
                ),
              ),
              WillPopScope(
                onWillPop: () {
                  navigationController.changePage(4);
                  navigationController.isBackApp.value = true;
                },
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
