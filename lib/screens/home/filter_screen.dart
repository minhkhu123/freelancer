import 'package:flutter/material.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/custom_textfield_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/select_drop_list_career_filter.dart';
import 'package:freelancer_app/widgets/select_drop_list_city_filter.dart';
import 'package:freelancer_app/widgets/select_drop_list_form_filter.dart';
import 'package:freelancer_app/widgets/select_drop_list_skills_filter.dart';
import 'package:get/get.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    NavigationController navigationController = Get.put(NavigationController());
    RegisterController registerController = Get.put(RegisterController());
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: waitLoginController.checkWhoUR.value
                ? () {
                    navigationController.listJob.clear();
                    navigationController.getListJob();
                    navigationController.resetFilter();
                    registerController.searchCityFilterTextEditingController.clear();
                    registerController.getSearchListCityFilter();
                    registerController.searchCategoryFilterTextEditingController.clear();
                    registerController.getSearchListCategoryFilter();
                    Get.back();
                  }
                : () {
                    navigationController.listFreelancer.clear();
                    navigationController.getListFreelancer();
                    navigationController.resetFilter();
                    registerController.searchCategoryFilterTextEditingController.clear();
                    registerController.getSearchListCategoryFilter();
                    Get.back();
                  },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          'Bộ lọc',
          style: AppTextStyles.regularW500(context, size: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
        child: SingleChildScrollView(
          child: GetBuilder<NavigationController>(
            init: NavigationController(),
            builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tỉnh/Thành phố',
                  style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                ),
                SelectDropListCityFilter(
                  title: controller.nameCity.value,
                ),
                Text('Ngành nghề', style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black)),
                SelectDropListCareerFilter(
                  title: controller.nameCareer.value,
                ),
                Text('Kỹ năng', style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black)),
                SelectDropListSkillsFilter(
                  title: controller.nameSkills.value,
                ),
                waitLoginController.checkWhoUR.value
                    ? Container()
                    : Text('Hình thức', style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black)),
                waitLoginController.checkWhoUR.value
                    ? Container()
                    : SelectDropListForm(
                        controller.optionItemSelectedForm,
                        controller.dropListModelForm,
                        (optionItem) {
                          controller.optionItemSelectedForm = optionItem;
                          controller.changeForm();
                          print(controller.indexForm);
                        },
                      ),
                SizedBox(height: height * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: waitLoginController.checkWhoUR.value
                          ? () {
                              controller.clearListSearch();
                              controller.loadTime.value = 1;
                              controller.getListJob();
                              Get.back();
                            }
                          : () {
                              controller.clearListSearch();
                              controller.loadTime.value = 1;
                              controller.getListFreelancer();
                              Get.back();
                            },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 9),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.orange,
                        ),
                        child: Text(
                          'ÁP DỤNG',
                          style: AppTextStyles.regularW500(context, size: 16),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: waitLoginController.checkWhoUR.value
                          ? () {
                              navigationController.listJob.clear();
                              navigationController.getListJob();
                              navigationController.resetFilter();
                              registerController.searchCityFilterTextEditingController.clear();
                              registerController.getSearchListCityFilter();
                              registerController.searchCategoryFilterTextEditingController.clear();
                              registerController.getSearchListCategoryFilter();
                              Get.back();
                            }
                          : () {
                              navigationController.listFreelancer.clear();
                              navigationController.getListFreelancer();
                              navigationController.resetFilter();
                              registerController.searchCityFilterTextEditingController.clear();
                              registerController.getSearchListCityFilter();
                              registerController.searchCategoryFilterTextEditingController.clear();
                              registerController.getSearchListCategoryFilter();
                              Get.back();
                            },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white,
                          border: Border.all(color: AppColors.greyBorder),
                        ),
                        child: Text(
                          'HỦY',
                          style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                WillPopScope(
                  onWillPop: waitLoginController.checkWhoUR.value
                      ? () {
                    navigationController.listJob.clear();
                    navigationController.getListJob();
                    navigationController.resetFilter();
                    registerController.searchCityFilterTextEditingController.clear();
                    registerController.getSearchListCityFilter();
                    registerController.searchCategoryFilterTextEditingController.clear();
                    registerController.getSearchListCategoryFilter();
                    Get.back();
                  }
                      : () {
                    navigationController.listFreelancer.clear();
                    navigationController.getListFreelancer();
                    navigationController.resetFilter();
                    registerController.searchCategoryFilterTextEditingController.clear();
                    registerController.getSearchListCategoryFilter();
                    Get.back();
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
