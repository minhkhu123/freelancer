import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_confirm_otp_ntd.dart';
import 'package:freelancer_app/common/shared/data/models/result_confirm_otp_uv.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_category.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_city.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_district.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/shared/data/models/result_register_candidate.dart';
import 'package:freelancer_app/common/shared/data/models/result_register_company.dart';
import 'package:freelancer_app/common/shared/data/repositories/authen_repositories.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/screens/authens/register/success_register_screen.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/widgets/dialog_loading.dart';

import 'package:freelancer_app/widgets/drop_list_model_month.dart';
import 'package:freelancer_app/widgets/drop_list_model_sex.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sp_util/sp_util.dart';

import 'otp_screen.dart';

class RegisterController extends GetxController {
  AuthenticationRepositories _authenticationRepositories = AuthenticationRepositories();

  WaitLoginController waitLoginController = Get.put(WaitLoginController());

  RxBool isPassword = false.obs;
  RxBool isConfirmPassword = false.obs;
  RxDouble showError = 0.0.obs;
  RxDouble showSalary = 0.0.obs;
  File imageAvatar;
  final picker = ImagePicker();
  RxBool checkBirth = false.obs;
  RxInt indexFieldJob = 0.obs;
  DateTime valueDate = DateTime.now();
  RxBool chooseCity = false.obs;
  RxString nameCity = ''.obs;
  RxInt indexCity = 0.obs;
  RxBool chooseDistrict = false.obs;
  RxString nameDistrict = ''.obs;
  RxInt indexDistrict = 0.obs;
  RxBool chooseCategory = false.obs;
  RxString nameCategory = ''.obs;
  RxInt indexSalaryType = 0.obs;
  RxBool buttonRegister = false.obs;

  RxString salaryAPI = ''.obs;
  FocusNode focusNode = FocusNode();
  RxBool checkFocus = false.obs;
  FocusNode focusNodePhone = FocusNode();
  RxBool checkFocusPhone = false.obs;

  String errorEmail;
  String errorPhone;

  ResultGetCategory resultGetCategory = ResultGetCategory();

  List<ListCity> listCity = [];
  List<ListCity> listSearchCity = [];
  List<ListCity> listSearchWorkPlace = [];
  List<ListDistrict> listDistrict = [];
  List<ListCategory> listCategory = [];
  List<ListCategory> listSearchCategory = [];
  List<String> listHaveCategory = [];
  List<bool> listCheckCategory = [];

  Map<String, bool> listField = {
    'IT & l???p tr??nh': false,
    'Thi???t k???': false,
    'Vi???t l??ch & D???ch thu???t': false,
    'Kinh doanh, Nh???p li???u & H??nh ch??nh': false,
    'Ki???n tr??c & X??y d???ng': false,
    'Video': false,
    'K??? to??n, Thu??? & Lu???t': false,
    'L??nh v???c kh??c': false,
  };

  DropListModelSex dropListModel =
      DropListModelSex([OptionItemSex(id: "1", title: "Nam"), OptionItemSex(id: "2", title: "N???"), OptionItemSex(id: "3", title: "Kh??c")]);
  OptionItemSex optionItemSelected = OptionItemSex(id: null, title: "Ch???n gi???i t??nh");

  DropListModelMonth dropListModelMonth = DropListModelMonth([
    OptionItemMonth(id: "1", title: "Ng??y"),
    OptionItemMonth(id: "2", title: "Tu???n"),
    OptionItemMonth(id: "3", title: "Th??ng"),
    OptionItemMonth(id: "4", title: "N??m"),
  ]);
  OptionItemMonth optionItemSelectedMonth = OptionItemMonth(id: null, title: "Th???i gian");

  RxInt genderRegister = 0.obs;
  RxInt salaryDependRegister = 0.obs;
  RxString birthRegister = ''.obs;

  RxBool checkRegister = false.obs;
  RxBool checkOTP = false.obs;
  RxBool checkEmailExist = false.obs;
  RxBool checkPhoneExist = false.obs;

