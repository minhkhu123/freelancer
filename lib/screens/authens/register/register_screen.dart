import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/login/login_screen.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/widgets/custom_button.dart';
import 'package:freelancer_app/widgets/custom_career_box.dart';
import 'package:freelancer_app/widgets/custom_textfield_register.dart';
import 'package:freelancer_app/widgets/custom_textfield_register_unicon.dart';
import 'package:freelancer_app/widgets/select_drop_list_city.dart';
import 'package:freelancer_app/widgets/select_drop_list_district.dart';
import 'package:freelancer_app/widgets/select_drop_list_month.dart';
import 'package:freelancer_app/widgets/select_drop_list_sex.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(Images.top_route_1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: GetBuilder<RegisterController>(
                init: RegisterController(),
                builder: (controller) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.clearList();
                              Get.back();
                            },
                            icon: SvgPicture.asset(Images.ic_back)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        controller.whoYouAre ? SvgPicture.asset(Images.logo_register_freelancer) : SvgPicture.asset(Images.logo_register_employer),
                        SizedBox(height: 20),
                        controller.imageAvatar == null
                            ? SvgPicture.asset(Images.logo_user)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  controller.imageAvatar,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.fill,
                                ),
                              ),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            controller.imgFromGallery();
                          },
                          child: Container(
                            height: height * 0.06,
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.grey),
                            ),
                            child: Center(
                              child: Text(
                                'T???i l??n ???nh ?????i di???n',
                                style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    _nameText(
                      name: 'H??? v?? t??n ',
                    ),
                    CustomTextFieldRegisterUnIcon(
                      isPassword: true,
                      hintText: 'Nh???p h??? v?? t??n',
                      textEditingController: controller.nameTextEditingController,
                      error: controller.checkValidName(),
                    ),
                    _nameText(
                      name: 'Gi???i t??nh ',
                    ),
                    SelectDropListSex(controller.optionItemSelected, controller.dropListModel, (optionItem) {
                      controller.optionItemSelected = optionItem;
                      controller.changeGender();
                    }, controller.checkValidSex()),
                    _nameText(
                      name: 'Ng??y sinh ',
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: TextFormField(
                          readOnly: true,
                          onTap: () {
                            controller.selectDate(context);
                          },
                          decoration: InputDecoration(
                            errorText: controller.checkValidBirth(),
                            hintText: controller.checkBirth.value
                                ? "${controller.valueDate.day.toString().padLeft(2, '0')}-${controller.valueDate.month.toString().padLeft(2, '0')}-${controller.valueDate.year}"
                                : 'Ch???n ng??y sinh',
                            hintStyle: AppTextStyles.regularW400(context, size: 15, color: AppColors.black),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: SvgPicture.asset(
                                Images.ic_calendar,
                              ),
                            ),
                            suffixIconConstraints: BoxConstraints(
                              maxWidth: 30,
                              maxHeight: 26,
                            ),
                          )),
                    ),
                    _nameText(
                      name: 'T???nh/Th??nh ph??? ',
                    ),
                    SelectDropListCity(
                      title: controller.nameCity.value,
                      error: controller.checkValidCity(),
                    ),
                    _nameText(
                      name: 'Qu???n/Huy???n ',
                    ),
                    SelectDropListDistrict(
                      title: controller.nameDistrict.value,
                      error: controller.checkValidDistrict(),
                    ),
                    _nameText(
                      name: 'S??? ??i???n tho???i',
                    ),
                    CustomTextFieldRegisterUnIcon(
                      isPassword: true,
                      keyboardType: TextInputType.number,
                      textEditingController: controller.phoneTextEditingController,
                      hintText: 'Nh???p s??? ??i???n tho???i',
                      length: 10,
                      focusNode: controller.focusNodePhone,
                      error: controller.checkValidPhone(),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    _nameText(
                      name: 'Email ',
                    ),
                    CustomTextFieldRegisterUnIcon(
                      isPassword: true,
                      textEditingController: controller.emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Nh???p Email',
                      focusNode: controller.focusNode,
                      error: controller.checkValidEmail(),
                      inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                    ),
                    _nameText(
                      name: 'M???t kh???u ',
                    ),
                    CustomTextFieldRegister(
                      isPassword: controller.isPassword.value,
                      textEditingController: controller.passwordTextEditingController,
                      hintText: 'Nh???p m???t kh???u',
                      iconData: controller.isPassword.value
                          ? SvgPicture.asset(
                              Images.ic_eye_close,
                              color: Colors.black,
                            )
                          : SvgPicture.asset(
                              Images.ic_eye,
                              color: Colors.black,
                            ),
                      onPressed: () {
                        controller.changeShow();
                      },
                      onChanged: (value) {
                        controller.showError.value = 0.0;
                      },
                      error: controller.checkValidPassword(),
                      inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                    ),
                    _nameText(
                      name: 'Nh???p l???i m???t kh???u ',
                    ),
                    CustomTextFieldRegister(
                      isPassword: controller.isConfirmPassword.value,
                      textEditingController: controller.confirmPasswordTextEditingController,
                      hintText: 'Nh???p l???i m???t kh???u',
                      iconData: controller.isConfirmPassword.value
                          ? SvgPicture.asset(
                              Images.ic_eye_close,
                              color: Colors.black,
                            )
                          : SvgPicture.asset(
                              Images.ic_eye,
                              color: Colors.black,
                            ),
                      onPressed: () {
                        controller.changeShowConfirm();
                      },
                      onChanged: (value) {
                        controller.showError.value = 0.0;
                      },
                      error: controller.checkValidConfirmPassword(),
                      inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                    ),
                    controller.whoYouAre
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  _nameText(
                                    name: 'M???c l????ng',
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      controller.indexSalaryType.value = 1;
                                      controller.checkSalaryCon();
                                      controller.apiSalary();
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
                                        'C??? ?????nh',
                                        style: AppTextStyles.regularW500(context,
                                            size: 15, color: controller.indexSalaryType.value == 1 ? AppColors.blue2 : AppColors.black),
                                      )),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.indexSalaryType.value = 2;
                                      controller.checkSalaryCon();
                                      controller.apiSalary();
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
                                        '?????c l?????ng',
                                        style: AppTextStyles.regularW500(context,
                                            size: 15, color: controller.indexSalaryType.value == 2 ? AppColors.blue2 : AppColors.black),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              controller.indexSalaryType.value == 1
                                  ? Row(
                                      children: [
                                        Container(
                                          width: width * 0.42,
                                          child: CustomTextFieldRegisterUnIcon(
                                            isPassword: true,
                                            keyboardType: TextInputType.number,
                                            textEditingController: controller.salaryTextEditingController,
                                            hintText: 'Nh???p m???c l????ng (VN??)',
                                            error: controller.checkValidSalary(),
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Text('/'),
                                        SizedBox(width: 4),
                                        Container(
                                          width: width * 0.31,
                                          padding: controller.upTimed.value ? EdgeInsets.only(bottom: 20) : EdgeInsets.only(bottom: 7),
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
                                      ],
                                    )
                                  : controller.indexSalaryType.value == 2
                                      ? CustomTextFieldRegisterUnIcon(
                                          isPassword: true,
                                          keyboardType: TextInputType.number,
                                          textEditingController: controller.salaryTextEditingController,
                                          hintText: 'Nh???p m???c l????ng (VN??)',
                                          error: controller.checkValidSalary(),
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        )
                                      : Container(),
                              controller.indexSalaryType.value == 2
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          '?????n: (m???c l????ng)',
                                          style: AppTextStyles.regularW500(context, size: 15, color: AppColors.black),
                                        ),
                                        SizedBox(height: 10),
                                        CustomTextFieldRegisterUnIcon(
                                          isPassword: true,
                                          hintText: "VD: 5.000.000",
                                          keyboardType: TextInputType.number,
                                          textEditingController: controller.salarySecTextEditingController,
                                          error: controller.checkValidSalaryEnd(),
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        ),
                                      ],
                                    )
                                  : Container(),
                              controller.indexSalaryType.value == 2
                                  ? Container(
                                      width: width * 0.35,
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
                              SizedBox(height: 10),
                              _nameText(
                                name: 'Ngh??? nghi???p',
                              ),
                              CustomTextFieldRegisterUnIcon(
                                isPassword: true,
                                textEditingController: controller.jobTextEditingController,
                                hintText: 'Nh???p ngh??? nghi???p',
                                error: controller.checkValidJob(),
                              ),
                              _nameText(
                                name: 'L??nh v???c l??m vi???c',
                              ),
                              SizedBox(height: 7),
                              Text(
                                '(B???n c?? th??? ch???n nhi???u l??nh v???c)',
                                style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey),
                              ),
                              SizedBox(height: 20),
                              Container(
                                  height: height,
                                  child: ListView.builder(
                                    itemCount: controller.listCategory.length,
                                    itemBuilder: (context, index) => CustomCareerBox(
                                      name: controller.listCategory[index].tenLinhVuc,
                                      index: index,
                                    ),
                                  ))
                            ],
                          )
                        : Container(),
                    SizedBox(height: 30),
                    CustomButton(
                      title: '????ng k??',
                      onPressed: controller.whoYouAre
                          ? () {
                              controller.checkButtonRegisterCandidate();
                              controller.upTime();
                              controller.registerCandidate();
                            }
                          : () {
                              controller.checkButtonRegisterCompany();
                              controller.registerCompany();
                            },
                    ),
                    SizedBox(height: 27),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 62),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'B???n ???? c?? t??i kho???n? ',
                            style: AppTextStyles.regularW400(context, size: 15, color: Colors.black),
                          ),
                          InkWell(
                              onTap: () {
                                Get.to(LoginScreen());
                                // controller.emailTextEditingController.clear();
                                // controller.passwordTextEditingController.clear();
                                // controller.checkValidUserAndPassword();
                                // controller.showError.value = 0.0;
                              },
                              child: Text(
                                '????NG NH???P NGAY',
                                style: AppTextStyles.regularW700(context, size: 16, color: AppColors.blue),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class _nameText extends StatelessWidget {
  const _nameText({
    Key key,
    this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Text(
            name,
            style: AppTextStyles.regularW500(context, size: 16, color: Colors.black),
          ),
          Text(
            '*',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
