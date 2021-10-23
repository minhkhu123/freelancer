import 'package:flutter/material.dart';
import 'package:freelancer_app/common/shared/data/models/result_list_freelancer.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_skill.dart';
import 'package:freelancer_app/screens/authens/employer_homepage_isnot_loggedin/employer_homepage_isnot_loggedin_screen.dart';
import 'package:freelancer_app/screens/authens/employer_profile/employer_profile_screen.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/candidate/candidate_profile/candidate_profile_screen.dart';
import 'package:freelancer_app/screens/candidate/personal_page_cadidate_not_logged_in/personal_page_candidate_logged_in_screen.dart';
import 'package:freelancer_app/screens/chat/chat_not_use.dart';
import 'package:freelancer_app/screens/home/home_screen.dart';
import 'package:freelancer_app/screens/menu/menu_screen.dart';
import 'package:freelancer_app/screens/notification/notification_screen.dart';
import 'package:freelancer_app/widgets/dialog_login_save_freelancer.dart';
import 'package:freelancer_app/widgets/drop_list_model_freelancer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_detail_freelancer.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_tag_from_category.dart';
import 'package:freelancer_app/common/shared/data/models/result_job_detail.dart';
import 'package:freelancer_app/common/shared/data/models/result_job_posted.dart';
import 'package:freelancer_app/common/shared/data/models/result_list_freelancer_latest_home.dart';
import 'package:freelancer_app/common/shared/data/models/result_list_freelancer_outstanding_home.dart';
import 'package:freelancer_app/common/shared/data/models/result_list_job.dart';
import 'package:freelancer_app/common/shared/data/models/result_list_job_partime_home.dart';
import 'package:freelancer_app/common/shared/data/models/result_list_job_project_home.dart';
import 'package:freelancer_app/common/shared/data/models/result_loadmore_freelancer_deal.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/shared/data/repositories/authen_repositories.dart';
import 'package:freelancer_app/common/shared/data/repositories/home_repositories.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/screens/home/watch_detail_freelancer_screen.dart';
import 'package:freelancer_app/screens/home/watch_detail_screen.dart';
import 'package:freelancer_app/screens/menu/detail_job_posted.dart';
import 'package:freelancer_app/screens/menu/job_posted_screen.dart';
import 'package:freelancer_app/widgets/dialog_loading.dart';
import 'package:freelancer_app/widgets/drop_list_model_form.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  WaitLoginController _waitLoginController = Get.put(WaitLoginController());
  TabController tabController;
  RxInt pageIndex = 0.obs;
  Rx<Widget> currentPage = Rx<Widget>(HomeScreen());
  RxBool checkWhoUR = false.obs;
  RxBool checkLogin = false.obs;
  bool whoYouAre = false;
  bool loginIn = false;
  bool wur = true;
  RxInt ind = 0.obs;
  String checkTopFlc;
  RxBool topFlc = false.obs;
  RxBool isBackApp = false.obs;

  RxBool viewedFreelancer = false.obs;

  @override
  void onInit() async {
    super.onInit();
    whoYouAre = SpUtil.getBool(ConstString.WHO_YOU_ARE);
    loginIn = SpUtil.getBool(ConstString.LOGIN_IN);
    changeWhoUR();
    changeLogin();
    // checkWhoUR.value ? setUpFreelancer() : setUpNTD();
    getAllSkills();
    checkIndexFreelancer();
    checkDetailProjected();
    salaryWantTextEditingController.addListener(() {});
    yourEmailTextEditingController.addListener(() {});
    searchTextEditingController.addListener(() {});
    focusNode.addListener(() {
      checkFocusNode();
    });
    showCity();
    showCareer();
    showSkills();
    showFocus();
    updateRate();
  }

  //HomeController

  HomeRepositories _homeRepositories = HomeRepositories();
  AuthenticationRepositories _authenticationRepositories = AuthenticationRepositories();

  RxInt indexFreelancer = 14.obs;
  var now = new DateTime.now();
  var convertTime = DateFormat("MMM-d-yyyy HH:mm:ss a +UTC");
  ScrollController scrollController;

  RxDouble rate = 0.0.obs;
  RxBool checkMoreDetail = false.obs;
  RxBool saveFreelancer = false.obs;
  RxBool saveProjected = false.obs;
  RxBool checkDetailJob = false.obs;

  RxBool checkDetailProject = false.obs;
  RxBool watchMore = false.obs;
  RxBool checkFocus = false.obs;
  RxBool checkFocusEmpty = false.obs;

  RxInt indexCategory = 0.obs;
  RxString indexIdJob = ''.obs;
  RxString indexIdFreelancer = ''.obs;
  RxString dateEnd = ''.obs;
  RxInt loadTime = 1.obs;
  List<String> skills = [];
  RxInt indexForm = 0.obs;
  RxInt indexOrderByValue = 0.obs;

  DropListModelForm dropListModelForm = DropListModelForm([
    OptionItemForm(id: 1, title: "Toàn thời gian cố định"),
    OptionItemForm(id: 2, title: "Toàn thời gian tạm thời"),
    OptionItemForm(id: 3, title: "Bán thời gian"),
    OptionItemForm(id: 4, title: "Bán thời gian tạm thời"),
    OptionItemForm(id: 5, title: "Hợp đồng"),
    OptionItemForm(id: 6, title: "Khác"),
  ]);
  OptionItemForm optionItemSelectedForm = OptionItemForm(id: null, title: "Chọn hình thức");

  DropListModelFreelancer dropListModelFreelancer =
      DropListModelFreelancer([OptionItemFreelancer(id: "1", title: "Mới nhất"), OptionItemFreelancer(id: "2", title: "Xuất sắc nhất")]);

  OptionItemFreelancer optionItemSelectedFreelancer = OptionItemFreelancer(id: null, title: "Sắp xếp");

  void changeOrderByValue() {
    indexOrderByValue.value = int.parse(optionItemSelectedFreelancer.id);
    update();
  }

  void changeForm() {
    indexForm.value = optionItemSelectedForm.id;
    update();
  }

  RxString nameCity = ''.obs;
  RxInt indexCity = 0.obs;
  RxBool chooseCity = false.obs;
  RxString nameCareer = ''.obs;
  RxInt indexCareer = 0.obs;
  RxBool chooseCareer = false.obs;
  RxString nameSkills = ''.obs;
  RxInt indexSkills = 0.obs;
  RxBool chooseSkills = false.obs;
  RxString nameForm = ''.obs;
  RxBool chooseForm = false.obs;

  RxString selectedFreelancer = ''.obs;

  RxBool checkDeal = false.obs;

  ResultListJobProjectHome resultListJobProjectHome = ResultListJobProjectHome();
  ResultListJobPartimeHome resultListJobPartimeHome = ResultListJobPartimeHome();
  ResultListFreelancerLatestHome resultListFreelancerLatestHome = ResultListFreelancerLatestHome();
  ResultListFreelancerOutstandingHome resultListFreelancerOutstandingHome = ResultListFreelancerOutstandingHome();
  ResultFreelancer resultFreelancer = ResultFreelancer();

  ResultGetSkills resultGetSkills = ResultGetSkills();

  ResultDetailFreelancer resultDetailFreelancer = ResultDetailFreelancer();
  ResultJobDetail resultJobDetail = ResultJobDetail();
  ResultGetListJob resultGetListJob = ResultGetListJob();
  ResultJobPosted resultJobPosted = ResultJobPosted();

  List<ListJobProjectHome> listJobProjectHome = [];
  List<ListJobPartimeHome> listJobPartimeHome = [];
  List<ListFlcLatestHome> listFreelancerLatestHome = [];
  List<ListFlcOutstandingHome> listFreelancerOutstandingHome = [];
  List<ListFlc> listFreelancer = [];
  List<FlcDatGia> listFreelancerDatGiaProject = [];
  List<SimilarJob> listSimilarJobProject = [];
  List<ProjectImageDetail> listProjectImage = [];
  List<ProjectFileDetail> listProjectFile = [];
  List<TopFlc> listTopFlc = [];
  List<CongViecDaDang> listCongViecDaDang = [];
  List<FlcDatGiaLoadMore> listLoadMoreFreelancerDeal = [];
  List<ListTag> listTag = [];
  List<ListJob> listJob = [];
  List<ListSkill> listSkills = [];

  TextEditingController salaryWantTextEditingController = TextEditingController();

  String get salaryWant => salaryWantTextEditingController.text;

  TextEditingController yourEmailTextEditingController = TextEditingController();

  String get yourEmail => yourEmailTextEditingController.text;

  TextEditingController searchTextEditingController = TextEditingController();

  String get search => searchTextEditingController.text;

  FocusNode focusNode = FocusNode();

  void checkFocusNode() {
    if (searchTextEditingController.text.isNotEmpty && checkFocus.value == false) {
      loadTime.value = 1;
      clearListSearch();
      _waitLoginController.checkWhoUR.value ? getListJob() : getListFreelancer();
      checkFocus.value = true;
      checkFocusEmpty.value = false;
    } else if (searchTextEditingController.text.isNotEmpty && checkFocus.value == true) {
      checkFocus.value = false;
      checkFocusEmpty.value = true;
    }
    // else if (searchTextEditingController.text.isEmpty && checkFocusEmpty.value == true) {
    //   clearListSearch();
    //   checkWhoUR.value ? getListJob() : getListFreelancer();
    //   checkFocusEmpty.value = false;
    // }
    update();
  }

  void showFocus() {
    checkFocus.value;
    checkFocusEmpty.value;
    update();
  }

  void showCity() {
    chooseCity.value;
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

  void showDetailFlc() {
    viewedFreelancer.value = true;
    update();
  }

  void checkCategory() {
    indexCategory.value;
    update();
  }

  void checkDetailJobPost() {
    checkDetailJob.value;
    update();
  }

  void checkIdJob() {
    indexIdJob.value;
    update();
  }

  void saveFreelancerButton() {
    saveFreelancer.value = true;
    update();
  }

  void checkDetailProjected() {
    checkDetailProject.value;
    update();
  }

  void checkIndexFreelancer() {
    indexFreelancer.value;
    update();
  }

  void updateRate() {
    rate.value;
    update();
  }

  void showWatchMore() {
    watchMore.value;
    update();
  }

  void checkIndexOrderByValue() {
    indexOrderByValue.value;
    update();
  }

  String checkValidSalary() {
    if (salaryWant == "" && checkDeal.value) {
      return 'Bạn chưa nhập mức lương mong muốn';
    }
    return null;
  }

  String checkValidEmail() {
    if (!RegExp(r'^[a-z0-9.]*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?').hasMatch(yourEmail) && yourEmail.isNotEmpty) {
      return 'Email bạn nhập không hợp lệ';
    } else if (yourEmail == "" && checkDeal.value) {
      return 'Bạn chưa nhập Email';
    }
    return null;
  }

  void checkDealer() {
    checkDeal.value;
    update();
  }

  Future<void> getTagFromCategory(int category) async {
    ResultData res = await _authenticationRepositories.getListTagFromCategory(category);
    if (res.result) {
      ResultTagFromCategory resultTagFromCategory = resultTagFromCategoryFromJson(res.data);

      for (int i = 0; i < resultTagFromCategory.data.listTag.length; i++) {
        listTag.add(resultTagFromCategory.data.listTag[i]);
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

  String tag(int index) {
    if (listJobProjectHome[index].maKiNang == listTag[index].id) {
      return listTag[index].name;
    }
    return null;
  }

  void showTopFlc(int index) {
    if (listTopFlc[index].idFlc == checkTopFlc) {
      topFlc.value = !topFlc.value;
    }
    update();
  }

  void loadMoreJob() {
    loadTime.value += 1;
    getListJob();
    update();
  }

  void loadMoreFreelancer() {
    loadTime.value += 1;
    getListFreelancer();
    update();
  }

  void loadMoreJobPosted() {
    loadTime.value += 1;
    jobPosted();
    update();
  }

  void loadMoreFreelancerD() {
    loadTime.value += 1;
    loadMoreFreelancerDeal();
    update();
  }

  void clearListDetailFreelancer() {
    listProjectFile.clear();
    listProjectImage.clear();
    listTopFlc.clear();
    checkTopFlc = "";
    update();
  }

  void clearList() {
    // optionItemSelectedFreelancer.id = null;
    indexOrderByValue.value = 0;
    selectedFreelancer.value = 'Sắp xếp';
    // optionItemSelectedFreelancer.title = 'Sắp xếp';
    indexCategory.value = 0;
    indexOrderByValue.value = 0;
    indexForm.value = 0;
    indexSkills.value = 0;
    indexCity.value = 0;
    indexCareer.value = 0;
    listFreelancer.clear();
    listJob.clear();
    watchMore.value = false;
    loadTime.value = 1;
    update();
  }

  void clearListDetailJob() {
    checkDeal.value = false;
    salaryWantTextEditingController.clear();
    yourEmailTextEditingController.clear();
    listLoadMoreFreelancerDeal.clear();
    listFreelancerDatGiaProject.clear();
    listSimilarJobProject.clear();
    loadTime.value = 1;
    update();
  }

  void clearListCongViecDaDang() {
    listCongViecDaDang.clear();
    loadTime.value = 1;
    update();
  }

  void resetFilter() {
    searchTextEditingController.clear();
    optionItemSelectedForm.id = null;
    // optionItemSelectedForm.title = 'Chọn hình thức';
    checkFocus.value = false;
    chooseCity.value = false;
    chooseCareer.value = false;
    chooseSkills.value = false;
    chooseForm.value = false;
    indexCity.value = 0;
    indexCareer.value = 0;
    indexCategory.value = 0;
    indexSkills.value = 0;
    indexForm.value = 0;
    nameForm.value = 'Chọn hình thức';
    loadTime.value = 1;
    update();
  }

  void launchTelURL(String phone) async {
    String url = 'tel:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Utils.showToast('Không thể gọi');
    }
    update();
  }

  void setUpFreelancer() {
    getListJobProjectHome();
    getListJobPartimeHome();
    update();
  }

  void setUpNTD() {
    getListFreelancerLatestHome();
    getListFreelancerOutstandingHome();
    update();
  }

  void getAllSkills() async {
    ResultData res = await _homeRepositories.getAllSkills();
    resultGetSkills = resultGetSkillsFromJson(res.data);
    if (resultGetSkills.data.result) {
      for (int i = 0; i < resultGetSkills.data.listSkills.length; i++) {
        listSkills.add(resultGetSkills.data.listSkills[i]);
      }
    } else {}
    update();
  }

  void getListJobProjectHome() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    ResultData res = await _homeRepositories.listJobProjectHome();
    if (res.result) {
      resultListJobProjectHome = resultListJobProjectHomeFromJson(res.data);

      for (int i = 0; i < resultListJobProjectHome.data.listJobProjectHome.length; i++) {
        listJobProjectHome.add(resultListJobProjectHome.data.listJobProjectHome[i]);
      }
      Get.back();
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

  void getListJobPartimeHome() async {
    ResultData res = await _homeRepositories.listJobPartimeHome();
    if (res.result) {
      resultListJobPartimeHome = resultListJobPartimeHomeFromJson(res.data);

      for (int i = 0; i < resultListJobPartimeHome.data.listJobPartimeHome.length; i++) {
        listJobPartimeHome.add(resultListJobPartimeHome.data.listJobPartimeHome[i]);
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

  void getListFreelancerLatestHome() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    String token = SpUtil.getString(ConstString.token);
    ResultData res = await _homeRepositories.listJobLatestHome(token);
    if (res.result) {
      resultListFreelancerLatestHome = resultListFreelancerLatestHomeFromJson(res.data);

      for (int i = 0; i < resultListFreelancerLatestHome.data.listFlc.length; i++) {
        listFreelancerLatestHome.add(resultListFreelancerLatestHome.data.listFlc[i]);
      }
      Get.back();
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

  void getListFreelancerOutstandingHome() async {
    String token = SpUtil.getString(ConstString.token);
    ResultData res = await _homeRepositories.listJobOutstandingHome(token);
    if (res.result) {
      resultListFreelancerOutstandingHome = resultListFreelancerOutstandingHomeFromJson(res.data);

      for (int i = 0; i < resultListFreelancerOutstandingHome.data.listFlc.length; i++) {
        listFreelancerOutstandingHome.add(resultListFreelancerOutstandingHome.data.listFlc[i]);
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

  void getListFreelancer() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    String token = SpUtil.getString(ConstString.token);
    int city = indexCity.value;
    int category = indexCategory.value;
    int skills = indexSkills.value;
    int typeOfWorking = indexForm.value;
    int orderByValue = indexOrderByValue.value;
    int loadtime = loadTime.value;
    ResultData res = await _homeRepositories.listFreelancer(token, search, city, category, skills, typeOfWorking, orderByValue, loadtime);
    resultFreelancer = resultFreelancerFromJson(res.data);
    if (resultFreelancer.data.result) {
      for (int i = 0; i < resultFreelancer.data.listFlc.length; i++) {
        listFreelancer.add(resultFreelancer.data.listFlc[i]);
      }
      Get.back();
    } else {
      Utils.showToast(resultFreelancer.error.message);
      Get.back();
    }
    update();
  }

  void getDetailJob() async {
    String token = SpUtil.getString(ConstString.token);
    String maViec = indexIdJob.value;
    ResultData res = await _homeRepositories.detailJob(token, maViec);
    resultJobDetail = resultJobDetailFromJson(res.data);
    if (resultJobDetail.data != null) {
      SpUtil.putString(ConstString.ID_USER, resultJobDetail.data.inforCompany.id);
      SpUtil.putString(ConstString.AVATAR_NTD, resultJobDetail.data.inforCompany.avatarNtd);
      SpUtil.putString(ConstString.LINK_AVATAR, resultJobDetail.data.inforCompany.linkAvt);
      SpUtil.putString(ConstString.LINK_DETAIL_NTD, resultJobDetail.data.inforCompany.linkDetailNtd);
      SpUtil.putString(ConstString.TEN_NTD, resultJobDetail.data.inforCompany.tenNtd);
      SpUtil.putString(ConstString.TINH_TP_NTD, resultJobDetail.data.inforCompany.tinhTpNtd);
      SpUtil.putString(ConstString.SDT, resultJobDetail.data.inforCompany.sdt);
      SpUtil.putString(ConstString.EMAIL_NTD, resultJobDetail.data.inforCompany.email);
      SpUtil.putString(ConstString.THAM_GIA, resultJobDetail.data.inforCompany.thamGia);
      SpUtil.putString(ConstString.DA_DANG, resultJobDetail.data.inforCompany.daDang);
      SpUtil.putString(ConstString.ANH_LOGO_CV, resultJobDetail.data.jobDetail.anhLogoCv);
      SpUtil.putString(ConstString.PATH_LOGO_CV, resultJobDetail.data.jobDetail.pathAnhLogo);
      SpUtil.putString(ConstString.TEN_CV, resultJobDetail.data.jobDetail.tenCv);
      SpUtil.putBool(ConstString.SAVED_CV, resultJobDetail.data.jobDetail.saved);
      SpUtil.putString(ConstString.CHI_PHI, resultJobDetail.data.jobDetail.chiPhi);
      SpUtil.putString(ConstString.ID_DU_AN, resultJobDetail.data.jobDetail.idDuAn);
      SpUtil.putString(ConstString.NGAY_DANG, resultJobDetail.data.jobDetail.ngayDang);
      SpUtil.putString(ConstString.HINH_THUC, resultJobDetail.data.jobDetail.hinhThuc);
      SpUtil.putString(ConstString.NGAY_BD, resultJobDetail.data.jobDetail.ngayBd);
      SpUtil.putString(ConstString.DAT_GIA_KT, resultJobDetail.data.jobDetail.datGiaKt);
      SpUtil.putString(ConstString.THOI_HAN, resultJobDetail.data.jobDetail.thoiHan);
      SpUtil.putString(ConstString.DIA_DIEM, resultJobDetail.data.jobDetail.diaDiem);
      SpUtil.putString(ConstString.KINH_NGHIEM, resultJobDetail.data.jobDetail.kinhNghiem);
      SpUtil.putString(ConstString.MO_TA, resultJobDetail.data.jobDetail.moTa);
      SpUtil.putString(ConstString.FILE_DINH_KEM, resultJobDetail.data.jobDetail.fileDinhKem);
      SpUtil.putString(ConstString.LINK_FILE, resultJobDetail.data.jobDetail.linkFile);
      SpUtil.putString(ConstString.KY_NANG, resultJobDetail.data.jobDetail.kyNang);
      SpUtil.putString(ConstString.SO_LUONG_DAT_GIA_CV, resultJobDetail.data.jobDetail.soLuongDatGiaCv);
      for (int i = 0; i < resultJobDetail.data.flcDatGia.length; i++) {
        listFreelancerDatGiaProject.add(resultJobDetail.data.flcDatGia[i]);
      }
      for (int i = 0; i < resultJobDetail.data.similarJob.length; i++) {
        listSimilarJobProject.add(resultJobDetail.data.similarJob[i]);
      }
      checkDetailJob.value
          ? Get.to(DetailJobPosted(
              nameProject: SpUtil.getString(ConstString.TEN_CV),
              urlLogo: SpUtil.getString(ConstString.PATH_LOGO_CV) + SpUtil.getString(ConstString.ANH_LOGO_CV),
              money: SpUtil.getString(ConstString.CHI_PHI),
              datePost: SpUtil.getString(ConstString.NGAY_DANG),
              dateEnd: SpUtil.getString(ConstString.DAT_GIA_KT),
              id: SpUtil.getString(ConstString.ID_DU_AN),
              urlAvatar: SpUtil.getString(ConstString.LINK_AVATAR) + SpUtil.getString(ConstString.AVATAR_NTD),
              namePoster: SpUtil.getString(ConstString.TEN_NTD),
              addreddLive: SpUtil.getString(ConstString.TINH_TP_NTD),
              phone: SpUtil.getString(ConstString.SDT),
              email: SpUtil.getString(ConstString.EMAIL_NTD),
              dateJoin: SpUtil.getString(ConstString.THAM_GIA),
              postedMany: SpUtil.getString(ConstString.DA_DANG),
              form: SpUtil.getString(ConstString.HINH_THUC),
              dateStart: SpUtil.getString(ConstString.NGAY_BD),
              deadLine: SpUtil.getString(ConstString.THOI_HAN),
              addressWork: SpUtil.getString(ConstString.DIA_DIEM),
              exp: SpUtil.getString(ConstString.KINH_NGHIEM),
              describe: SpUtil.getString(ConstString.MO_TA),
              file: SpUtil.getString(ConstString.LINK_FILE) + SpUtil.getString(ConstString.FILE_DINH_KEM),
              turnedDeal: SpUtil.getString(ConstString.SO_LUONG_DAT_GIA_CV),
            ))
          : Get.to(WatchDetailScreen(
              nameProject: SpUtil.getString(ConstString.TEN_CV),
              urlLogo: SpUtil.getString(ConstString.PATH_LOGO_CV) + SpUtil.getString(ConstString.ANH_LOGO_CV),
              money: SpUtil.getString(ConstString.CHI_PHI),
              id: SpUtil.getString(ConstString.ID_DU_AN),
              datePost: SpUtil.getString(ConstString.NGAY_DANG),
              dateEnd: SpUtil.getString(ConstString.DAT_GIA_KT),
              urlAvatar: SpUtil.getString(ConstString.LINK_AVATAR) + SpUtil.getString(ConstString.AVATAR_NTD),
              namePoster: SpUtil.getString(ConstString.TEN_NTD),
              addreddLive: SpUtil.getString(ConstString.TINH_TP_NTD),
              phone: SpUtil.getString(ConstString.SDT),
              email: SpUtil.getString(ConstString.EMAIL_NTD),
              dateJoin: SpUtil.getString(ConstString.THAM_GIA),
              postedMany: SpUtil.getString(ConstString.DA_DANG),
              form: SpUtil.getString(ConstString.HINH_THUC),
              dateStart: SpUtil.getString(ConstString.NGAY_BD),
              deadLine: SpUtil.getString(ConstString.THOI_HAN),
              addressWork: SpUtil.getString(ConstString.DIA_DIEM),
              exp: SpUtil.getString(ConstString.KINH_NGHIEM),
              describe: SpUtil.getString(ConstString.MO_TA),
              file: SpUtil.getString(ConstString.LINK_FILE) + SpUtil.getString(ConstString.FILE_DINH_KEM),
              listSkill: getSkillDetailJob(),
              turnedDeal: SpUtil.getString(ConstString.SO_LUONG_DAT_GIA_CV),
            ));
      saveProjected.value = SpUtil.getBool(ConstString.SAVED_CV);
      loadMoreFreelancerDeal();
    } else {}
    update();
  }

  void dealSalary() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    String token = SpUtil.getString(ConstString.token);
    int idProject = int.parse(indexIdJob.value);
    if (salaryWant != '0') {
      if (RegExp(r'^[a-z0-9.]*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?').hasMatch(yourEmail)) {
        ResultData res = await _homeRepositories.dealSalary(token, idProject, salaryWant, yourEmail);
        ResultNotification resultNotification = resultNotificationFromJson(res.data);
        if (resultNotification.data.result) {
          Utils.showToast(resultNotification.data.message);
          checkDeal.value = false;
          checkDealer();
          Get.back();
          Get.back();
        } else {
          Utils.showToast(resultNotification.error.message);
          checkDeal.value = true;
          checkDealer();
          Get.back();
        }
      } else {
        checkDeal.value = true;
        checkDealer();
        Utils.showToast('Thông tin bạn nhập sai vui lòng kiểm tra lại');
        Get.back();
      }
    } else {
      checkDeal.value = true;
      checkDealer();
      Utils.showToast('Đặt giá phải lớn hơn 0');
      Get.back();
    }
    update();
  }

  void saveProject() async {
    String token = SpUtil.getString(ConstString.token);
    int idProject = int.parse(indexIdJob.value);
    ResultData res = await _homeRepositories.saveProject(token, idProject);
    ResultNotification resultNotification = resultNotificationFromJson(res.data);
    if (resultNotification.data.result) {
      saveProjected.value = true;
      Utils.showToast(resultNotification.data.message);
    } else {
      Utils.showToast(resultNotification.error.message);
    }
    update();
  }

  void detailFreelancer() async {
    String token = SpUtil.getString(ConstString.token);
    int idFreelancer = int.parse(indexIdFreelancer.value);
    ResultData res = await _homeRepositories.detailFreelancer(idFreelancer, token);
    resultDetailFreelancer = resultDetailFreelancerFromJson(res.data);
    if (resultDetailFreelancer.data != null) {
      SpUtil.putString(ConstString.AVATAR_FLC, resultDetailFreelancer.data.freelancerInfor.avatar);
      SpUtil.putString(ConstString.PATH_AVATAR_FLC, resultDetailFreelancer.data.freelancerInfor.pathAvt);
      SpUtil.putString(ConstString.HO_TEN_FLC, resultDetailFreelancer.data.freelancerInfor.hoTen);
      SpUtil.putString(ConstString.DIA_CHI_FLC, resultDetailFreelancer.data.freelancerInfor.diaChi);
      SpUtil.putString(ConstString.NGAY_SINH_FLC, resultDetailFreelancer.data.freelancerInfor.ngaySinh);
      SpUtil.putString(ConstString.GIOI_TINH_FLC, resultDetailFreelancer.data.freelancerInfor.gioiTinh);
      SpUtil.putString(ConstString.SDT_FLC, resultDetailFreelancer.data.freelancerInfor.sdt);
      SpUtil.putString(ConstString.EMAIL_FLC, resultDetailFreelancer.data.freelancerInfor.email);
      SpUtil.putBool(ConstString.SAVED_FLC, resultDetailFreelancer.data.freelancerInfor.saved);
      SpUtil.putBool(ConstString.VIEWED_FLC, resultDetailFreelancer.data.freelancerInfor.viewed);
      SpUtil.putString(ConstString.KINH_NGHIEM_FLC, resultDetailFreelancer.data.freelancerInfor.kinhNghiem);
      SpUtil.putString(ConstString.GIOI_THIEU_FLC, resultDetailFreelancer.data.freelancerInfor.gioiThieu);
      SpUtil.putString(ConstString.NGANH_NGHE_FLC, resultDetailFreelancer.data.freelancerInfor.nganhNghe);
      SpUtil.putString(ConstString.NGHE_NGHIEP_FLC, resultDetailFreelancer.data.freelancerInfor.ngheNghiep);
      SpUtil.putString(ConstString.KY_NANG_FLC, resultDetailFreelancer.data.freelancerInfor.kyNang);
      SpUtil.putString(ConstString.HINH_THUC_LAM_VIEC_FLC, resultDetailFreelancer.data.freelancerInfor.hinhThucLamViec);
      SpUtil.putString(
          ConstString.PERCENT_COMPLETE_FLC, double.parse(resultDetailFreelancer.data.freelancerInfor.perecentComplete.toString()).toString());
      SpUtil.putDouble(ConstDouble.TB_RATE_FLC, resultDetailFreelancer.data.freelancerInfor.tbRate);
      SpUtil.putString(ConstString.XEP_LOAI_FLC, resultDetailFreelancer.data.freelancerInfor.xepLoai);
      for (int i = 0; i < resultDetailFreelancer.data.projectImage.length; i++) {
        listProjectImage.add(resultDetailFreelancer.data.projectImage[i]);
      }
      for (int i = 0; i < resultDetailFreelancer.data.projectFile.length; i++) {
        listProjectFile.add(resultDetailFreelancer.data.projectFile[i]);
      }
      for (int i = 0; i < resultDetailFreelancer.data.topFlc.length; i++) {
        listTopFlc.add(resultDetailFreelancer.data.topFlc[i]);
      }
      Get.to(WatchDetailFreelancerScreen(
        urlAvatar: SpUtil.getString(ConstString.PATH_AVATAR_FLC) + '/' + SpUtil.getString(ConstString.AVATAR_FLC),
        name: SpUtil.getString(ConstString.HO_TEN_FLC),
        job: SpUtil.getString(ConstString.NGHE_NGHIEP_FLC),
        address: SpUtil.getString(ConstString.DIA_CHI_FLC),
        rate: double.parse(SpUtil.getDouble(ConstDouble.TB_RATE_FLC).toString()),
        percentComplete: double.parse(SpUtil.getString(ConstString.PERCENT_COMPLETE_FLC)),
        classification: SpUtil.getString(ConstString.XEP_LOAI_FLC),
        sex: SpUtil.getString(ConstString.GIOI_TINH_FLC),
        phone: SpUtil.getString(ConstString.SDT_FLC),
        email: SpUtil.getString(ConstString.EMAIL_FLC),
        birth: SpUtil.getString(ConstString.NGAY_SINH_FLC),
        exp: SpUtil.getString(ConstString.KINH_NGHIEM_FLC),
        intro: SpUtil.getString(ConstString.GIOI_THIEU_FLC),
        listSkill: getSkillDetailFreelancer(2),
      ));
      saveFreelancer.value = SpUtil.getBool(ConstString.SAVED_FLC);
      viewedFreelancer.value = SpUtil.getBool(ConstString.VIEWED_FLC);
    } else {}
    update();
  }

  void savedFreelancer() async {
    String token = SpUtil.getString(ConstString.token);
    String idFreelancer = indexIdFreelancer.value;
    ResultData res = await _homeRepositories.saveFreelancer(token, idFreelancer);
    ResultNotification resultNotification = resultNotificationFromJson(res.data);
    if (resultNotification.data.result) {
      saveFreelancerButton();
      Utils.showToast(resultNotification.data.message);
    } else {
      Utils.showToast(resultNotification.error.message);
    }
    update();
  }

  void jobPosted() async {
    int mantd = int.parse(SpUtil.getString(ConstString.ID_USER));
    int xemThem = loadTime.value;
    ResultData res = await _homeRepositories.jobPosted(mantd, xemThem);
    resultJobPosted = resultJobPostedFromJson(res.data);
    if (resultJobPosted.data.result) {
      SpUtil.putString(ConstString.AVATAR_NTD, resultJobPosted.data.employeeInfor.avatarNtd);
      SpUtil.putString(ConstString.LINK_AVATAR, resultJobPosted.data.employeeInfor.pathAvt);
      SpUtil.putString(ConstString.TEN_NTD, resultJobPosted.data.employeeInfor.tenNtd);
      SpUtil.putString(ConstString.TINH_TP_NTD, resultJobPosted.data.employeeInfor.tinhTpNtd);
      SpUtil.putString(ConstString.SDT, resultJobPosted.data.employeeInfor.sdtNtd);
      SpUtil.putString(ConstString.EMAIL_NTD, resultJobPosted.data.employeeInfor.emailNtd);
      SpUtil.putString(ConstString.THAM_GIA, resultJobPosted.data.employeeInfor.thamGia);
      SpUtil.putString(ConstString.DA_DANG, resultJobPosted.data.employeeInfor.daDang);
      clearListCongViecDaDang();
      for (int i = 0; i < resultJobPosted.data.congViecDaDang.length; i++) {
        listCongViecDaDang.add(resultJobPosted.data.congViecDaDang[i]);
      }
      Get.to(JobPostedScreen(
        urlAvatar: SpUtil.getString(ConstString.LINK_AVATAR) + '/' + SpUtil.getString(ConstString.AVATAR_NTD),
        name: SpUtil.getString(ConstString.TEN_NTD),
        email: SpUtil.getString(ConstString.EMAIL_NTD),
        phone: SpUtil.getString(ConstString.SDT),
        address: SpUtil.getString(ConstString.TINH_TP_NTD),
        dateJoin: SpUtil.getString(ConstString.THAM_GIA),
        jobPosted: SpUtil.getString(ConstString.DA_DANG),
      ));
    }
    update();
  }

  void loadMoreFreelancerDeal() async {
    int maViec = int.parse(indexIdJob.value);
    int xemThem = loadTime.value;
    ResultData res = await _homeRepositories.loadMoreFreelancerDeal(maViec, xemThem);
    ResultLoadMoreFreelancerDeal resultLoadMoreFreelancerDeal = resultLoadMoreFreelancerDealFromJson(res.data);
    if (resultLoadMoreFreelancerDeal.data.result) {
      for (int i = 0; i < resultLoadMoreFreelancerDeal.data.flcDatGia.length; i++) {
        listLoadMoreFreelancerDeal.add(resultLoadMoreFreelancerDeal.data.flcDatGia[i]);
      }
    } else {
      // Utils.showToast(resultLoadMoreFreelancerDeal.error.message);
    }
    update();
  }

  void getListJob() async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    int tinhThanh = indexCity.value;
    int nganhNghe = indexCategory.value;
    int kyNang = indexSkills.value;
    int loaiViecLam = indexOrderByValue.value;
    int loadtime = loadTime.value;
    ResultData res = await _homeRepositories.listJob(search, tinhThanh, nganhNghe, kyNang, loaiViecLam, loadtime);
    resultGetListJob = resultGetListJobFromJson(res.data);
    if (resultGetListJob.data.result) {
      for (int i = 0; i < resultGetListJob.data.listJob.length; i++) {
        listJob.add(resultGetListJob.data.listJob[i]);
      }
      Get.back();
    } else {
      Utils.showToast(resultGetListJob.error.message);
      Get.back();
    }
    update();
  }

  void clearListSearch() {
    listJob.clear();
    listFreelancer.clear();
    update();
  }

  void minusPointContact() async {
    String token = SpUtil.getString(ConstString.token);
    String idFlc = indexIdFreelancer.value;
    ResultData res = await _homeRepositories.minusPointContact(token, idFlc);
    if (res.result) {
      showDetailFlc();
      Get.back();
    } else {}
    update();
  }

  //NaviController

  void changeWhoUR() {
    checkWhoUR.value = whoYouAre;
    update();
  }

  void changeLogin() {
    checkLogin.value = loginIn;
    update();
  }

  void changePageOut(Widget widget) {
    print('changePageOut');
    currentPage.value = widget;
    update();
  }

  void changePage(
    int index,
  ) {
    pageIndex.value = index;
    print("changePage");
    switch (index) {
      case 0:
        pageIndex.value = 0;
        changeWhoUR();
        changeLogin();
        resetFilter();
        clearList();
        currentPage.value = HomeScreen();
        break;
      case 1:
        pageIndex.value = 1;
        changeWhoUR();
        changeLogin();
        currentPage.value = NotificationScreen();
        break;
      case 2:
        pageIndex.value = 2;
        changeWhoUR();
        changeLogin();
        currentPage.value = ChatNotUse();
        break;
      case 3:
        pageIndex.value = 3;
        changeWhoUR();
        changeLogin();
        if (_waitLoginController.checkWhoUR.value == false && _waitLoginController.checkLogin.value == false) {
          currentPage.value = EmployerHomePageIsNotLoggedInScreen();
        } else if (_waitLoginController.checkWhoUR.value == true && _waitLoginController.checkLogin.value == false) {
          currentPage.value = PersonalPageCandidateLoggedInScreen();
        } else if (_waitLoginController.checkWhoUR.value == false && _waitLoginController.checkLogin.value == true) {
          currentPage.value = EmployerProfileScreen();
        } else if (_waitLoginController.checkWhoUR.value == true && _waitLoginController.checkLogin.value == true){
          currentPage.value = CandidateProfileScreen();
        }
        break;
      case 4:
        pageIndex.value = 4;
        changeWhoUR();
        changeLogin();
        currentPage.value = MenuScreen();
        break;
    }
    update();
  }

  List<String> getSkillLatestOfFreelancer(int index, int numElement) {
    List<String> listSubject = [];
    int a = numElement;
    if (listFreelancerLatestHome[index].kyNang.isEmpty) return listSubject;
    var listStringSubject = listFreelancerLatestHome[index].kyNang.split(',');
    listSkills.forEach((element) {
      for (int i = 0; i < listStringSubject.length; i++) {
        if (element.id == listStringSubject[i]) {
          listSubject.add(element.name);
        }
      }
    });
    listSubject.sort((a, b) => a.length.compareTo(b.length));
    for (int i = 0; i < listSubject.length; i++) {
      if (listSubject[i].length >= 7 && i < a) {
        ind.value = a;
        break;
      } else if (listSubject[i].length < 7 && i < a) {
        ind.value = a + 1;
        break;
      } else if (listSubject[i].length >= 7) {
        ind.value = i;
        break;
      }
    }
    for (int i = ind.value; i < listSubject.length; i++) {
      listSubject[i] = " ";
    }
    return listSubject;
  }

  List<String> getSkillOutstandingOfFreelancer(int index, int numElement) {
    List<String> listSubject = [];
    int a = numElement;
    if (listFreelancerOutstandingHome[index].kyNang.isEmpty) return listSubject;
    var listStringSubject = listFreelancerOutstandingHome[index].kyNang.split(',');
    listSkills.forEach((element) {
      for (int i = 0; i < listStringSubject.length; i++) {
        if (element.id == listStringSubject[i]) {
          listSubject.add(element.name);
        }
      }
    });
    listSubject.sort((a, b) => a.length.compareTo(b.length));
    for (int i = 0; i < listSubject.length; i++) {
      if (listSubject[i].length >= 7 && i < a) {
        ind.value = a;
        break;
      } else if (listSubject[i].length < 7 && i == a) {
        ind.value = a + 1;
        break;
      } else if (listSubject[i].length >= 7) {
        ind.value = i;
        break;
      }
    }
    for (int i = ind.value; i < listSubject.length; i++) {
      listSubject[i] = " ";
    }
    return listSubject;
  }

  List<String> getSkillJobByProject(int index) {
    List<String> listSubject = [];
    if (listJobProjectHome[index].maKiNang.isEmpty) return listSubject;
    var listStringSubject = listJobProjectHome[index].maKiNang.split(',');
    listSkills.forEach((element) {
      for (int i = 0; i < listStringSubject.length; i++) {
        if (element.id == listStringSubject[i]) {
          listSubject.add(element.name);
        }
      }
    });
    return listSubject;
  }

  List<String> getSkillJobByTime(int index) {
    List<String> listSubject = [];
    if (listJobPartimeHome[index].maKiNang.isEmpty) return listSubject;
    var listStringSubject = listJobPartimeHome[index].maKiNang.split(',');
    listSkills.forEach((element) {
      for (int i = 0; i < listStringSubject.length; i++) {
        if (element.id == listStringSubject[i]) {
          listSubject.add(element.name);
        }
      }
    });
    return listSubject;
  }

  List<String> getSkillDetailFreelancer(int numElement) {
    List<String> listSubject = [];
    int a = numElement;
    var listStringSubject = resultDetailFreelancer.data.freelancerInfor.kyNang.split(',');
    resultGetSkills.data.listSkills.forEach((element) {
      for (int i = 0; i < listStringSubject.length; i++) {
        if (element.id == listStringSubject[i]) {
          listSubject.add(element.name);
        }
      }
    });
    listSubject.sort((a, b) => a.length.compareTo(b.length));
    for (int i = 0; i < listSubject.length; i++) {
      if (listSubject[i].length >= 7 && i < a) {
        ind.value = a;
        break;
      } else if (listSubject[i].length < 7 && i == a) {
        ind.value = a + 1;
        break;
      } else if (listSubject[i].length >= 7) {
        ind.value = i;
        break;
      }
    }
    for (int i = ind.value; i < listSubject.length; i++) {
      listSubject[i] = " ";
    }
    return listSubject;
  }

  List<String> getSkillTopFreelancerDetailFreelancer(int index, int numElement) {
    List<String> listSubject = [];
    int a = numElement;
    var listStringSubject = listTopFlc[index].kyNang.split(',');
    resultGetSkills.data.listSkills.forEach((element) {
      for (int i = 0; i < listStringSubject.length; i++) {
        if (element.id == listStringSubject[i]) {
          listSubject.add(element.name);
        }
      }
    });
    listSubject.sort((a, b) => a.length.compareTo(b.length));
    for (int i = 0; i < listSubject.length; i++) {
      if (listSubject[i].length >= 7 && i < a) {
        ind.value = a;
        break;
      } else if (listSubject[i].length < 7 && i == a) {
        ind.value = a + 1;
        break;
      } else if (listSubject[i].length >= 7) {
        ind.value = i;
        break;
      }
    }
    for (int i = ind.value; i < listSubject.length; i++) {
      listSubject[i] = " ";
    }
    return listSubject;
  }

  List<String> getSkillDetailJob() {
    List<String> listSubject = [];
    var listStringSubject = resultJobDetail.data.jobDetail.kyNang.split(',');
    resultGetSkills.data.listSkills.forEach((element) {
      for (int i = 0; i < listStringSubject.length; i++) {
        if (element.id == listStringSubject[i]) {
          listSubject.add(element.name);
        }
      }
    });
    return listSubject;
  }

  List<String> getSkillJob(int index) {
    List<String> listSubject = [];
    var listStringSubject = listJob[index].kyNang.split(',');
    resultGetSkills.data.listSkills.forEach((element) {
      for (int i = 0; i < listStringSubject.length; i++) {
        if (element.id == listStringSubject[i]) {
          listSubject.add(element.name);
        }
      }
    });
    return listSubject;
  }

  List<String> getSkillFreelancer(int index, int numElement) {
    List<String> listSubject = [];
    int a = numElement;
    var listStringSubject = listFreelancer[index].kyNang.split(',');
    resultGetSkills.data.listSkills.forEach((element) {
      for (int i = 0; i < listStringSubject.length; i++) {
        if (element.id == listStringSubject[i]) {
          listSubject.add(element.name);
        }
      }
    });
    listSubject.sort((a, b) => a.length.compareTo(b.length));
    for (int i = 0; i < listSubject.length; i++) {
      if (listSubject[i].length >= 7 && i < a) {
        ind.value = a;
        break;
      } else if (listSubject[i].length < 7 && i == a) {
        ind.value = a + 1;
        break;
      } else if (listSubject[i].length >= 7) {
        ind.value = i;
        break;
      }
    }
    for (int i = ind.value; i < listSubject.length; i++) {
      listSubject[i] = " ";
    }
    return listSubject;
  }

  List<String> getSkillJobPosted(int index) {
    List<String> listSubject = [];
    var listStringSubject = listCongViecDaDang[index].kyNangCv.split(',');
    resultGetSkills.data.listSkills.forEach((element) {
      for (int i = 0; i < listStringSubject.length; i++) {
        if (element.id == listStringSubject[i]) {
          listSubject.add(element.name);
        }
      }
    });
    return listSubject;
  }

// List<String> getSelectSkill(String idSkill, int numElement) {
//   List<String> skill = [];
//   int a = numElement;
//   if(idSkill.isEmpty) return[];
//   idSkill.split(',').forEach((element) {
//     skill.add(listSkills[int.tryParse(element)].name);
//   });
//   skill.sort((a, b) => a.length.compareTo(b.length));
//   for(int i =0; i < skill.length; i++){
//     if(skill[i].length >=7 && i < a) {
//       ind.value = a;
//       break;
//     }else if(skill[i].length <7 && i == a){
//       ind.value = a + 1;
//       break;
//     }else if(skill[i].length >= 7){
//       ind.value = i;
//       break;
//     }
//   }
//   for(int i = ind.value; i < skill.length; i++){
//     skill[i] = " ";
//   }
//   return skill;
// }
}