  bool whoYouAre;

  void checkEmailExisted() {
    checkEmailExist.value;
    update();
  }

  void checkPhoneExisted() {
    checkPhoneExist.value;
    update();
  }

  void checkRes() {
    checkRegister.value;
    update();
  }

  void onChangeUtilities(bool value, String key) {
    listField[key] = !listField[key];
    listField[key] = value;
    update();
  }

  TextEditingController nameTextEditingController = TextEditingController();

  String get name => nameTextEditingController.text;

  TextEditingController phoneTextEditingController = TextEditingController();

  String get phone => phoneTextEditingController.text;

  TextEditingController emailTextEditingController = TextEditingController();

  String get email => emailTextEditingController.text;

  TextEditingController passwordTextEditingController = TextEditingController();

  String get password => passwordTextEditingController.text;

  TextEditingController confirmPasswordTextEditingController = TextEditingController();

  String get confirmPassword => confirmPasswordTextEditingController.text;

  TextEditingController otpTextEditingController = TextEditingController();

  String get otp => otpTextEditingController.text;

  TextEditingController salaryTextEditingController = TextEditingController();

  String get salaryInput => salaryTextEditingController.text;

  TextEditingController salarySecTextEditingController = TextEditingController();

  String get salarySecInput => salarySecTextEditingController.text;

  TextEditingController jobTextEditingController = TextEditingController();

  String get job => jobTextEditingController.text;

  TextEditingController searchCityTextEditingController = TextEditingController();

  String get searchCity => searchCityTextEditingController.text;

  TextEditingController searchCityFilterTextEditingController = TextEditingController();

  String get searchCityFilter => searchCityFilterTextEditingController.text;

  TextEditingController searchWorkPlaceTextEditingController = TextEditingController();

  String get searchWorkPlace => searchWorkPlaceTextEditingController.text;

  TextEditingController searchCategoryTextEditingController = TextEditingController();

  String get searchCategory => searchCategoryTextEditingController.text;

  TextEditingController searchCategoryFilterTextEditingController = TextEditingController();

  String get searchCategoryFilter => searchCategoryFilterTextEditingController.text;

  void clearList() {
    listCategory.clear();
    listCity.clear();
    listDistrict.clear();
    update();
  }

  void changeGender() {
    genderRegister.value = int.parse(optionItemSelected.id);
    update();
  }

  void changeSalaryTime() {
    salaryDependRegister.value = int.parse(optionItemSelectedMonth.id);
    update();
  }

  void checkBirthday() {
    checkBirth.value;
    update();
  }

  void checkSalaryCon() {
    indexSalaryType.value;
    update();
  }

  void change(int index) {
    listCheckCategory[index] = !listCheckCategory[index];
    if (listCheckCategory[index] == true) {
      listHaveCategory.add(listCategory[index].maLinhVuc);
    } else {
      listHaveCategory.remove(listCategory[index].maLinhVuc);
    }
    update();
  }

  void changeShow() {
    isPassword.value = !isPassword.value;
    update();
  }

  void showCity() {
    chooseCity.value;
    update();
  }

  void showDistrict() {
    chooseDistrict.value;
    update();
  }

  void showCategory() {
    chooseCategory.value;
    update();
  }

  void changeShowConfirm() {
    isConfirmPassword.value = !isConfirmPassword.value;
    update();
  }

  Future imgFromGallery() async {
    final image = await picker.getImage(source: ImageSource.gallery);

    imageAvatar = File(image.path);
    update();
  }

  void checkValidUserAndPassword() {
    if (email.length > 6 && email.contains('@') && email.contains('.') && password.length > 7) {
      showError.value = 0.0;
    } else {
      showError.value = 1.0;
    }
    update();
  }

  void checkSalaryValue() {
    if (salaryInput.length == 0 || salaryInput.length == null) {
      showSalary.value = 0.0;
    } else {
      showSalary.value = 1.0;
    }
    update();
  }

