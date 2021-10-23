import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_category.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_city.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/shared/data/repositories/authen_repositories.dart';
import 'package:freelancer_app/common/shared/data/repositories/home_repositories.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/dialog_login_post_job.dart';
import 'package:freelancer_app/widgets/dialog_post_job_success.dart';
import 'package:freelancer_app/widgets/drop_list_model_month.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';

class MenuController extends GetxController {
  HomeRepositories _homeRepositories = HomeRepositories();
  AuthenticationRepositories _authenticationRepositories = AuthenticationRepositories();

  NavigationController navigationController = Get.put(NavigationController());

  RxInt whatJobUPost = 0.obs;

  RxInt indexMenuNTD = 0.obs;
  RxInt indexMenuFlc = 0.obs;
  RxBool showJobFreelance = false.obs;
  RxInt indexFreelancer = 0.obs;
  RxInt indexSalaryType = 0.obs;
  RxInt salaryDependRegister = 0.obs;
  RxInt expNeed = 0.obs;
  RxInt classification = 0.obs;
  RxBool chooseWorkPlace = false.obs;
  RxString nameWorkPlace = ''.obs;
  RxInt indexWorkPlace = 0.obs;
  RxBool chooseCareer = false.obs;
  RxString nameCareer = ''.obs;
  RxInt indexCareer = 0.obs;
  RxBool chooseSkills = false.obs;
  RxString nameSkills = ''.obs;
  RxInt indexSkills = 0.obs;
  Rx currentIndex = 0.obs;

  List<ListCity> listCity = [];
  List<ListCategory> listCategory = [];
  List<bool> listCheckCategory = [];
  ResultGetCategory resultGetCategory = ResultGetCategory();

  bool isEstimatesOrPermanent = true;
  final _format = DateFormat("dd/MM/yyyy");
  DateTime valueDateStartDG = DateTime.now();
  DateTime valueDateEndDG = DateTime.now();
  DateTime valueDateStartWorking = DateTime.now();
  DateTime valueDateEndWorking = DateTime.now();
  RxBool checkValueDateStart = false.obs;
  RxBool checkValueDateEnd = false.obs;
  RxBool checkValueDateStartWork = false.obs;
  RxBool checkValueDateEndWork = false.obs;
  RxString valueDateStart = ''.obs;
  RxString valueDateEnd = ''.obs;
  RxString valueDateStartWork = ''.obs;
  RxString valueDateEndWork = ''.obs;

  RxString salaryAPI = ''.obs;
  RxInt indexPostJob = 0.obs;

  PlatformFile platformFile;
  File fileUpload;
  File logo;

  DropListModelMonth dropListModelMonth = DropListModelMonth([
    OptionItemMonth(id: "1", title: "Ngày"),
    OptionItemMonth(id: "2", title: "Tuần"),
    OptionItemMonth(id: "3", title: "Tháng"),
    OptionItemMonth(id: "4", title: "Năm"),
  ]);
  OptionItemMonth optionItemSelectedMonth = OptionItemMonth(id: null, title: "Thời gian");

  DropListModel listWorkingFormModel = DropListModel(listItem: [
    OptionItem(id: 1, title: "Toàn thời gian cố định"),
    OptionItem(id: 2, title: "Toàn thời gian tạm thời"),
    OptionItem(id: 3, title: "Bán thời gian"),
    OptionItem(id: 4, title: "Bán thời gian tạm thời"),
    OptionItem(id: 5, title: "Hợp đồng"),
    OptionItem(id: 6, title: "Khác"),
  ]);
  OptionItem optionItemWorkingFormSelected = OptionItem(id: null, title: "Chọn hình thức");

  DropListModel listExpModel = DropListModel(listItem: [
    OptionItem(id: 0, title: "Chưa có kinh nghiệm"),
    OptionItem(id: 1, title: "0 - 1 năm kinh nghiệm"),
    OptionItem(id: 2, title: "1 - 2 năm kinh nghiệm"),
    OptionItem(id: 3, title: "2 - 5 năm kinh nghiệm"),
    OptionItem(id: 4, title: "5 - 10 năm kinh nghiệm"),
    OptionItem(id: 5, title: "Hơn 10 năm kinh nghiệm"),
  ]);

  OptionItem optionItemExpSelected = OptionItem(id: null, title: "Chọn kinh nghiệm");

  void showWhatJobUPost() {
    whatJobUPost.value;
    update();
  }

  void showPostJob() {
    indexPostJob.value;
    update();
  }

  void showCareer() {
    chooseCareer.value;
    update();
  }

  void showSkills() {
    chooseSkills.value;
    update();
  }

  void showWorkPlace() {
    chooseWorkPlace.value;
    update();
  }

