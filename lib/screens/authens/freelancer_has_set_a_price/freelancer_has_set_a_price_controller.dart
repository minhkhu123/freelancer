import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_freelancer_has_set_a_price.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/shared/data/repositories/company_repositories.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class FreelancerHasSetAPriceController extends GetxController {
  CompanyRepositories _companyRepositories = CompanyRepositories();

  RxString messageError = ''.obs;
  List<DsDatgia> listDSDatGia = [];
  RxInt countLoadTime = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getDsDatGia(token: SpUtil.getString(ConstString.token));
  }

  void getDsDatGia({@required String token, int xemThem = 1}) async {
    ResultData rest = await _companyRepositories.getFreelancerHasSetAPrice(
        token: SpUtil.getString(ConstString.token), xemThem: xemThem);
    if (rest.result) {
      ResultGetFreelancerHasSetAPrice resultGetFreelancerHasSetAPrice =
          resultGetFreelancerHasSetAPriceFromJson(rest.data);
      if (resultGetFreelancerHasSetAPrice.data.result) {
        listDSDatGia.addAll(resultGetFreelancerHasSetAPrice.data.dsDatgia);
      } else {
        messageError.value = resultGetFreelancerHasSetAPrice.error.message;
      }
    } else {
      if (rest.code == 404)
        print("Lỗi 404");
      else if (rest.code == 401)
        print("Lỗi 401");
      else if (rest.code == 500)
        print("Lỗi 500");
      else if (rest.code == 505)
        print("Lỗi 404");
      else
        print("Lỗi");
    }
    update();
  }

  void acceptOrReject(DsDatgia element, {@required String token, @required String idDatGia, @required String chapNhan}) async{
    ResultData rest = await _companyRepositories.acceptOrReject(token: token, idDatGia: idDatGia, chapNhan: chapNhan);
    if(rest.result){
      ResultNotification resultNotification = resultNotificationFromJson(rest.data);
      String notification;
      if(resultNotification.data.result){
        notification = resultNotification.data.message;
      }else{
        notification = resultNotification.error.message;
      }
      Get.snackbar('Message', notification);
      listDSDatGia.remove(element);
      update();
    }else{
      if(rest.code == 404) print('Lỗi 404');
      else if(rest.code == 401) print('Lỗi 401');
      else if(rest.code == 500) print('Lỗi 500');
      else if(rest.code == 505) print('Lỗi 505');
      else print('Lỗi');
    }
  }
}