  String checkValidEmail() {
    if (!RegExp(r'^[a-z0-9.]*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?').hasMatch(email) && email.isNotEmpty) {
      return 'Email b???n nh???p kh??ng h???p l???';
    } else if (email == "" && checkRegister.value) {
      return 'B???n ch??a nh???p Email';
    } else if (checkEmailExist.value) {
      return errorEmail;
    }
    return null;
  }

  String checkValidPassword() {
    if (!RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(password) && password.isNotEmpty) {
      return 'M???t kh???u sai ?????nh d???ng';
    } else if (password == "" && checkRegister.value) {
      return 'B???n ch??a nh???p m???t kh???u';
    } else if (RegExp(r'[.,!@#\$&*~^%()+x=/_????????????]').hasMatch(password) && password.isNotEmpty) {
      return 'M???t kh???u kh??ng ???????c c?? k?? t??? ?????c bi???t';
    }
    return null;
  }

  String checkValidConfirmPassword() {
    if (confirmPasswordTextEditingController.text != passwordTextEditingController.text && confirmPasswordTextEditingController.text.isNotEmpty) {
      return 'M???t kh???u n??y kh??ng ????ng v???i m???t kh???u ???? nh???p';
    } else if (confirmPassword == "" && checkRegister.value) {
      return 'B???n ch??a nh???p m???t kh???u nh???p l???i';
    } else if (RegExp(r'[.,!@#\$&*~^%()+x=/_????????????]').hasMatch(confirmPassword) && confirmPassword.isNotEmpty) {
      return 'M???t kh???u kh??ng ???????c c?? k?? t??? ?????c bi???t';
    }
    return null;
  }

  String checkValidName() {
    if (name == "" && checkRegister.value) {
      return 'B???n ch??a nh???p t??n';
    }
    return null;
  }

  String checkValidPhone() {
    if (phone == "" && checkRegister.value) {
      return 'B???n ch??a nh???p s??? ??i???n tho???i';
    } else if (!RegExp(r'^((0[0-9])|(84[0-9]))\d{8,10}$').hasMatch(phone) && phone.isNotEmpty) {
      return 'B???n nh???p sai ?????nh d???ng s??? ??i???n tho???i';
    } else if (checkPhoneExist.value) {
      return errorPhone;
    }
    return null;
  }

  String checkValidJob() {
    if (job == "" && checkRegister.value) {
      return 'B???n ch??a nh???p ngh??? nghi???p';
    }
    return null;
  }

  RxBool upTimed = false.obs;
  void upTime(){
    if (salaryInput == "") {
      upTimed.value = true;
    } else {
      upTimed.value = false;
    }
    update();
  }

  String checkValidSalary() {
    if (salaryInput == "" && checkRegister.value) {
      return 'B???n ch??a nh???p l????ng';
    }
    return null;
  }

  String checkValidSalaryEnd() {
    if (salarySecInput == "" && checkRegister.value) {
      return 'B???n ch??a nh???p l????ng';
    }
    return null;
  }

  String checkValidSex() {
    if (optionItemSelected.id == null && checkRegister.value) {
      return 'B???n ch??a ch???n gi???i t??nh';
    }
    return null;
  }

  String checkValidBirth() {
    if (birthRegister.value.isEmpty && checkRegister.value) {
      return 'B???n ch??a ch???n ng??y sinh';
    }
    return null;
  }

  String checkValidCity() {
    if (nameCity.value.isEmpty && checkRegister.value) {
      return 'B???n ch??a ch???n t???nh/th??nh ph???';
    }
    return null;
  }

  String checkValidDistrict() {
    if (nameDistrict.value.isEmpty && checkRegister.value) {
      return 'B???n ch??a ch???n qu???n/huy???n';
    }
    return null;
  }