  void changeExp() {
    expNeed.value = optionItemExpSelected.id;
    update();
  }

  void changeClassification() {
    classification.value = optionItemWorkingFormSelected.id;
    update();
  }

  void changeSalaryTime() {
    salaryDependRegister.value = int.parse(optionItemSelectedMonth.id);
    update();
  }

  void checkSalaryCon() {
    indexSalaryType.value;
    update();
  }

  TextEditingController nameJobsRecruitmentTextEditingController = TextEditingController();

  String get nameCV => nameJobsRecruitmentTextEditingController.text;

  TextEditingController requestTextEditingController = TextEditingController();

  String get request => requestTextEditingController.text;

  TextEditingController salaryTextEditingController = TextEditingController();

  String get salary => salaryTextEditingController.text;

  TextEditingController salaryEndTextEditingController = TextEditingController();

  String get salaryEnd => salaryEndTextEditingController.text;

  TextEditingController skillTextEditingController = TextEditingController();

  String get skill => skillTextEditingController.text;

  TextEditingController deadLineTextEditingController = TextEditingController();

  String get deadLine => deadLineTextEditingController.text;

  RxBool checkRequired = false.obs;

  String checkValidNameCV() {
    if (nameCV == "" && checkRequired.value) {
      return 'Bạn chưa nhập tên vị trí cần tuyển';
    } else if (RegExp(r'[.,!@#\$&*~^%()+x=/_€£¥₩÷]').hasMatch(nameCV) && nameCV.isNotEmpty) {
      return 'Tên vị trí cần tuyển không được có ký tự đặc biệt';
    }
    return null;
  }

  String checkValidCareer() {
    if (nameCareer.value == "" && checkRequired.value) {
      return 'Bạn chưa chọn lĩnh vực cần tuyển';
    }
    return null;
  }

  String checkValidExp() {
    if (optionItemExpSelected.id == null && checkRequired.value) {
      return 'Bạn chưa chọn kinh nghiệm yêu cầu';
    }
    return null;
  }

  String checkValidForm() {
    if (optionItemWorkingFormSelected.id == null && checkRequired.value) {
      return 'Bạn chưa chọn hình thức làm việc';
    }
    return null;
  }

  String checkValidWorkPlace() {
    if (nameWorkPlace.value == '' && checkRequired.value) {
      return 'Bạn chưa chọn nơi làm việc';
    }
    return null;
  }

  String checkValidRequest() {
    if (request == "" && checkRequired.value) {
      return 'Bạn chưa nhập thông tin chi tiết';
    }
    return null;
  }

  String checkValidSkill() {
    if (nameSkills.value == '' && checkRequired.value) {
      return 'Bạn chưa chọn kỹ năng làm việc';
    }
    return null;
  }

  RxBool upTimed = false.obs;
  void upTime(){
    if (salary == "" || RegExp(r'^[.]|[-]+$').hasMatch(salary)) {
      upTimed.value = true;
    } else {
      upTimed.value = false;
    }
    update();
  }

  String checkValidSalary() {
    if (salary == "" && checkRequired.value) {
      return 'Bạn chưa nhập lương';
    } else if (RegExp(r'^[.]|[-]+$').hasMatch(salary)) {
      return 'Bạn nhập sai định dạng lương';
    }
    return null;
  }

  String checkValidSalaryEnd() {
    if (salaryEnd == "" && checkRequired.value) {
      return 'Bạn chưa nhập lương';
    } else if (RegExp(r'^[.]|[-]+$').hasMatch(salaryEnd)) {
      return 'Bạn nhập sai định dạng lương';
    }
    return null;
  }

  String checkValidDateStartDeal() {
    if (valueDateStart.value == "" && checkRequired.value) {
      return 'Bạn chưa chọn ngày bắt đầu đặt giá';
    }
    return null;
  }

  String checkValidDateEndDeal() {
    if (valueDateEnd.value == "" && checkRequired.value) {
      return 'Bạn chưa chọn ngày kết thúc đặt giá';
    }
    return null;
  }

  String checkValidDateStartWork() {
    if (valueDateStartWork.value == "" && checkRequired.value) {
      return 'Bạn chưa chọn ngày bắt đầu làm việc';
    }
    return null;
  }

  String checkValidDateEndWork() {
    if (valueDateEndWork.value == "" && checkRequired.value) {
      return 'Bạn chưa chọn ngày kết thúc làm việc';
    }
    return null;
  }

  String checkValidDeadline() {
    if (deadLine == "" && checkRequired.value) {
      return 'Bạn chưa nhập thời hạn làm việc';
    } else if (RegExp(r'[.,!@#\$&*~^%()+x=/_€£¥₩÷ ]').hasMatch(deadLine)) {
      return 'Thời hạn làm việc không được có ký tự đặc biệt';
    }
    return null;
  }

