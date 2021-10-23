import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/shared/data/repositories/home_repositories.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_notify_candidate.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_notify_company.dart';
import 'package:sp_util/sp_util.dart';

class NotificationController extends GetxController {
  HomeRepositories _homeRepositories = HomeRepositories();
  NavigationController navigationController = Get.put(NavigationController());
  WaitLoginController waitLoginController = Get.put(WaitLoginController());

  List<ListNotifyCandidate> listNotifyCandidate = [];
  List<ListNotifyCompany> listNotifyCompany = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    waitLoginController.checkWhoUR.value ? getNotifyCandidate() : getNotifyCompany();
  }

  void getNotifyCandidate() async {
    String token = SpUtil.getString(ConstString.token);
    ResultData res = await _homeRepositories.getNotifyCandidate(token);
    ResultGetNotificationCandidate resultGetNotificationCandidate = resultGetNotificationCandidateFromJson(res.data);
    if (resultGetNotificationCandidate.data.result) {
      for (int i = 0; i < resultGetNotificationCandidate.data.listNotify.length; i++) {
        listNotifyCandidate.add(resultGetNotificationCandidate.data.listNotify[i]);
      }
    } else {
      Utils.showToast(resultGetNotificationCandidate.error.message);
    }
    update();
  }

  void deleteNotifyCandidate() async {
    String token = SpUtil.getString(ConstString.token);
    ResultData res = await _homeRepositories.deleteNotifyCandidate(token);
    ResultNotification resultNotification = resultNotificationFromJson(res.data);
    if (resultNotification.data.result) {
      listNotifyCandidate.clear();
      Utils.showToast(resultNotification.data.message);
    } else {
      Utils.showToast(resultNotification.error.message);
    }
    update();
  }

  void getNotifyCompany() async {
    String token = SpUtil.getString(ConstString.token);
    ResultData res = await _homeRepositories.getNotifyCompany(token);
    ResultGetNotificationCompany resultGetNotificationCompany = resultGetNotificationCompanyFromJson(res.data);
    if (resultGetNotificationCompany.data.result) {
      for (int i = 0; i < resultGetNotificationCompany.data.listNotify.length; i++) {
        listNotifyCompany.add(resultGetNotificationCompany.data.listNotify[i]);
      }
    } else {
      Utils.showToast(resultGetNotificationCompany.error.message);
    }
    update();
  }

  void deleteNotifyCompany() async {
    String token = SpUtil.getString(ConstString.token);
    ResultData res = await _homeRepositories.deleteNotifyCompany(token);
    ResultNotification resultNotification = resultNotificationFromJson(res.data);
    if (resultNotification.data.result) {
      listNotifyCompany.clear();
      Utils.showToast(resultNotification.data.message);
    } else {
      Utils.showToast(resultNotification.error.message);
    }
    update();
  }
}
