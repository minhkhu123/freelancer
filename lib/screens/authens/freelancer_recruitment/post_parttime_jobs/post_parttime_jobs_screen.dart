import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_data_by_project.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/screens/authens/freelancer_recruitment/post_parttime_jobs/post_partime_jobs_controller.dart';
import 'package:freelancer_app/widgets/custom_textfield_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/custom_textinput_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/custom_textiput_date.dart';
import 'package:freelancer_app/widgets/rectangle.dart';
import 'package:freelancer_app/widgets/select_drop_list.dart';
import 'package:get/get.dart';

class PostPartTimeJobsScreen extends StatelessWidget {
  final DataPost dataPost;

  PostPartTimeJobsScreen({Key key, this.dataPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GetBuilder<PostPartTimeJobsController>(
      init: PostPartTimeJobsController(dataPost: dataPost),
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Rectangle(height: height * 0.05, title: "Việc cần tuyển Freelancer"),
            Obx(() => Container(
                  height: height * 0.5,
                  width: width,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: controller.imageLogo.path,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Image.file(
                        controller.imageLogo,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Image.asset(Images.logo_tim365),
                      ),
                    ),
                  ),
                )),
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
                  onTap: controller.getImage,
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
              myFocusNode: controller.isFocus[0],
              textError: controller.error[0] ? "Bạn chưa nhập đủ thông tin" : null,
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              controller: controller.textEdtCtrlNameJobsRecruitment,
            ),
            CustomTextFieldFreelanceRecruitment(
              text: "Chọn lĩnh vực cần tuyển",
            ),
            SelectDropList(
              itemList: controller.optionItemRecruitmentFieldSelected,
              list: controller.listRecruitmentFieldModel.listItem,
              index: 1,
              currentIndex: controller.currentIndex,
              onOption: (item) {
                controller.optionItemRecruitmentFieldSelected = item;
                controller.getSkillFromCategory(item.id);
              },
            ),
            CustomTextFieldFreelanceRecruitment(text: "Yêu cầu kinh nghiệm"),
            SelectDropList(
              itemList: controller.selectedExp,
              list: controller.listExp.listItem,
              index: 2,
              currentIndex: controller.currentIndex,
              onOption: (item) {
                controller.selectedExp = item;
              },
            ),
            CustomTextFieldFreelanceRecruitment(text: "Hình thức làm việc"),
            SelectDropList(
              itemList: controller.optionItemWorkForm,
              list: controller.listModelWorkForm.listItem,
              index: 3,
              currentIndex: controller.currentIndex,
              onOption: (item) {
                controller.optionItemWorkForm = item;
              },
            ),
            CustomTextFieldFreelanceRecruitment(text: "Nơi làm việc"),
            SelectDropList(
              itemList: controller.optionSelectedCity,
              list: controller.listModelCity.listItem,
              index: 4,
              isCity: true,
              currentIndex: controller.currentIndex,
              onOption: (item) {
                controller.optionSelectedCity = item;
              },
            ),
            CustomTextFieldFreelanceRecruitment(text: "Thông tin chi tiết"),
            CustomEditTextFreelancerRecruitment(
              hintText: "VD: Thiết kế các giao diện website cần thiết như: Trang chủ, xem hàng, thanh toán...",
              isReadOnly: false,
              isIcon: false,
              padding: const EdgeInsets.only(bottom: 40, top: 10),
              maxLines: 6,
              myFocusNode: controller.isFocus[1],
              textError: controller.error[1] ? "Bạn chưa nhập đủ thông tin" : null,
              controller: controller.textEdtCtrlRequest,
            ),
            Text(
              "Thêm tài kiệu đính kèm",
              style: AppTextStyles.regularW400(context, size: 16, color: AppColors.blue),
            ),
            Text(
              controller.listFile != null ? controller.listFile.path.split('/').last : '',
              style: AppTextStyles.regularW500(context, size: 16, color: AppColors.grey5),
            ),
            Center(
              child: Container(
                width: width * 0.3,
                height: height * 0.05,
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: controller.uploadFile,
                  child: Center(child: Text("+ Tải lên")),
                ),
              ),
            ),
            Text(
              "Tải lên bất kỳ hình ảnh hoặc tài liệu mô tả ngắn gọn công việc (Kích thước tệp tối đa: 25 MB).",
              style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey5),
            ),
            SizedBox(height: 30),
            CustomTextFieldFreelanceRecruitment(text: "Kỹ năng yêu cầu Freelancer phải có"),
            SizedBox(
              height: 10,
            ),
            SelectDropList(
              list: controller.listModelSkill.listItem,
              itemList: controller.optionItemSelectedSkill,
              index: 5,
              currentIndex: controller.currentIndex,
              onOption: (item) {
                controller.optionItemSelectedSkill = item;
              },
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
                  decoration: BoxDecoration(border: Border.all(width: 1, color: AppColors.grey5), borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton(
                    value: controller.optionSelectedBy,
                    onChanged: (value) {
                      controller.onChangeMonth(value);
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
            SizedBox(height: 20),
            CustomTextFieldFreelanceRecruitment(text: "Ngày bắt đầu đặt giá"),
            CustomEditTextDateFreelancerRecruitment(
              hintText: controller.listMessage[0],
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              onPress: () {
                controller.selectDateStartDG(context);
              },
            ),
            CustomTextFieldFreelanceRecruitment(text: "Ngày đặt giá kết thúc"),
            CustomEditTextDateFreelancerRecruitment(
              hintText: controller.listMessage[1],
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              onPress: () {
                controller.selectDateEndDG(context);
              },
            ),
            CustomTextFieldFreelanceRecruitment(text: "Ngày bắt đầu làm việc"),
            CustomEditTextDateFreelancerRecruitment(
              hintText: controller.listMessage[2],
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              onPress: () {
                controller.selectDateStartWorking(context);
              },
            ),
            CustomTextFieldFreelanceRecruitment(text: "Ngày kết thúc làm việc"),
            CustomEditTextDateFreelancerRecruitment(
              hintText: controller.listMessage[3],
              padding: const EdgeInsets.only(bottom: 30, top: 10),
              onPress: () {
                controller.selectDateEndWorking(context);
              },
            ),
            Center(
                child: Container(
                    width: 245,
                    height: 44,
                    child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.orange)),
                        onPressed: controller.onUpdateJob,
                        child: Text(
                          "CẬP NHẬT",
                          style: AppTextStyles.regularW700(context, size: 22),
                        )))),
            SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
