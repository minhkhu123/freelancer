import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/http/address.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/screens/authens/update_profile_ntd/update_profile_ntd_controller.dart';
import 'package:freelancer_app/widgets/custom_textfield_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/custom_textinput_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/custom_textiput_date.dart';
import 'package:freelancer_app/widgets/rectangle.dart';
import 'package:freelancer_app/widgets/select_drop_list.dart';
import 'package:freelancer_app/widgets/top_employer_profile.dart';
import 'package:freelancer_app/widgets/top_ongoing_project.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class UpdateProfileNTDScreen extends StatelessWidget {
  //role = true là freelancer
  //role = false là NTD
  final bool role;

  UpdateProfileNTDScreen({Key key, @required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<UpdateProfileNTDController>(
          init: UpdateProfileNTDController(checkWhoUR: role),
          builder: (controller) => SingleChildScrollView(
            child: Column(
              children: [
                this.role
                    ? TopOnGoingProject(
                        onPress: () {
                          Get.back();
                        },
                      )
                    : TopEmployerProfile(
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
                            this.role ? "... / Thông tin cơ bản" : "... / Cập nhật thông tin",
                            style: AppTextStyles.regularW500(context, size: 18),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Padding(
                              child: Rectangle(
                                height: 30,
                                title: this.role ? "Thông tin cơ bản" : "Cập nhật thông tin",
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                            ),
                            Stack(
                              children: [
                                Obx(() => ClipRRect(
                                      child: CachedNetworkImage(
                                        imageUrl: controller.imgAvatar.path,
                                        width: 130,
                                        height: 130,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => SizedBox(
                                          height: 10,
                                          width: 10,
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, error, stackTrace) => ClipRRect(
                                          child: Image.file(
                                            controller.imgAvatar,
                                            height: 130,
                                            width: 130,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => CircleAvatar(
                                              backgroundColor: AppColors.grey5,
                                              radius: 65,
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
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    )),
                                Positioned(
                                  right: -2,
                                  bottom: -2,
                                  child: CircleAvatar(
                                    radius: 23,
                                    backgroundColor: AppColors.white,
                                    child: CircleAvatar(
                                      radius: 20,
                                      child: IconButton(
                                        icon: SvgPicture.asset(Images.ic_camera),
                                        onPressed: controller.showDialogImage,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            CustomTextFieldFreelanceRecruitment(text: "Họ và tên"),
                            Obx(
                              () => CustomEditTextFreelancerRecruitment(
                                hintText: "VD: Nguyễn Thu Quỳnh",
                                isIcon: false,
                                isReadOnly: false,
                                myFocusNode: controller.isFocus[0],
                                textError: controller.error[0] ? "Bạn chưa nhập đủ thông tin" : null,
                                controller: controller.textEditingControllerName,
                                padding: const EdgeInsets.only(bottom: 20, top: 10),
                              ),
                            ),
                            CustomTextFieldFreelanceRecruitment(text: "Ngày sinh"),
                            CustomEditTextDateFreelancerRecruitment(
                              hintText: controller.messageDate,
                              padding: const EdgeInsets.only(bottom: 20, top: 10),
                              onPress: () {
                                controller.selectDate(context);
                              },
                            ),
                            CustomTextFieldFreelanceRecruitment(text: "Giới tính"),
                            SelectDropList(
                              list: controller.dropListModelSex.listItem,
                              itemList: controller.optionItemSexSelected,
                              index: 1,
                              currentIndex: controller.currentIndex,
                              onOption: (item) {
                                controller.selectedSex(item);
                              },
                            ),
                            CustomTextFieldFreelanceRecruitment(text: "Số điện thoại đăng nhập"),
                            Obx(() => CustomEditTextFreelancerRecruitment(
                                  hintText: "Số điện thoại",
                                  isIcon: false,
                                  myFocusNode: controller.isFocus[1],
                                  textError: Utils.checkValidPhone(controller.textEditingControllerSDT.text),
                                  textInputType: TextInputType.number,
                                  controller: controller.textEditingControllerSDT,
                                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                                  maxLength: 10,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                )),
                            CustomTextFieldFreelanceRecruitment(text: "Email"),
                            Obx(() => CustomEditTextFreelancerRecruitment(
                                  hintText: "Nhập địa chỉ Email",
                                  isIcon: false,
                                  myFocusNode: controller.isFocus[2],
                                  textError: Utils.checkValidEmail(controller.textEditingControllerEmail.text),
                                  controller: controller.textEditingControllerEmail,
                                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                                )),
                            CustomTextFieldFreelanceRecruitment(text: "Tỉnh/Thành phố"),
                            SelectDropList(
                              itemList: controller.optionItemSelectedCity,
                              list: controller.dropListModelCity.listItem,
                              index: 2,
                              currentIndex: controller.currentIndex,
                              height: 300,
                              isCity: true,
                              onOption: (item) {
                                controller.selectedCity(item);
                              },
                            ),
                            CustomTextFieldFreelanceRecruitment(text: "Quận/Huyện"),
                            SelectDropList(
                              itemList: controller.optionItemSelectedDistrict,
                              list: controller.dropListModelDistrict.listItem,
                              height: 300,
                              index: 3,
                              isCity: false,
                              currentIndex: controller.currentIndex,
                              onOption: (item) {
                                controller.selectedDistrict(item);
                              },
                            ),
                            Center(
                                child: Container(
                                    width: width * 0.5,
                                    height: height * 0.055,
                                    margin: const EdgeInsets.symmetric(vertical: 30),
                                    child: ElevatedButton(
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.orange)),
                                        onPressed: () {
                                          role
                                              ? controller.updateProfile(Address.UPDATE_INFORMATION_FREELANCER,
                                                  token: SpUtil.getString(ConstString.token))
                                              : controller.updateProfile(Address.CAP_NHAT_THONG_TIN_NTD, token: SpUtil.getString(ConstString.token));
                                        },
                                        child: Text(
                                          "CẬP NHẬT",
                                          style: AppTextStyles.regularW700(context, size: 22),
                                        )))),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
