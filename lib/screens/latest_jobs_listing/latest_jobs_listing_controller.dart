
import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/address.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_freelancer_set_latest_sprice.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_latest_job_listing.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';

class LatestJobsListingController extends GetxController{
  var _format = DateFormat('dd-MM-yyyy');
  List<ListElement> listLatestJobs = [];
  List<DsDatgia> listSetLatestPrice = [];
  String messageNotificationLatestJobs = '';
  String messageNotificationLatestPrice = '';
  RxInt countLoadTimeLatestJobs = 1.obs;
  RxInt countLoadTimeLatestPrice = 1.obs;
  List<DsDatgia> listDSDatGia = [];

  @override
  void onInit() {
    super.onInit();
    getLatestJobsListing(token: SpUtil.getString(ConstString.token));
    getFreelanceSetLatestPrice(token: SpUtil.getString(ConstString.token));
  }

  void getLatestJobsListing({@required String token , int xemThem = 1}) async{
    ResultData rest = await UtilsData.companyRepositories.getHaveTokenAndLoadTime(Address.DANH_SACH_VIEC_LAM_MOI_NHAT, token: SpUtil.getString(ConstString.token), xemThem: xemThem);
    if(rest.result){
      ResultGetLatestJobsListing resultGetLatestJobsListing = resultGetLatestJobsListingFromJson(rest.data);
      if(resultGetLatestJobsListing.data.result){
        resultGetLatestJobsListing.data.list.forEach((element) {
          DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(element.hanCuoiDatGia) * 1000);
          element.hanCuoiDatGia = _format.format(date);
          listLatestJobs.add(element);
        });
        messageNotificationLatestJobs = '';
      }else{
        messageNotificationLatestJobs = resultGetLatestJobsListing.error.message;
      }
    }else{
      if(rest.code != 200) print("Lỗi");
    }
    update();
  }
  void getFreelanceSetLatestPrice({@required String token, int xemThem = 1}) async{
    ResultData rest = await UtilsData.companyRepositories.getHaveTokenAndLoadTime(Address.FREELANCER_DAT_GIA_MOI_NHAT, token: token, xemThem: xemThem);
    if(rest.result){
      ResultGetFreelancerSetLatestPrice resultGetFreelancerSetLatestPrice = ResultGetFreelancerSetLatestPrice.fromRawJson(rest.data);
      if(resultGetFreelancerSetLatestPrice.data.result){
        listSetLatestPrice.addAll(resultGetFreelancerSetLatestPrice.data.dsDatgia);
      }else{
        messageNotificationLatestPrice = resultGetFreelancerSetLatestPrice.error.message;
      }

    }else{
      if(rest.code != 200) print('Lỗi');
    }
    update();
  }
  void acceptOrReject(DsDatgia element, {@required String token, @required String idDatGia, @required String chapNhan}) async{
    ResultData rest = await UtilsData.companyRepositories.acceptOrReject(token: token, idDatGia: idDatGia, chapNhan: chapNhan);
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