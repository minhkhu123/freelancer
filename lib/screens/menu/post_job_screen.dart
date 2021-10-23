import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/screens/authens/freelancer_recruitment/post_parttime_jobs/post_partime_jobs_controller.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/menu/menu_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/custom_textfield_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/custom_textinput_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/custom_textiput_date.dart';
import 'package:freelancer_app/widgets/dialog_login_post_job.dart';
import 'package:freelancer_app/widgets/rectangle.dart';
import 'package:freelancer_app/widgets/select_drop_list.dart';
import 'package:freelancer_app/widgets/select_drop_list_career.dart';
import 'package:freelancer_app/widgets/select_drop_list_month.dart';
import 'package:freelancer_app/widgets/select_drop_list_skills.dart';
import 'package:freelancer_app/widgets/select_drop_list_workplace.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class PostJobScreen extends StatefulWidget {
  @override
  _PostJobScreenState createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  MenuController menuController = Get.put(MenuController());
  RegisterController registerController = Get.put(RegisterController());
  NavigationController navigationController = Get.put(NavigationController());
  WaitLoginController waitLoginController = Get.put(WaitLoginController());

  @override
  void initState() {
    menuController.whatJobUPost.value = SpUtil.getInt(ConstString.WHAT_U_POST);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            menuController.clearList();
            registerController.searchCategoryTextEditingController.clear();
            registerController.getSearchListCategory();
            registerController.searchWorkPlaceTextEditingController.clear();
            registerController.getSearchListWorkPlace();
            Get.back();
          },
        ),
        title: Text(
          menuController.whatJobUPost.value == 2 ? "Đăng việc bán thời gian" : "Đăng việc theo dự án",
          style: AppTextStyles.regularW500(context, size: 18),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<MenuController>(
          init: MenuController(),
          builder: (controller) => Column(
            children: [
              Container(
                height: 288,
                child: Stack(
                  children: [
                    Image.asset(Images.top_watch_detail),
                    Positioned(
                      bottom: 0,
                      left: MediaQuery.of(context).size.width * 0.37,
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: AppColors.grey, offset: Offset(0, 10), blurRadius: 10, spreadRadius: -5)],
                            borderRadius: BorderRadius.circular(50)),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.white,
                          child: SvgPicture.asset(Images.ic_book),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Rectangle(height: height * 0.05, title: "Việc cần tuyển Freelancer"),
                    controller.logo == null
                        ? Image.asset(Images.logo_tim365)
                        : Container(
                            height: height * 0.5,
                            width: width,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                controller.logo,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                    Center(
                      child: Text(
                        "Logo công ty",
                        style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: height * 0.05,
                        width: width * 0.25,
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(50)),
                        child: InkWell(
                          onTap: controller.getImageLogo,
                          borderRadius: BorderRadius.circular(100),
                          child: Center(child: Text("+ Chọn ảnh")),
                        ),
                      ),
                    ),
                    CustomTextFieldFreelanceRecruitment(
                      text: "Tên vị trí cần tuyển",
                    ),
                    CustomEditTextFreelancerRecruitment(
                      hintText: "VD: Thiết kế web bán hàng cao cấp",
                      isIcon: false,
                      isReadOnly: false,
                      padding: const EdgeInsets.only(bottom: 20, top: 10),
                      controller: controller.nameJobsRecruitmentTextEditingController,
                      textError: controller.checkValidNameCV(),
                    ),
                    CustomTextFieldFreelanceRecruitment(
                      text: "Chọn lĩnh vực cần tuyển",
                    ),
                    SelectDropListCareer(
                      title: controller.nameCareer.value,
                      error: controller.checkValidCareer(),
                      index: 1,
                      indexPostJob: controller.indexPostJob,
                    ),
                    CustomTextFieldFreelanceRecruitment(text: "Yêu cầu kinh nghiệm"),
                    SelectDropList(
                      itemList: controller.optionItemExpSelected,
                      list: controller.listExpModel.listItem,
                      onOption: (item) {
                        controller.optionItemExpSelected = item;
                        controller.changeExp();
                        print(controller.whatJobUPost.value);
                      },
                      error: controller.checkValidExp(),
                      index: 2,
                      currentIndex: controller.indexPostJob,
                    ),
                    CustomTextFieldFreelanceRecruitment(text: "Hình thức làm việc"),
                    SelectDropList(
                      itemList: controller.optionItemWorkingFormSelected,
                      list: controller.listWorkingFormModel.listItem,
                      onOption: (item) {
                        controller.optionItemWorkingFormSelected = item;
                        controller.changeClassification();
                      },
                      error: controller.checkValidForm(),
                      index: 3,
                      currentIndex: controller.indexPostJob,
                    ),
                    CustomTextFieldFreelanceRecruitment(text: "Nơi làm việc"),
                    SelectDropListWorkplace(
                      title: controller.nameWorkPlace.value,
                      error: controller.checkValidWorkPlace(),
                      index: 4,
                      indexPostJob: controller.indexPostJob,
                    ),
                    CustomTextFieldFreelanceRecruitment(
                        text: controller.whatJobUPost.value == 2
                            ? "Thông tin chi tiết"
                            : "Nội dung chi tiết, và các đầu việc cần \nFreelancer thực hiện\n(càng chi tiết, freelancer càng có đầy đủ \nthông tin để gửi báo giá chính xác hơn)"),
                    CustomEditTextFreelancerRecruitment(
                      hintText: "VD: Thiết kế các giao diện website cần thiết như: Trang chủ, xem hàng, thanh toán...",
                      isReadOnly: false,
                      isIcon: false,
                      padding: const EdgeInsets.only(bottom: 40, top: 10),
                      maxLines: 6,
                      controller: controller.requestTextEditingController,
                      textError: controller.checkValidRequest(),
                    ),
                    // Text(
                    //   "Thêm tài kiệu đính kèm",
                    //   style: AppTextStyles.regularW400(context, size: 16, color: AppColors.blue),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 5),
                    //   child: Text(
                    //     controller.fileUpload.toString() != null ? controller.fileUpload.toString() : Text(''),
                    //     style: AppTextStyles.regularW500(context, size: 16, color: AppColors.grey5),
                    //   ),
                    // ),
                    // Center(
                    //   child: Container(
                    //     width: width * 0.3,
                    //     height: height * 0.05,
                    //     margin: const EdgeInsets.only(top: 20, bottom: 20),
                    //     decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(8)),
                    //     child: InkWell(
                    //       onTap: controller.upLoadFile,
                    //       child: Center(child: Text("+ Tải lên")),
                    //     ),
                    //   ),
                    // ),
                    // Text(
                    //   "Tải lên bất kỳ hình ảnh hoặc tài liệu mô tả ngắn gọn công việc (Kích thước tệp tối đa: 25 MB).",
                    //   style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey5),
                    // ),
                    // SizedBox(height: 30),
                    Text(
                      "Kỹ năng Freelancer",
                      style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SelectDropListSkills(
                      title: controller.nameSkills.value,
                      // error: controller.checkValidSkill(),
                      index: 5,
                      indexPostJob: controller.indexPostJob,
                    ),
                    Rectangle(
                      title: "Chi phí và thời gian",
                      height: 30,
                    ),
                    SizedBox(height: 30),
                    CustomTextFieldFreelanceRecruitment(text: "Ngân sách dự kiến cho công việc này"),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.indexSalaryType.value = 1;
                              controller.checkSalaryCon();
                            },
                            child: Container(
                              height: 40,
                              width: 90,
                              decoration: BoxDecoration(
                                color: controller.indexSalaryType.value == 1 ? AppColors.blue1 : AppColors.white,
                                border: Border.all(color: controller.indexSalaryType.value == 1 ? AppColors.blue2 : AppColors.grey),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                              ),
                              child: Center(
                                  child: Text(
                                'Cố định',
                                style: AppTextStyles.regularW500(context,
                                    size: 15, color: controller.indexSalaryType.value == 1 ? AppColors.blue2 : AppColors.black),
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.indexSalaryType.value = 2;
                              controller.checkSalaryCon();
                            },
                            child: Container(
                              height: 40,
                              width: 90,
                              decoration: BoxDecoration(
                                color: controller.indexSalaryType.value == 2 ? AppColors.blue1 : AppColors.white,
                                border: Border.all(color: controller.indexSalaryType.value == 2 ? AppColors.blue2 : AppColors.grey),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                              ),
                              child: Center(
                                  child: Text(
                                'Ước lượng',
                                style: AppTextStyles.regularW500(context,
                                    size: 15, color: controller.indexSalaryType.value == 2 ? AppColors.blue2 : AppColors.black),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    controller.indexSalaryType.value == 1
                        ? Row(
                            children: [
                              Container(
                                width: width * 0.55,
                                child: CustomEditTextFreelancerRecruitment(
                                  hintText: "VD: 2.500.000",
                                  isSubText: true,
                                  isIcon: false,
                                  isReadOnly: false,
                                  textInputType: TextInputType.number,
                                  controller: controller.salaryTextEditingController,
                                  textError: controller.checkValidSalary(),
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                ),
                              ),
                              SizedBox(width: 4),
                              Text('/'),
                              SizedBox(width: 4),
                              Container(
                                width: width * 0.31,
                                padding: controller.upTimed.value ? EdgeInsets.only(bottom: 20) : EdgeInsets.only(bottom: 3),
                                child: SelectDropListMonth(
                                  controller.optionItemSelectedMonth,
                                  controller.dropListModelMonth,
                                  (optionItem) {
                                    controller.optionItemSelectedMonth = optionItem;
                                    controller.changeSalaryTime();
                                    print(controller.salaryDependRegister);
                                  },
                                ),
                              ),
                            ],
                          )
                        : controller.indexSalaryType.value == 2
                            ? CustomEditTextFreelancerRecruitment(
                                hintText: "VD: 2.500.000",
                                isSubText: true,
                                isIcon: false,
                                isReadOnly: false,
                                textInputType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                controller: controller.salaryTextEditingController,
                                textError: controller.checkValidSalary(),
                              )
                            : Container(),
                    controller.indexSalaryType.value == 2
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Đến: (mức lương)',
                                style: AppTextStyles.regularW500(context, size: 15, color: AppColors.black),
                              ),
                              SizedBox(height: 10),
                              CustomEditTextFreelancerRecruitment(
                                hintText: "VD: 5.000.000",
                                isSubText: true,
                                isIcon: false,
                                isReadOnly: false,
                                textInputType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                controller: controller.salaryEndTextEditingController,
                                textError: controller.checkValidSalaryEnd(),
                              ),
                            ],
                          )
                        : Container(),
                    controller.indexSalaryType.value == 2
                        ? Container(
                            width: width * 0.31,
                            padding: EdgeInsets.only(bottom: 7),
                            child: SelectDropListMonth(
                              controller.optionItemSelectedMonth,
                              controller.dropListModelMonth,
                              (optionItem) {
                                controller.optionItemSelectedMonth = optionItem;
                                controller.changeSalaryTime();
                                print(controller.salaryDependRegister);
                              },
                            ),
                          )
                        : Container(),
                    SizedBox(height: 20),
                    CustomTextFieldFreelanceRecruitment(text: "Ngày bắt đầu đặt giá"),
                    CustomEditTextDateFreelancerRecruitment(
                      hintText: controller.checkValueDateStart.value ? controller.valueDateStart.value : 'Chọn ngày bắt đầu',
                      padding: const EdgeInsets.only(bottom: 20, top: 10),
                      onPress: () {
                        controller.selectDateStartDG(context);
                      },
                      error: controller.checkValidDateStartDeal(),
                    ),
                    CustomTextFieldFreelanceRecruitment(text: "Ngày đặt giá kết thúc"),
                    CustomEditTextDateFreelancerRecruitment(
                      hintText: controller.checkValueDateEnd.value ? controller.valueDateEnd.value : 'Chọn ngày kết thúc',
                      padding: const EdgeInsets.only(bottom: 20, top: 10),
                      onPress: () {
                        controller.selectDateEndDG(context);
                      },
                      error: controller.checkValidDateEndDeal(),
                    ),
                    CustomTextFieldFreelanceRecruitment(text: "Ngày bắt đầu làm việc"),
                    CustomEditTextDateFreelancerRecruitment(
                      hintText: controller.checkValueDateStartWork.value ? controller.valueDateStartWork.value : 'Chọn ngày',
                      padding: const EdgeInsets.only(bottom: 20, top: 10),
                      onPress: () {
                        controller.selectDateStartWorking(context);
                      },
                      error: controller.checkValidDateStartWork(),
                    ),
                    CustomTextFieldFreelanceRecruitment(text: "Ngày kết thúc làm việc"),
                    CustomEditTextDateFreelancerRecruitment(
                      hintText: controller.checkValueDateEndWork.value ? controller.valueDateEndWork.value : 'Chọn ngày',
                      padding: const EdgeInsets.only(bottom: 20, top: 10),
                      onPress: () {
                        controller.selectDateEndWorking(context);
                      },
                      error: controller.checkValidDateEndWork(),
                    ),
                    Center(
                        child: InkWell(
                      onTap: () {
                        waitLoginController.checkLogin.value ? controller.checkRequiredPostJob() : Get.dialog(DialogLoginPostJob());
                      },
                      child: Container(
                          width: width * 0.7,
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: AppColors.linearGradient1),
                          ),
                          child: Center(
                            child: Text(
                              "ĐĂNG VIỆC",
                              style: AppTextStyles.regularW700(context, size: 22),
                            ),
                          )),
                    )),
                    SizedBox(height: 50)
                  ],
                ),
              ),
              WillPopScope(
                onWillPop: () {
                  menuController.clearList();
                  registerController.searchCategoryTextEditingController.clear();
                  registerController.getSearchListCategory();
                  registerController.searchWorkPlaceTextEditingController.clear();
                  registerController.getSearchListWorkPlace();
                  Get.back();
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