  String checkValidOTP() {
    if (otp == "" && checkOTP.value) {
      return 'B???n ch??a nh???p m?? OTP';
    }
    return null;
  }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context, initialDate: valueDate, firstDate: DateTime(1930, 8), lastDate: DateTime(2101));
    if (picked != null && picked != valueDate) valueDate = picked;
    birthRegister.value =
        valueDate.day.toString().padLeft(2, '0') + '-' + valueDate.month.toString().padLeft(2, '0') + '-' + valueDate.year.toString();
    checkBirth.value = true;
    print(birthRegister.value);
    update();
  }

  void apiSalary() {
    indexSalaryType.value == 2 ? salaryAPI.value = salaryInput + ',' + salarySecInput : salaryAPI.value = salaryInput;
    update();
  }

  void checkFocusNode() {
    if (emailTextEditingController.text.isNotEmpty && checkFocus.value == false) {
      checkEmail();
      checkFocus.value = true;
    } else if (emailTextEditingController.text.isNotEmpty && checkFocus.value == true) {
      checkFocus.value = false;
      checkEmailExist.value = false;
    }
    update();
  }

  void checkFocusNodePhone() {
    if (phoneTextEditingController.text.isNotEmpty && checkFocusPhone.value == false) {
      checkPhone();
      checkFocusPhone.value = true;
    } else if (phoneTextEditingController.text.isNotEmpty && checkFocusPhone.value == true) {
      checkFocusPhone.value = false;
      checkPhoneExist.value = false;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    whoYouAre = SpUtil.getBool(ConstString.WHO_YOU_ARE);
    emailTextEditingController.addListener(() {});
    passwordTextEditingController.addListener(() {});
    confirmPasswordTextEditingController.addListener(() {});
    nameTextEditingController.addListener(() {});
    otpTextEditingController.addListener(() {});
    searchCityTextEditingController.addListener(() {});
    searchCityFilterTextEditingController.addListener(() {});
    searchCategoryTextEditingController.addListener(() {});
    searchCategoryFilterTextEditingController.addListener(() {});
    salaryTextEditingController.addListener(() {
      checkSalaryValue();
    });
    jobTextEditingController.addListener(() {});
    focusNode.addListener(() {
      checkFocusNode();
    });
    focusNodePhone.addListener(() {
      checkFocusNodePhone();
    });

    getListCity();
    getListCategory();
    getSearchListCity();
    getSearchListCityFilter();
    getSearchListWorkPlace();
    getSearchListCategory();
    checkBirthday();
    checkSalaryCon();
    showCity();
    showDistrict();
    showCategory();
  }

  void getListCity() async {
    ResultData res = await _authenticationRepositories.getListCity();
    if (res.result) {
      ResultGetCity resultGetCity = resultGetCityFromJson(res.data);

      for (int i = 0; i < resultGetCity.data.listCity.length; i++) {
        listCity.add(resultGetCity.data.listCity[i]);
      }
    } else {
      if (res.code == 404) {
        print('L???i 404');
      } else if (res.code == 401) {
        print('L???i 401');
      } else if (res.code == 500) {
        print('L???i 500');
      } else if (res.code == 505) {
        print('L???i 505');
      } else {
        print('L???i');
      }
    }
    update();
  }

  Future<void> getSearchListCity() async {
    if (searchCity == '' || searchCity.isEmpty) {
      listSearchCity = listCity;
    } else {
      listSearchCity = [];
      update();
      for (int i = 0; i < listCity.length; i++) {
        if (listCity.elementAt(i).name.toString().toLowerCase().contains(searchCity.toLowerCase())) {
          listSearchCity.add(listCity[i]);
        }
      }
    }
    update();
  }

  Future<void> getSearchListCityFilter() async {
    if (searchCityFilter == '' || searchCityFilter.isEmpty) {
      listSearchCity = listCity;
    } else {
      listSearchCity = [];
      update();
      for (int i = 0; i < listCity.length; i++) {
        if (listCity.elementAt(i).name.toString().toLowerCase().contains(searchCityFilter.toLowerCase())) {
          listSearchCity.add(listCity[i]);
        }
      }
    }
    update();
  }

  Future<void> getSearchListWorkPlace() async {
    if (searchWorkPlace == '' || searchWorkPlace.isEmpty) {
      listSearchWorkPlace = listCity;
    } else {
      listSearchWorkPlace = [];
      update();
      for (int i = 0; i < listCity.length; i++) {
        if (listCity.elementAt(i).name.toString().toLowerCase().contains(searchWorkPlace.toLowerCase())) {
          listSearchWorkPlace.add(listCity[i]);
        }
      }
    }
    update();
  }

  void getListDistrict() async {
    int city = indexCity.value;
    ResultData res = await _authenticationRepositories.getListDistrict(city);
    if (res.result) {
      ResultGetDistrict resultGetDistrict = resultGetDistrictFromJson(res.data);

      for (int i = 0; i < resultGetDistrict.data.listDistrict.length; i++) {
        listDistrict.add(resultGetDistrict.data.listDistrict[i]);
      }
    } else {
      if (res.code == 404) {
        print('L???i 404');
      } else if (res.code == 401) {
        print('L???i 401');
      } else if (res.code == 500) {
        print('L???i 500');
      } else if (res.code == 505) {
        print('L???i 505');
      } else {
        print('L???i');
      }
    }
    update();
  }

  void getListCategory() async {
    ResultData res = await _authenticationRepositories.getListCategory();
    if (res.result) {
      resultGetCategory = resultGetCategoryFromJson(res.data);

      for (int i = 0; i < resultGetCategory.data.listCategory.length; i++) {
        listCategory.add(resultGetCategory.data.listCategory[i]);
        listCheckCategory.add(false);
      }
    } else {}
    update();
  }

  Future<void> getSearchListCategory() async {
    if (searchCategory == '' || searchCategory == null) {
      listSearchCategory = listCategory;
    } else {
      listSearchCategory = [];
      update();
      for (int i = 0; i < listCategory.length; i++) {
        if (listCategory.elementAt(i).tenLinhVuc.toString().toLowerCase().contains(searchCategory.toLowerCase())) {
          listSearchCategory.add(listCategory[i]);
        }
      }
    }
    update();
  }

  Future<void> getSearchListCategoryFilter() async {
    if (searchCategoryFilter == '' || searchCategoryFilter == null) {
      listSearchCategory = listCategory;
    } else {
      listSearchCategory = [];
      update();
      for (int i = 0; i < listCategory.length; i++) {
        if (listCategory.elementAt(i).tenLinhVuc.toString().toLowerCase().contains(searchCategoryFilter.toLowerCase())) {
          listSearchCategory.add(listCategory[i]);
        }
      }
    }
    update();
  }

  void checkButtonRegisterCompany() {
    if (RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(password) &&
        RegExp(r'(^(?:[0])?[0-9]{10}$)').hasMatch(phone) &&
        RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(confirmPassword) &&
        optionItemSelected.id != null &&
        birthRegister.value.isNotEmpty &&
        nameCity.value.isNotEmpty &&
        nameDistrict.value.isNotEmpty &&
        !RegExp(r'[.,!@#\$&*~^%()+x=/_???????????? ]').hasMatch(password)) {
      buttonRegister.value = true;
      update();
    } else {
      buttonRegister.value = false;
      update();
    }
    update();
  }

  void registerCompany() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    int gender = genderRegister.value;
    String birth = birthRegister.value;
    String city = indexCity.value.toString();
    int district = indexDistrict.value;
    if (RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(password) && !RegExp(r'[.,!@#\$&*~^%()+x=/_???????????? ]').hasMatch(password)) {
      if (buttonRegister.value) {
        ResultData res = await _authenticationRepositories.registerCompany(imageAvatar, name, gender, birth, city, district, phone, email, password);
        ResultRegisterCompany resultRegisterCompany = resultRegisterCompanyFromJson(res.data);
        if (resultRegisterCompany.data.result) {
          SpUtil.putString(ConstString.token_register, resultRegisterCompany.data.accessToken);
          SpUtil.putInt(ConstInt.id_register.toString(), resultRegisterCompany.data.id);
          whoYouAre ? waitLoginController.checkWhoUR.value = true : waitLoginController.checkWhoUR.value = false;
          waitLoginController.checkWhoYouAre();
          Get.back();
          Get.to(OTPScreen());
          Utils.showToast(resultRegisterCompany.data.message);
        } else {
          Get.back();
          Utils.showToast(resultRegisterCompany.error.message);
          checkRegister.value = true;
          checkRes();
        }
      } else {
        checkRegister.value = true;
        checkRes();
        Get.back();
        Utils.showToast('B???n nh???p sai ho???c thi???u th??ng tin vui l??ng ki???m tra l???i');
      }
    } else {
      checkRegister.value = true;
      checkRes();
      Get.back();
      Utils.showToast('M???t kh???u ph???i t??? 8 k?? t??? tr??? l??n c?? ??t nh???t 1 ch??? v?? 1 s???, kh??ng ???????c c?? d???u c??ch');
    }
    update();
  }

  void confirmOTPNTD() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    String token = SpUtil.getString(ConstString.token_register);
    ResultData res = await _authenticationRepositories.confirmOTPNTD(otp, token);
    ResultConfirmOtpntd resultConfirmOtpntd = resultConfirmOtpntdFromJson(res.data);
    if (resultConfirmOtpntd.data.result) {
      checkOTP.value = false;
      Get.back();
      Get.to(SuccessRegisterScreen());
    } else {
      checkOTP.value = true;
      otpTextEditingController.clear();
      Get.back();
      Utils.showToast(resultConfirmOtpntd.error.message);
    }
    update();
  }

  void resendOTPNTD() async {
    String token = SpUtil.getString(ConstString.token_register);
    ResultData res = await _authenticationRepositories.resendOTPNTD(token);
    if (res.result) {
      Utils.showToast('Email ch???a m?? x??c th???c ???? ???????c g???i t???i h???p th?? c???a b???n. H??y ki???m tra.');
    } else {
      if (res.code == 404) {
        print('L???i 404');
      } else if (res.code == 401) {
        print('L???i 401');
      } else if (res.code == 500) {
        print('L???i 500');
      } else if (res.code == 505) {
        print('L???i 505');
      } else {
        print('L???i');
      }
    }
    update();
  }

  void checkButtonRegisterCandidate() {
    if (RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(password) &&
        RegExp(r'(^(?:[0])?[0-9]{10}$)').hasMatch(phone) &&
        RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(confirmPassword) &&
        optionItemSelected.id != null &&
        birthRegister.value.isNotEmpty &&
        nameCity.value.isNotEmpty &&
        nameDistrict.value.isNotEmpty &&
        jobTextEditingController.text.isNotEmpty &&
        salaryInput.isNotEmpty &&
        !RegExp(r'[.,!@#\$&*~^%()+x=/_???????????? ]').hasMatch(password)) {
      buttonRegister.value = true;
      update();
    } else {
      buttonRegister.value = false;
      update();
    }
    update();
  }

  void registerCandidate() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    int gender = genderRegister.value;
    String birth = birthRegister.value;
    String city = indexCity.value.toString();
    int district = indexDistrict.value;
    String category = listHaveCategory.join(",");
    String salary = salaryAPI.value;
    String salaryType = indexSalaryType.value.toString();
    int salaryDepend = salaryDependRegister.value;
    if (RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(password) && !RegExp(r'[.,!@#\$&*~^%()+x=/_???????????? ]').hasMatch(password)) {
      if (buttonRegister.value) {
        ResultData res = await _authenticationRepositories.registerCandidate(
            imageAvatar, name, gender, birth, city, district, phone, email, password, salaryType, salary, salaryDepend, job, category);
        ResultRegisterCandidate resultRegisterCandidate = resultRegisterCandidateFromJson(res.data);
        if (resultRegisterCandidate.data.result) {
          SpUtil.putString(ConstString.token_register, resultRegisterCandidate.data.accessToken);
          SpUtil.putInt(ConstInt.id_register.toString(), resultRegisterCandidate.data.id);
          whoYouAre ? waitLoginController.checkWhoUR.value = true : waitLoginController.checkWhoUR.value = false;
          waitLoginController.checkWhoYouAre();
          Get.back();
          Get.to(OTPScreen());
          Utils.showToast(resultRegisterCandidate.data.message);
        } else {
          Get.back();
          Utils.showToast(resultRegisterCandidate.error.message);
          checkRegister.value = true;
          checkRes();
        }
      } else {
        checkRegister.value = true;
        checkRes();
        Get.back();
        Utils.showToast('B???n nh???p sai ho???c thi???u th??ng tin vui l??ng ki???m tra l???i');
      }
    } else {
      checkRegister.value = true;
      checkRes();
      Get.back();
      Utils.showToast('M???t kh???u ph???i t??? 8 k?? t??? tr??? l??n c?? ??t nh???t 1 ch??? v?? 1 s???, kh??ng ???????c c?? d???u c??ch');
    }
    update();
  }

  void confirmOTPUV() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    String token = SpUtil.getString(ConstString.token_register);
    ResultData res = await _authenticationRepositories.confirmOTPUV(otp, token);
    ResultConfirmOtpuv resultConfirmOtpuv = resultConfirmOtpuvFromJson(res.data);
    if (resultConfirmOtpuv.data.result) {
      checkOTP.value = false;
      Get.back();
      Get.to(SuccessRegisterScreen());
    } else {
      checkOTP.value = true;
      otpTextEditingController.clear();
      Get.back();
      Utils.showToast(resultConfirmOtpuv.error.message);
    }
    update();
  }

  void resendOTPUV() async {
    String token = SpUtil.getString(ConstString.token_register);
    ResultData res = await _authenticationRepositories.resendOTPUV(token);
    if (res.result) {
      Utils.showToast('Email ch???a m?? x??c th???c ???? ???????c g???i t???i h???p th?? c???a b???n. H??y ki???m tra.');
    } else {
      if (res.code == 404) {
        print('L???i 404');
      } else if (res.code == 401) {
        print('L???i 401');
      } else if (res.code == 500) {
        print('L???i 500');
      } else if (res.code == 505) {
        print('L???i 505');
      } else {
        print('L???i');
      }
    }
    update();
  }

  void checkEmail() async {
    int typeOfUser = waitLoginController.typeUser.value;
    ResultData res = await _authenticationRepositories.checkEmail(email, typeOfUser);
    ResultNotification resultNotification = resultNotificationFromJson(res.data);
    if (resultNotification.data.result) {
      checkEmailExist.value = false;
      checkEmailExisted();
    } else {
      SpUtil.putString(ConstString.Error_register_email, resultNotification.error.message);
      errorEmail = SpUtil.getString(ConstString.Error_register_email);
      checkEmailExist.value = true;
      checkEmailExisted();
    }
    update();
  }

  void checkPhone() async {
    int typeOfUser = waitLoginController.typeUser.value;
    ResultData res = await _authenticationRepositories.checkPhoneNumber(phone, typeOfUser);
    ResultNotification resultNotification = resultNotificationFromJson(res.data);
    if (resultNotification.data.result) {
      checkPhoneExist.value = false;
      checkPhoneExisted();
    } else {
      SpUtil.putString(ConstString.Error_register_phone, resultNotification.error.message);
      errorPhone = SpUtil.getString(ConstString.Error_register_phone);
      checkPhoneExist.value = true;
      checkPhoneExisted();
    }
    update();
  }
}
