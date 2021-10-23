import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_project_freelancer_is_doing.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_project_freelancer_save.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_skill.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/shared/data/repositories/user_repositories.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:freelancer_app/widgets/dialog_loading.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class OnGoingProjectController extends GetxController {
  UserRepository _userRepository = UserRepository();
  List<ListJob> listJob = [];
  List<ListProjectSaved> listProjectSave = [];
  var checkOnGoingProject = false;
  List<ListSkill> listSkills = [];
  int ind = 0;
  RxString _messageListJobError = ''.obs;
  RxString _messageListProjectSaveError = ''.obs;

  RxString get messageListJobError => _messageListJobError;
  RxString get messageListProjectSaveError => _messageListProjectSaveError;
  RxInt _countLoadTimeListJob = 1.obs;
  RxInt _countLoadTimeSaveProject = 1.obs;

  ResultGetSkills skills = ResultGetSkills();

  RxList<String> _idStatus = <String>[].obs;
  RxList<double> _idStatusRate = <double>[].obs;

  RxList<String> get idStatus => _idStatus;
  RxList<double> get idStatusRate => _idStatusRate;

  getStatus(String item) => trangThai[int.parse(item)];

  onChangeStatus(value, int index) => _idStatus[index] = trangThai.indexOf(value).toString();
  onChangeStatusRate(value, int index) => _idStatusRate[index] = value;

  List<String> trangThai = const ["Đang thực hiện", "Không hoàn thành", "Hoàn thành"];

  Map<double, String> _danhGia = {
    5: 'Xuất sắc',
    4: 'Tốt',
    3: 'Khá',
    2: 'Trung bình',
    1: 'Kém',
    0: 'Yếu'
  };

  Map<double, String> get danhGia => _danhGia;


  @override
  void onInit() async {
    super.onInit();
    listSkills = await getAllSkills();

  }

  @override
  void onClose() {
    super.onClose();
  }

  void getProjectFreelancerIsDoing({String token, int loadTime = 1}) async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    ResultData rest = await _userRepository.getProjectFreelancerIsDoing(
        token: token, loadTime: loadTime);
    if (rest.result) {
      ResultGetProjectFreelancerIsDoing resultGetProjectFreelancerIsDoing =
          resultGetProjectFreelancerIsDoingFromJson(rest.data);
      if (resultGetProjectFreelancerIsDoing.data.result) {
        listJob.addAll(resultGetProjectFreelancerIsDoing.data.listJob);
        _idStatus = List.filled(listJob.length, '').obs;
        _idStatusRate = List.filled(listJob.length, 10.0).obs;
      }else{
        _messageListJobError.value = resultGetProjectFreelancerIsDoing.error.message;
      }
      Get.back();
    } else {
      if (rest.code == 404)
        print("Lỗi 404");
      else if (rest.code == 401)
        print("Lỗi 401");
      else if (rest.code == 500)
        print("Lỗi 500");
      else if (rest.code == 505)
        print("Lỗi 505");
      else
        print("Lỗi");
      Get.back();
    }
    update();
  }

  Future<void> getProjectFreelanceSave(
      {@required String token, int loadTime = 1}) async {
    await Future.delayed(Duration(milliseconds: 1));
    Get.dialog(DialogLoading());
    ResultData rest = await _userRepository.getProjectFreelancerSave(
        token: token, loadTime: loadTime);
    if (rest.result) {
      ResultGetProjectFreelancerSave resultGetProjectFreelancerSave = resultGetProjectFreelancerSaveFromJson(rest.data);
      if (resultGetProjectFreelancerSave.data.result) {
        listProjectSave.addAll(resultGetProjectFreelancerSave.data.listProjectSaved);
      } else {
        Utils.showToast(resultGetProjectFreelancerSave.error.message);
      }
      Get.back();
      update();
    } else {
      if (rest.code == 404)
        print("Lỗi 404");
      else if (rest.code == 401)
        print("Lỗi 401");
      else if (rest.code == 500)
        print("Lỗi 500");
      else if (rest.code == 505)
        print("Lỗi 505");
      else
        print("Lỗi");
      Get.back();
    }
    update();
  }

  void deleteProjectSave(
      {@required String token, @required int idProject}) async {
    ResultData rest = await _userRepository.deleteProjectFreelancerSave(
        token: token, idProject: idProject);
    if (rest.result) {
      ResultNotification notification = resultNotificationFromJson(rest.data);
      String message;
      if (notification.data.result) {
        message = notification.data.message;
      } else {
        message = notification.error.message;
      }
      listProjectSave.clear();
      Get.back();
      Get.snackbar("Message", message);
    } else {
      if (rest.code == 404)
        print("Lỗi 404");
      else if (rest.code == 401)
        print("Lỗi 401");
      else if (rest.code == 500)
        print("Lỗi 500");
      else if (rest.code == 505)
        print("Lỗi 505");
      else
        print("Lỗi");
    }
    getProjectFreelanceSave(token: token);
    update();
  }

  Future<List<ListSkill>> getAllSkills() async {
    ResultData rest = await _userRepository.getAllSkill();
    if (rest.result) {
      skills = resultGetSkillsFromJson(rest.data);
      if (skills.data.result) {
        return skills.data.listSkills;
      }
      return [];
    } else {
      if (rest.code == 404)
        print("Lỗi 404");
      else if (rest.code == 401)
        print("Lỗi 401");
      else if (rest.code == 500)
        print("Lỗi 500");
      else if (rest.code == 505)
        print("Lỗi 505");
      else
        print("Lỗi");
    }
    return [];
  }

  String getSkill(String idSkill) {
    String skill = '';
    if (idSkill.isEmpty) return skill;
    idSkill.split(',').forEach((element) {
      listSkills.forEach((item) {
        if (element == item.id) {
          skill = item.name;
        }
      });
    });
    return skill;
  }

  List<String> getSelectSkill(int numElement, String idSkill) {
    List<String> listSubject = [];
    int a = numElement;
    if(idSkill.isEmpty) return listSubject;
    var listStringSubject = idSkill.split(',');
    idSkill.split(',').forEach((element) {
        listSkills.forEach((item) {
          if(element == item.id){
            listSubject.add(item.name);
          }
        });
      });
    listSubject.sort((a, b) => a.length.compareTo(b.length));
    for (int i = 0; i < listSubject.length; i++) {
      if (listSubject[i].length >= 7 && i < a) {
        ind = a;
        break;
      } else if (listSubject[i].length < 7 && i == a) {
        ind = a + 1;
        break;
      } else if (listSubject[i].length >= 7) {
        ind = i;
        break;
      }
    }
    for (int i = ind; i < listSubject.length; i++) {
      listSubject[i] = " ";
    }
    return listSubject;
    /**
     * Cách tính bên trên xử lý cứng phần tử trả về
     * Cách tính bên dưới là xử lý động
     * */
    // List<String> skill = [];
    // int a = 3;
    // if(idSkill.isEmpty) return[];
    // idSkill.split(',').forEach((element) {
    //   listSkills.forEach((item) {
    //     if(element == item.id){
    //       skill.add(item.name);
    //     }
    //   });
    // });
    // skill.sort((a, b) => a.length.compareTo(b.length));
    // for(int i =0; i < skill.length; i++){
    //   if(skill[i].length >=7 ) {
    //     a = i;
    //     break;
    //   }
    // }
    // for(int i = a + ((a <= 2)? 2: 1); i < skill.length; i++){
    //   skill[i] = " ";
    // }
    // ind += ((a <= 2)? 3: 1);
    // update();
    // return skill;
  }
  
  loadTimeListJob() {
    _countLoadTimeListJob.value++;
    getProjectFreelancerIsDoing(token: SpUtil.getString(ConstString.token), loadTime: _countLoadTimeListJob.value);
    update();
  }
  
  loadTimeSavedProject() {
    _countLoadTimeSaveProject.value++;
    getProjectFreelanceSave(token: SpUtil.getString(ConstString.token), loadTime: _countLoadTimeSaveProject.value);
    update();
  }

  updateStatus({@required String token, @required String idDatGia, @required String trangThai}) async {
    ResultData rest = await UtilsData.userRepository.updateStatus(token: token, idDatGia: idDatGia, trangThai: trangThai);
    if (rest.result) {
      ResultNotification resultNotification = resultNotificationFromJson(rest.data);
      String noti;
      if (resultNotification.data.result)
        noti = resultNotification.data.message;
      else
        noti = resultNotification.error.message;
      Get.snackbar('Message', noti);
    } else {
      if (rest.code != 200) print('Lỗi');
    }
  }

  freelancerRattingStar({
    @required String token,
    int rateStar,
    int trangThai,
    int maViecLam,
  }) async {
    ResultData rest = await UtilsData.userRepository.freelancerRattingJob(
      token: token,
      rateStar: rateStar,
      trangThai: trangThai,
      maViecLam: maViecLam,
    );
    if(rest.result){
      ResultNotification resultNotification = resultNotificationFromJson(rest.data);
      String noti;
      if(resultNotification.data.result){
        noti = resultNotification.data.message;
      }else{
        noti = resultNotification.error.message;
      }
      Get.snackbar('Message', noti);
    }else{
      if(rest.code != 200) print('Lỗi');
    }
  }
}
