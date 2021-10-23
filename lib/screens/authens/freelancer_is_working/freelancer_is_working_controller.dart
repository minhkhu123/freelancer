import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/address.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_freelancer_working.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class FreelancerIsWorkingController extends GetxController {
  RxList<ListElement> _listResultGetFreelancerWorking = <ListElement>[].obs;
  List<String> trangThai = const ["Đang thực hiện", "Không hoàn thành", "Hoàn thành"];
  Map<double, String> _danhGia = {
    5: 'Xuất sắc',
    4: 'Tốt',
    3: 'Khá',
    2: 'Trung bình',
    1: 'Kém',
    0: 'Yếu'
  };
  RxList<String> idStatus = <String>[].obs;
  RxList<double> idStatusRate = <double>[].obs;
  RxInt _countLoadTime = 1.obs;
  RxString _message = ''.obs;

  RxList<ListElement> get listResultGetFreelancerWorking => _listResultGetFreelancerWorking;

  RxString get message => _message;

  Map<double, String> get danhGia => _danhGia;

  getFreelancerWorking({@required String token, int xemThem = 1}) async {
    ResultData rest = await UtilsData.companyRepositories.getHaveTokenAndLoadTime(Address.FREELANCER_DANG_LAM_VIEC, token: token, xemThem: xemThem);
      ResultGetFreelancerWorking resultGetFreelancerWorking = ResultGetFreelancerWorking.fromRawJson(rest.data);
      if (resultGetFreelancerWorking.data.result) {
        _listResultGetFreelancerWorking.addAll(resultGetFreelancerWorking.data.list);
        print('_listResultGetFreelancerWorking.length');
        print(_listResultGetFreelancerWorking.length);
      } else {
        _message.value = resultGetFreelancerWorking.error.message;
      }
    update();
  }

  updateStatus({@required String token, @required String idDatGia, @required String trangThai}) async {
    ResultData rest = await UtilsData.companyRepositories.updateStatus(token: token, idDatGia: idDatGia, trangThai: trangThai);
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
    update();
  }

  loadTime() {
    _countLoadTime.value++;
    getFreelancerWorking(token: SpUtil.getString(ConstString.token), xemThem: _countLoadTime.value);
  update();
  }

  getStatus(String item) => trangThai[int.parse(item)];

  onChangeStatus(value, int index) => idStatus[index] = trangThai.indexOf(value).toString();

  onChangeStatusRate(value, int index) => idStatusRate[index] = value;

  rattingStartWorking({
    @required String token,
    int maFlc,
    int maViecLam,
    int rateStar,
    int trangThai,
  }) async {
    ResultData rest = await UtilsData.companyRepositories.rattingStartWorking(
      token: token,
      rateStar: rateStar,
      trangThai: trangThai,
      maViecLam: maViecLam,
      maFlc: maFlc
    );
    if (rest.result) {
      ResultNotification resultNotification = resultNotificationFromJson(rest.data);
      String noti;
      if (resultNotification.data.result) {
        noti = resultNotification.data.message;
      } else {
        noti = resultNotification.error.message;
      }
      Get.snackbar('Message', noti);
    } else {
      if (rest.code != 200) print('Lỗi');
    }
    update();
  }

  void updateFreelancerWorking() {
    listResultGetFreelancerWorking.clear();
    getFreelancerWorking(token: SpUtil.getString(ConstString.token));
    idStatus = List.filled(_listResultGetFreelancerWorking.length, '').obs;
    idStatusRate = List.filled(_listResultGetFreelancerWorking.length, 10.0).obs;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await getFreelancerWorking(token: SpUtil.getString(ConstString.token));
    idStatus = List.filled(_listResultGetFreelancerWorking.length, '').obs;
    idStatusRate = List.filled(_listResultGetFreelancerWorking.length, 10.0).obs;
  }
}