  void checkRequiredPostJob() {
    if (nameCV == "" ||
        nameCareer.value == "" ||
        optionItemExpSelected.id == null ||
        optionItemWorkingFormSelected.id == null ||
        nameWorkPlace.value == '' ||
        request == "" ||
        salary == "" ||
        // salaryEnd == "" ||
        valueDateStart.value == "" &&
        valueDateEnd.value == "" ||
        valueDateStartWork.value == "" ||
        valueDateEndWork.value == "" ||
        RegExp(r'[.,!@#\$&*~^%()+x=/_€£¥₩÷]').hasMatch(nameCV) ||
        RegExp(r'[.,!@#\$&*~^%()+x=/_€£¥₩÷ ]').hasMatch(deadLine) ||
        RegExp(r'^[.]|[-]+$').hasMatch(salaryEnd) ||
        RegExp(r'^[.]|[-]+$').hasMatch(salary)) {
      upTime();
      Utils.showToast('Bạn chưa nhập hoặc nhập sai thông tin vui lòng kiểm tra lại');
      checkRequired.value = true;
    } else if (nameCV.isNotEmpty &&
        nameCareer.value.isNotEmpty &&
        optionItemExpSelected.id.toString().isNotEmpty &&
        optionItemWorkingFormSelected.id.toString().isNotEmpty &&
        nameWorkPlace.value.isNotEmpty &&
        request.isNotEmpty &&
        salary.isNotEmpty ||
        salaryEnd.isNotEmpty &&
        valueDateStart.value.isNotEmpty &&
        valueDateEnd.value.isNotEmpty &&
        valueDateStartWork.value.isNotEmpty &&
        valueDateEndWork.value.isNotEmpty &&
        !RegExp(r'[.,!@#\$&*~^%()+x=/_€£¥₩÷]').hasMatch(nameCV) &&
        !RegExp(r'[.,!@#\$&*~^%()+x=/_€£¥₩÷ ]').hasMatch(deadLine) &&
        !RegExp(r'^[.]|[-]+$').hasMatch(salaryEnd) &&
        !RegExp(r'^[.]|[-]+$').hasMatch(salary)) {
      checkRequired.value = false;
      apiSalary();
      postJob();
    }
    update();
  }

