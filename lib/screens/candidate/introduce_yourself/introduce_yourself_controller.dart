
import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_infor_uv.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:get/get.dart';

class IntroduceYourselfController extends GetxController{
  UserInfor userInfo = UserInfor();

  DropListModel listExp = DropListModel(
      listItem: [
        OptionItem(id: 0, title: 'Chưa có kinh nghiệm'),
        OptionItem(id: 1, title: 'Dưới 1 năm'),
        OptionItem(id: 2, title: '1 năm'),
        OptionItem(id: 3, title: '2 năm'),
        OptionItem(id: 4, title: '3 năm'),
        OptionItem(id: 5, title: '4 năm'),
        OptionItem(id: 6, title: '5 năm'),
        OptionItem(id: 7, title: 'Trên 5 năm'),
      ]
  );

  OptionItem selectedExp = OptionItem(id: null, title: 'Chon kinh nghiệm');

  TextEditingController introduceController = TextEditingController();
  String get textIntro => introduceController.text;
  RxInt currentIndex = 0.obs;


  @override
  void onInit(){
    super.onInit();
    introduceController.addListener(() { });
    setUpInfo();
  }

  void setUpInfo() async{
    userInfo = await UtilsData.userInfo();
    introduceController.text = userInfo.gioiThieu;
    selectedExp = OptionItem(id: int.parse(userInfo.kinhNghiem), title: listExp.listItem[int.parse(userInfo.kinhNghiem)].title);
    update();
  }
  void changeSelected(OptionItem e){
    selectedExp = e;
  }

  void updateIntro({@required String token, @required String expWork, String introSelf}) async{
    if(expWork != null && selectedExp.id != null){
      ResultData rest = await UtilsData.userRepository.updateIntroduce(token: token, expWork: expWork, introSelf: introSelf);
      if(rest.result){
        ResultNotification resultNotification = resultNotificationFromJson(rest.data);
        String notification;
        if(resultNotification.data.result){
          notification = resultNotification.data.message;
        }else{
          notification = resultNotification.error.message;
        }
        Get.snackbar("Message", notification);
      }else{
        if(rest.code == 404) print('Lỗi 404');
        else if(rest.code == 401) print('Lỗi 401');
        else if(rest.code == 500) print('Lỗi 500');
        else if(rest.code == 505) print('Lỗi 505');
        else print('Lỗi');
      }
    }else Get.snackbar('Message', "Bạn cần chon kinh nghiệm làm việc");
  }


}
