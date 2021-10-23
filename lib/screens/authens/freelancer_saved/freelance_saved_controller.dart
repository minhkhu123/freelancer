import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/address.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_freelancer_saved.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_skill.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/shared/data/repositories/company_repositories.dart';
import 'package:freelancer_app/screens/authens/ongoing_project/ongoing_project_controller.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class FreelancerSavedController extends GetxController{
  CompanyRepositories _companyRepositories = CompanyRepositories();
  OnGoingProjectController controller = OnGoingProjectController();
  List<ListFlcSaved> listFreelancerSaved = [];
  RxString messageNotificationFreelancerSave = ''.obs;
  List<ListSkill> listSkill = [];
  RxInt countLoadTimeFreelancerSaved = 1.obs;



  @override
  void onInit() async{
    super.onInit();
    listSkill = await controller.getAllSkills();
    listFreelancerSaved.clear();
    getFreelancerSaved(token: SpUtil.getString(ConstString.token));
  }


  void getFreelancerSaved({@required String token, int xemThem = 1}) async{
    ResultData rest = await _companyRepositories.getHaveTokenAndLoadTime(Address.FREELANCER_DA_LUU, token: token, xemThem: xemThem);
    if(rest.result){
      ResultGetFreelancerSaved resultGetFreelancerSaved = resultGetFreelancerSavedFromJson(rest.data);
      if(resultGetFreelancerSaved.data.result){
        listFreelancerSaved.addAll(resultGetFreelancerSaved.data.listFlcSaved);
      }else{
        messageNotificationFreelancerSave.value = resultGetFreelancerSaved.error.message;
      }
    }else{
      if(rest.code == 404) print('Lỗi 404');
      else if(rest.code == 401) print('Lỗi 401');
      else if(rest.code == 505) print('Lỗi 505');
      else if(rest.code == 500) print('Lỗi 500');
      else print('Lỗi');
    }
    update();
  }

  void deleteSavedFreelancer({@required String token, @required int idFlc}) async{
    ResultData rest = await _companyRepositories.deleteSavedFreelancer(token: token, idFlc: idFlc);
    if(rest.result){
      ResultNotification resultNotification = resultNotificationFromJson(rest.data);
      String noti;
      if(resultNotification.data.result) noti = resultNotification.data.message;
      else noti = resultNotification.error.message;
      Get.snackbar('Message', noti);
    }else{
      if(rest.code != 200) print('Lỗi');
    }
    update();
  }

  deleteElement(ListFlcSaved item) => listFreelancerSaved.remove(item);
}