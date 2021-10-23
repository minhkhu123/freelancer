import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_infor_uv.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/screens/authens/update_profile_ntd/update_profile_ntd_screen.dart';
import 'package:freelancer_app/screens/candidate/commplete_your_profile/complete_your_profile_controller.dart';
import 'package:freelancer_app/screens/candidate/introduce_yourself/introduce_yourself_screen.dart';
import 'package:freelancer_app/screens/home/home_screen.dart';
import 'package:freelancer_app/widgets/custom_textfield_changpw.dart';
import 'package:freelancer_app/widgets/custom_textfield_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/custom_textinput_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/custom_textiput_date.dart';
import 'package:freelancer_app/widgets/dialog_notification.dart';
import 'package:freelancer_app/widgets/item_list_checkBox.dart';
import 'package:freelancer_app/widgets/rectangle.dart';
import 'package:freelancer_app/widgets/select_drop_list.dart';
import 'package:freelancer_app/widgets/top_ongoing_project.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class CompleteYourProfileScreen extends StatelessWidget {
  CompleteYourProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CompleteYourProfileController>(
          init: CompleteYourProfileController(),
          builder: (controller) => SingleChildScrollView(
            child: Column(
              children: [
                TopOnGoingProject(
                  onPress: () {
                    Get.back();
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(width: 2, color: AppColors.blue)),
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
                            "Quản lý chung / Hoàn thiện hồ sơ",
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
                                title: "Thông tin cơ bản",
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                            ),
                            Center(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl: (controller.userInfo.pathAvt + '/' + controller.userInfo.avatar),
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) => CircleAvatar(
                                        radius: 60,
                                        backgroundColor: AppColors.grey5,
                                        child: SvgPicture.asset(
                                          Images.user,
                                          height: height * 0.05,
                                          width: width * 0.5,
                                          color: AppColors.white2,
                                        ),
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: CircleAvatar(
                                      radius: 23,
                                      backgroundColor: AppColors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: IconButton(
                                          icon: SvgPicture.asset(Images.ic_camera),
                                          onPressed: null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomTextFieldFreelanceRecruitment(text: "Họ và tên"),
                            CustomEditTextFreelancerRecruitment(
                              isIcon: false,
                              controller: controller.textEditingControllerName,
                              padding: const EdgeInsets.only(bottom: 20, top: 10),
                            ),
                            CustomTextFieldFreelanceRecruitment(text: "Ngày sinh"),
                            CustomEditTextDateFreelancerRecruitment(
                              hintText: controller.messageDate,
                              padding: const EdgeInsets.only(bottom: 20, top: 10),
                            ),
                            Center(
                              child: Container(
                                width: width * 0.35,
                                height: height * 0.05,
                                margin: const EdgeInsets.only(top: 10, bottom: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(UpdateProfileNTDScreen(role: true));
                                  },
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.orange)),
                                  child: Text(
                                    "Xem chi tiết",
                                    style: AppTextStyles.regularW700(context, size: 17),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              child: Rectangle(
                                height: 30,
                                title: "Giới thiệu bản thân",
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 30),
                            ),
                            CustomTextFieldChangPW(
                              text: "Kinh nghiệm làm việc",
                            ),
                            CustomEditTextFreelancerRecruitment(
                              isIcon: true,
                              hintText: controller.exp,
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Giới thiệu bản thân",
                              style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),
                            ),
                            CustomEditTextFreelancerRecruitment(
                              isIcon: false,
                              maxLines: 20,
                              hintText: controller.intro,
                              padding: const EdgeInsets.only(top: 10, bottom: 30),
                            ),
                            Center(
                              child: Container(
                                width: width * 0.35,
                                height: height * 0.05,
                                margin: const EdgeInsets.only(bottom: 40),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(IntroduceYourselfScreen());
                                  },
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.orange)),
                                  child: Text(
                                    "Xem chi tiết",
                                    style: AppTextStyles.regularW700(context, size: 17),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Rectangle(
                            height: 30,
                            title: "Công việc mong muốn",
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25, bottom: 10),
                            child: Text(
                              "Nghề nghệp",
                              style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),
                            ),
                          ),
                          CustomEditTextFreelancerRecruitment(
                            isIcon: false,
                            isReadOnly: false,
                            hintText: "VD: Thiết kế website",
                            controller: controller.ngheNghiep,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Công việc mong muốn",
                              style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),
                            ),
                          ),
                          SelectDropList(
                            itemList: controller.optionItemRecruitment,
                            list: controller.listModelRecruitment.listItem,
                            index: 1,
                            currentIndex: controller.currentIndex,
                            height: 300,
                            onOption: (item) {
                              controller.optionItemRecruitment = item;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Hình thức làm việc",
                              style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),
                            ),
                          ),
                          SelectDropList(
                            itemList: controller.optionItemWorkForm,
                            list: controller.listModelWorkForm.listItem,
                            index: 2,
                            currentIndex: controller.currentIndex,
                            onOption: (item) {
                              controller.optionItemWorkForm = item;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Nơi làm việc mong muốn",
                              style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),
                            ),
                          ),
                          SelectDropList(
                            itemList: controller.optionSelectedCity,
                            list: controller.listModelCity.listItem,
                            height: 300,
                            index: 3,
                            isCity: true,
                            currentIndex: controller.currentIndex,
                            onOption: (item) {
                              controller.optionSelectedCity = item;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              "Mức lương mong muốn",
                              style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: InkWell(
                                    onTap: !controller.isEstimatesOrPermanent ? controller.onChangePermanentOrEstimate : null,
                                    child: Center(
                                      child: Text(
                                        "Cố định",
                                        style: AppTextStyles.regularW500(context,
                                            size: 15, color: controller.isEstimatesOrPermanent ? AppColors.blue : AppColors.black),
                                      ),
                                    ),
                                  ),
                                  width: width * 0.25,
                                  height: height * 0.04,
                                  decoration: BoxDecoration(
                                      color: controller.isEstimatesOrPermanent ? AppColors.lightBlue : null,
                                      border: Border.all(width: 1, color: controller.isEstimatesOrPermanent ? AppColors.blue : AppColors.black),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      )),
                                ),
                                Container(
                                  width: width * 0.25,
                                  height: height * 0.04,
                                  decoration: BoxDecoration(
                                      color: !controller.isEstimatesOrPermanent ? AppColors.lightBlue : null,
                                      border: Border.all(width: 1, color: !controller.isEstimatesOrPermanent ? AppColors.blue : AppColors.black),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      )),
                                  child: InkWell(
                                    onTap: controller.isEstimatesOrPermanent ? controller.onChangePermanentOrEstimate : null,
                                    child: Center(
                                      child: Text(
                                        "Ước lượng",
                                        style: AppTextStyles.regularW500(context,
                                            size: 15, color: !controller.isEstimatesOrPermanent ? AppColors.blue : AppColors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              controller.isEstimatesOrPermanent
                                  ? Expanded(
                                      child: CustomEditTextFreelancerRecruitment(
                                        hintText: "Nhập mức lương",
                                        isSubText: true,
                                        isIcon: false,
                                        isReadOnly: false,
                                        controller: controller.luongCoDinh,
                                        textError: controller.textErrorCD.value.isEmpty ? null : controller.textErrorCD.value,
                                        textInputType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      ),
                                    )
                                  : Expanded(
                                      child: Column(
                                        children: [
                                          CustomEditTextFreelancerRecruitment(
                                            hintText: "Mức lương bắt đầu",
                                            isSubText: true,
                                            isIcon: false,
                                            isReadOnly: false,
                                            controller: controller.luongULBD,
                                            textError: controller.textError.value.isEmpty ? null : controller.textError.value,
                                            textInputType: TextInputType.number,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5),
                                              child: Text(
                                                'Đến',
                                                style: AppTextStyles.regularW500(context, size: 15, color: AppColors.black),
                                              )),
                                          CustomEditTextFreelancerRecruitment(
                                            hintText: "Mức lương kết thúc",
                                            isSubText: true,
                                            isIcon: false,
                                            isReadOnly: false,
                                            controller: controller.luongULKT,
                                            textError: controller.textError.value.isEmpty ? null : controller.textError.value,
                                            textInputType: TextInputType.number,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          )
                                        ],
                                      ),
                                    ),
                              Padding(
                                child: Text(
                                  "/",
                                  style: AppTextStyles.regularW400(context, size: 18, color: AppColors.black),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              ),
                              Container(
                                width: width * 0.3,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.4),
                                margin: const EdgeInsets.only(top: 1.3),
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1, color: AppColors.grey5), borderRadius: BorderRadius.circular(8)),
                                child: DropdownButton(
                                  value: controller.optionSelectedBy,
                                  onChanged: (OptionItem value) {
                                    controller.onChangeDropdown(value);
                                  },
                                  underline: SizedBox(),
                                  hint: Text(controller.optionSelectedBy.title),
                                  items: controller.listModelBy.listItem
                                      .map<DropdownMenuItem<OptionItem>>(
                                        (e) => DropdownMenuItem(
                                            value: e,
                                            child: Center(
                                              child: Container(
                                                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: AppColors.grey5))),
                                                child: Center(child: Text(e.title)),
                                              ),
                                            )),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Container(
                              width: width * 0.35,
                              height: height * 0.05,
                              margin: const EdgeInsets.only(top: 30, bottom: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (controller.onValidateSalary()) {
                                    Get.snackbar('Message', "Lương ước lương bạn đã nhập sai");
                                  } else {
                                    controller.updateJobDesired(
                                        token: SpUtil.getString(ConstString.token),
                                        job: controller.ngheNghiep.text,
                                        desiredJob: controller.optionItemRecruitment.id ?? 0,
                                        type: controller.optionItemWorkForm.id ?? 0,
                                        desiredCity: controller.optionSelectedCity.id ?? 0,
                                        salaryType: controller.isEstimatesOrPermanent ? 1 : 2,
                                        salary: controller.isEstimatesOrPermanent
                                            ? controller.luongCoDinh.text.replaceAll(',', '')
                                            : '${controller.luongULBD.text.replaceAll(',', '')},${controller.luongULKT.text.replaceAll(',', '')}',
                                        salaryDepend: controller.optionSelectedBy.id);
                                  }
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.orange)),
                                child: Text(
                                  "Cập nhật",
                                  style: AppTextStyles.regularW700(context, size: 17),
                                ),
                              ),
                            ),
                          ),
                          Rectangle(
                            title: "Kỹ năng",
                            height: 30,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 2 / 2.5,
                            children: controller.listField
                                .map((e) => InkWell(
                                    onTap: () {
                                      controller.selectSkill(controller.listField.indexOf(e));
                                    },
                                    child: customCareerTile(
                                      name: e.name,
                                      logo: e.img,
                                      color: controller.idSkill == controller.listField.indexOf(e) ? AppColors.orange : AppColors.grey,
                                      isColorText: e.isColorText,
                                    )))
                                .toList(),
                          ),
                          Divider(),
                          SizedBox(height: 20),
                          Text(
                            "Chọn kỹ năng ngành ${controller.listField[controller.idSkill].name}",
                            style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                          ),
                          Column(
                            children: controller.codeLanguage
                                .map(
                                  (e) => ItemListCheckBox(
                                    isCheck: controller.listSelectSkill.contains(e),
                                    onChanged: (value) {
                                      if (controller.category.length < 2 && !controller.category.contains(controller.idSkill.toString())) {
                                        controller.category.add(controller.idSkill.toString());
                                      }
                                      if (controller.category.length < 2 || controller.category.contains(controller.idSkill.toString())) {
                                        controller.onChangeCkeckBox(value, e);
                                      } else {
                                        Get.dialog(DialogNotification(message: 'Lĩnh vực của bạn đã chọn là ${controller.selectNameCategory()}'));
                                        return;
                                      }
                                    },
                                    text: e.name,
                                  ),
                                )
                                .toList(),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Column(
                          //       children: [
                          //         Text(
                          //           "Xem thêm",
                          //           style: AppTextStyles.regularW700(
                          //               context,
                          //               size: 15,
                          //               color: AppColors.orange),
                          //         ),
                          //         Container(
                          //           height: 2,
                          //           width: 65,
                          //           color: AppColors.orange,
                          //           child: Text(" "),
                          //         )
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     SvgPicture.asset(Images.ic_doubleDown)
                          //   ],
                          // ),
                          Padding(padding: const EdgeInsets.symmetric(vertical: 30), child: Divider()),
                          Row(
                            children: [
                              Text(
                                "Kỹ năng được chọn",
                                style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    controller.listSelectSkill.length.toString(),
                                    style: AppTextStyles.regularW700(context, size: 18, color: AppColors.blue),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: controller.listSelectSkill.length >= 1 ? height * 0.3 : height * 0.01,
                            margin: const EdgeInsets.only(top: 30),
                            child: StaggeredGridView.countBuilder(
                              crossAxisCount: 2,
                              itemCount: controller.listSelectSkill.length,
                              itemBuilder: (context, index) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.listSelectSkill[index].name,
                                    style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black3),
                                  ),
                                  Container(
                                      height: 20,
                                      width: 20,
                                      margin: const EdgeInsets.only(left: 20),
                                      child: InkWell(
                                        onTap: () {
                                          controller.onChangeCkeckBox(false, controller.listSelectSkill[index]);
                                        },
                                        child: SvgPicture.asset(Images.ic_remove, width: 10,height: 10,),
                                      ))
                                ],
                              ),
                              staggeredTileBuilder: (index) => StaggeredTile.fit((controller.listSelectSkill[index].name.length >= 17) ? 2 : 1),
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                          ),
                          Center(
                            child: Container(
                              width: width * 0.35,
                              height: height * 0.05,
                              margin: const EdgeInsets.only(bottom: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.updateSkill(
                                      token: SpUtil.getString(ConstString.token),
                                      category: controller.category.join(','),
                                      skills: controller.skill.join(','));
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.orange)),
                                child: Text(
                                  "Cập nhật",
                                  style: AppTextStyles.regularW700(context, size: 17),
                                ),
                              ),
                            ),
                          ),
                          Rectangle(height: 30, title: "Hồ sơ năng lực"),
                          Container(
                            height: height * 0.25,
                            child: PageView.builder(
                              itemBuilder: (context, index) {
                                return Container(padding: const EdgeInsets.only(left: 5, right: 5), child: Image.asset(Images.test_page_view_detail));
                              },
                              itemCount: 5,
                              controller: PageController(initialPage: 1, viewportFraction: 0.8),
                            ),
                          ),
                          SizedBox(height: 20),
                          Obx(() => Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    for (ProjectFile item in controller.listProjectFile) ...[
                                      Text(
                                        item.nameProject,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black3),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                                        child: Text(
                                          item.nameFile,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.blue),
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            UtilsData.launchURL(item.pathFile);
                                          },
                                          child: Text(
                                            "Tải xuống",
                                            style: AppTextStyles.regularW700(context, size: 16),
                                          )),
                                      SizedBox(height: 25)
                                    ]
                                  ],
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Thêm hồ sơ năng lực của bạn",
                              style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),
                            ),
                          ),
                          CustomEditTextFreelancerRecruitment(
                            isIcon: false,
                            isReadOnly: false,
                            hintText: "Tên dự án",
                            controller: controller.nameProject,
                          ),
                          SizedBox(height: 20),
                          DottedBorder(
                            dashPattern: [5],
                            color: AppColors.grey5,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(8),
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    width: width * 0.3,
                                    height: height * 0.05,
                                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                                    decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(8)),
                                    child: InkWell(
                                      onTap: controller.upLoadFile,
                                      child: Center(child: Text("+ Tải lên")),
                                    ),
                                  ),
                                ),
                                Obx(
                                      () => Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: Text(
                                        controller.file.path.split('/').last,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.regularW400(context, size: 16, color: AppColors.blue),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                                  child: Text(
                                    "Tải lên bất kỳ hình ảnh hoặc tài liệu mô tả ngắn gọn công việc (Kích thước tệp tối đa: 25 MB).",
                                    style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              width: width * 0.35,
                              height: height * 0.05,
                              margin: const EdgeInsets.only(top: 30, bottom: 30),
                              child: ElevatedButton(
                                onPressed: controller.updateProjectFile,
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.orange)),
                                child: Text(
                                  "Cập nhật",
                                  style: AppTextStyles.regularW700(context, size: 17),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
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