  void clearList() {
    optionItemSelectedMonth.id = null;
    optionItemWorkingFormSelected.id = null;
    optionItemExpSelected.id = null;
    // optionItemSelectedMonth.title = 'Thời gian';
    // optionItemWorkingFormSelected.title = 'Chọn hình thức';
    // optionItemExpSelected.title = 'Chọn kinh nghiệm';
    nameCareer.value = '';
    nameWorkPlace.value = '';
    nameSkills.value = '';
    chooseCareer.value = false;
    chooseWorkPlace.value = false;
    chooseSkills.value = false;
    listCategory.clear();
    listCity.clear();
    navigationController.listTag.clear();
    indexSalaryType.value = 0;
    checkValueDateStart.value = false;
    checkValueDateEnd.value = false;
    checkValueDateStartWork.value = false;
    checkValueDateEndWork.value = false;
    valueDateStart.value = '';
    valueDateEnd.value = '';
    valueDateStartWork.value = '';
    valueDateEndWork.value = '';
    nameJobsRecruitmentTextEditingController.clear();
    requestTextEditingController.clear();
    salaryTextEditingController.clear();
    salaryEndTextEditingController.clear();
    logo = null;
    fileUpload = null;
    checkRequired.value = false;
    update();
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
        print('Lỗi 404');
      } else if (res.code == 401) {
        print('Lỗi 401');
      } else if (res.code == 500) {
        print('Lỗi 500');
      } else if (res.code == 505) {
        print('Lỗi 505');
      } else {
        print('Lỗi');
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

  void onChangePermanentOrEstimate() {
    this.isEstimatesOrPermanent = !this.isEstimatesOrPermanent;
    update();
  }

  Future getImageLogo() async {
    final img = await ImagePicker().getImage(source: ImageSource.gallery);
    logo = File(img.path);
    update();
  }

  Future upLoadFile() async {
    final file = await FilePicker.platform.pickFiles();
    if (file != null) {
      platformFile = file.files.first;
      fileUpload = File(platformFile.path);
    }
    update();
  }

  void checkIndexFreelancer() {
    indexFreelancer.value;
    update();
  }

  void showJobFreelancer() {
    showJobFreelance.value = !showJobFreelance.value;
    print(showJobFreelance.value);
    update();
  }

  void checkIndexMenuNTD() {
    indexMenuNTD.value;
    update();
  }

  void checkIndexMenuFlc() {
    indexMenuFlc.value;
    update();
  }

  void apiSalary() {
    indexSalaryType.value == 2 ? salaryAPI.value = salary + ',' + salaryEnd : salaryAPI.value = salary;
    update();
  }

  Future selectDateStartDG(context) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: valueDateStartDG,
      firstDate: DateTime(valueDateStartDG.year - 10),
      lastDate: DateTime(valueDateStartDG.year + 10),
    );
    if (date != null && date != valueDateStartDG) {
      valueDateStartDG = date;
      valueDateStart.value = valueDateStartDG.day.toString().padLeft(2, '0') +
          '-' +
          valueDateStartDG.month.toString().padLeft(2, '0') +
          '-' +
          valueDateStartDG.year.toString();
      checkValueDateStart.value = true;
    }
    update();
  }

  Future selectDateEndDG(context) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: valueDateEndDG,
      firstDate: DateTime(valueDateEndDG.year - 10),
      lastDate: DateTime(valueDateEndDG.year + 10),
    );
    if (date != null && date != valueDateEndDG) {
      valueDateEndDG = date;
      valueDateEnd.value = valueDateEndDG.day.toString().padLeft(2, '0') +
          '-' +
          valueDateEndDG.month.toString().padLeft(2, '0') +
          '-' +
          valueDateEndDG.year.toString();
      checkValueDateEnd.value = true;
    }
    update();
  }

  Future selectDateStartWorking(context) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: valueDateStartWorking,
      firstDate: DateTime(valueDateStartWorking.year - 10),
      lastDate: DateTime(valueDateStartWorking.year + 10),
    );
    if (date != null && date != valueDateStartWorking) {
      valueDateStartWorking = date;
      valueDateStartWork.value = valueDateStartWorking.day.toString().padLeft(2, '0') +
          '-' +
          valueDateStartWorking.month.toString().padLeft(2, '0') +
          '-' +
          valueDateStartWorking.year.toString();
      checkValueDateStartWork.value = true;
    }
    update();
  }

  Future selectDateEndWorking(context) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: valueDateEndWorking,
      firstDate: DateTime(valueDateEndWorking.year - 10),
      lastDate: DateTime(valueDateEndWorking.year + 10),
    );
    if (date != null && date != valueDateEndWorking) {
      valueDateEndWorking = date;
      valueDateEndWork.value = valueDateEndWorking.day.toString().padLeft(2, '0') +
          '-' +
          valueDateEndWorking.month.toString().padLeft(2, '0') +
          '-' +
          valueDateEndWorking.year.toString();
      checkValueDateEndWork.value = true;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    nameJobsRecruitmentTextEditingController.addListener(() {});
    requestTextEditingController.addListener(() {});
    salaryTextEditingController.addListener(() {});
    skillTextEditingController.addListener(() {});
    deadLineTextEditingController.addListener(() {});
    checkIndexMenuNTD();
    checkIndexMenuFlc();
    checkSalaryCon();
    showCareer();
    showSkills();
    showWorkPlace();
    showWhatJobUPost();
    showPostJob();
  }

  void postJob() async {
    String token = SpUtil.getString(ConstString.token);
    int linhVuc = indexCareer.value;
    int hinhThuc = classification.value;
    int kinhNghiem = expNeed.value;
    int noiLamViec = indexWorkPlace.value;
    String noiDungViec = requestTextEditingController.text;
    File file = fileUpload;
    int theLoaiChiPhi = indexSalaryType.value;
    int chiPhiTheoGiDo = salaryDependRegister.value;
    String chiPhi = salaryAPI.value;
    String ngayBDDatGia = valueDateStart.value;
    String ngayKTDatGia = valueDateEnd.value;
    String ngayBDLamViec = valueDateStartWork.value;
    String ngayKTLamViec = valueDateEndWork.value;
    int maKyNang = indexSkills.value;
    int loaiViecLam = whatJobUPost.value;
    ResultData res = await _homeRepositories.postJob(token, logo, nameCV, linhVuc, maKyNang, hinhThuc, noiLamViec, kinhNghiem, noiDungViec, file,
        theLoaiChiPhi, chiPhiTheoGiDo, chiPhi, ngayBDDatGia, ngayKTDatGia, ngayBDLamViec, ngayKTLamViec, loaiViecLam);
    ResultNotification resultNotification = resultNotificationFromJson(res.data);
    if (resultNotification.data.result) {
      Get.dialog(DialogPostJobSuccess());
      Utils.showToast(resultNotification.data.message);
    } else {
      Utils.showToast(resultNotification.error.message);
    }
    update();
  }
}
