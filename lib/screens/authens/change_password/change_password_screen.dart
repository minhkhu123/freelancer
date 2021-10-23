import 'package:flutter/material.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/address.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/change_password/change_password_controller.dart';
import 'package:freelancer_app/widgets/custom_editting_changpw.dart';
import 'package:freelancer_app/widgets/custom_textfield_changpw.dart';
import 'package:freelancer_app/widgets/top_employer_profile.dart';
import 'package:freelancer_app/widgets/top_ongoing_project.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class ChangePasswordScreen extends StatelessWidget {
  final bool checkWhoUr;
  ChangePasswordScreen({this.checkWhoUr});
  @override
  Widget build(BuildContext context) {
    var wight = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<ChangePasswordController>(
            init: ChangePasswordController(),
            builder: (controller) => Column(
              children: [
                checkWhoUr
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
                  width: wight,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: AppColors.blue),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Đổi mật khẩu",
                          style: AppTextStyles.regularW500(context, size: 19),
                        ),
                        width: wight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          color: AppColors.blue,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, top: 20, right: 8),
                        child: Column(
                          children: [
                            CustomTextFieldChangPW(
                              text: "Mật khẩu hiện tại",
                            ),
                            CustomEditTextChangePW(
                              hintText: "Nhập mật khẩu hiện tại",
                              isEye: !controller.isEyeMKHT,
                              changeEyePW: controller.changEyePasswordHT,
                              controller: controller.passwordHTTextController,
                              textError: controller.errorPWHT,
                            ),
                            SizedBox(height: 15),
                            CustomTextFieldChangPW(
                              text: "Mật khẩu khẩu mới",
                            ),
                            CustomEditTextChangePW(
                              hintText: 'Nhập mật khẩu mới',
                              isEye: !controller.isEyeMKNew,
                              changeEyePW: controller.changEyePasswordNew,
                              controller: controller.passwordNewTextController,
                              textError: controller.errorPWNew,
                            ),
                            SizedBox(height: 15),
                            CustomTextFieldChangPW(
                              text: "Nhập lại mật khẩu mới",
                            ),
                            CustomEditTextChangePW(
                              hintText: 'Nhập lại mật khẩu mới',
                              isEye: !controller.isEyeMKNewRP,
                              changeEyePW: controller.changEyePasswordRP,
                              controller: controller.passwordRPTextController,
                              textError: controller.errorPWRP,
                            ),
                            SizedBox(height: 64),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: wight * 0.37,
                                  child: ElevatedButton(
                                    onPressed: checkWhoUr ? () {
                                      controller.changPw(Address.CHANGE_PASSWORD_FREELANCER,
                                          token: SpUtil.getString(ConstString.token),
                                          oldPW: controller.passwordHT,
                                          newPW: controller.passwordNew);
                                    } : () {
                                      controller.checkOldPassNTD();
                                      controller.changPw(Address.DOI_MK_NTD,
                                          token: SpUtil.getString(ConstString.token),
                                          oldPW: controller.passwordHT,
                                          newPW: controller.passwordNew);
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)
                                      )),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppColors.orange)),
                                    child: Text(
                                      "Đổi mật khẩu",
                                      style: AppTextStyles.regularW500(context,
                                          size: 17),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: height * 0.06,
                                  width: wight * 0.37,
                                  margin: const EdgeInsets.only(left: 20),
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Center(
                                      child: Text(
                                        "Hủy",
                                        style: AppTextStyles.regularW400(
                                            context,
                                            size: 17,
                                            color: AppColors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ),
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
