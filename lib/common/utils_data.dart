import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/http/address.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_category.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_city.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_data_by_project.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_infor_ntd.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_infor_uv.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_tag_from_category.dart';
import 'package:freelancer_app/common/shared/data/models/result_notification.dart';
import 'package:freelancer_app/common/shared/data/models/result_renew.dart';
import 'package:freelancer_app/common/shared/data/repositories/authen_repositories.dart';
import 'package:freelancer_app/common/shared/data/repositories/company_repositories.dart';
import 'package:freelancer_app/common/shared/data/repositories/home_repositories.dart';
import 'package:freelancer_app/common/shared/data/repositories/user_repositories.dart';
import 'package:freelancer_app/common/utils.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilsData {
  static AuthenticationRepositories authenticationRepositories =
      AuthenticationRepositories();
  static CompanyRepositories companyRepositories = CompanyRepositories();
  static HomeRepositories homeRepositories = HomeRepositories();
  static UserRepository userRepository = UserRepository();

  static Future<DropListModel> getTagFromCategory(int category) async {
    List<OptionItem> listTag = [];
    ResultData res =
        await authenticationRepositories.getListTagFromCategory(category);
    if (res.result) {
      ResultTagFromCategory resultTagFromCategory =
          resultTagFromCategoryFromJson(res.data);
      if (resultTagFromCategory.data.result) {
        listTag.addAll(resultTagFromCategory.data.listTag
            .map((e) => OptionItem(id: int.parse(e.id), title: e.name)));
      }
    } else {
      if (res.code != 200) print('Lỗi');
    }
    return DropListModel(listItem: listTag);
  }

  static String getNameFormat(String id) {
    Map<String, String> hinhThuc = {'1': 'Dự án', '2': 'Bán thời gian'};
    return hinhThuc[id];
  }

  static Future<DataPost> getDataPost(String url,
      {@required String token, @required int maViecLam}) async {
    DataPost dataPost = DataPost();
    ResultData rest = await companyRepositories.getDataByProject(url,
        token: token, maViecLam: maViecLam);
    if (rest.result) {
      ResultGetDataByProject resultGetDataByProject =
          resultGetDataByProjectFromJson(rest.data);
      if (resultGetDataByProject.data.result) {
        dataPost = resultGetDataByProject.data.dataPost;
      }
    } else {
      if (rest.code != 200) print('Lỗi');
    }
    return dataPost;
  }

  static Future<DropListModel> getCity() async {
    ResultData rest = await authenticationRepositories.getListCity();
    List<OptionItem> list = [];
    if (rest.result) {
      ResultGetCity resultGetCity = resultGetCityFromJson(rest.data);
      if (resultGetCity.data.result) {
        list.addAll(resultGetCity.data.listCity
            .map((e) => OptionItem(id: int.parse(e.id), title: e.name)));
      }
    } else {
      if (rest.code != 200) print("Lỗi");
    }
    return DropListModel(listItem: list);
  }

  static void updateWorkByProject(String oldPathLogo, String oldPathFile,
      {@required String token,
      File logo,
      @required String maViec,
      @required String tenCongViec,
      @required String linhVuc,
      @required String maKyNang,
      @required String hinhThuc,
      @required String noiLamViec,
      @required String kinhNghiem,
      @required String noiDungViec,
      @required File file,
      //Cố định: value = 1; Ước lượng: value = 2
      @required int theLoaiChiPhi,
      //Chọn hình thức trả lương theo ngày/tuần/tháng/năm, giá trị tương ứng 1/2/3/4
      @required int chiPhiTheoGiDo,
      //Nếu là lương cố định thì gửi dạng '10000'. Nếu là ước lượng thì gửi '10000,20000'
      @required String chiPhi,
      @required String ngayBdDatGia,
      @required String ngayKtDatGia,
      @required String ngayBdLamViec,
      @required String ngayKtLamViec,
      @required int loaiViecLam}) async {
    ResultData rest = await companyRepositories.updateWorkByProject(
       oldPathLogo,
        oldPathFile,
        token: token,
        logo: logo,
        maViec: maViec,
        tenCongViec: tenCongViec,
        linhVuc: linhVuc,
        maKyNang: maKyNang,
        hinhThuc: hinhThuc,
        noiLamViec: noiLamViec,
        kinhNghiem: kinhNghiem,
        noiDungViec: noiDungViec,
        file: file,
        theLoaiChiPhi: theLoaiChiPhi,
        chiPhiTheoGiDo: chiPhiTheoGiDo,
        chiPhi: chiPhi,
        ngayBdDatGia: ngayBdDatGia,
        ngayKtDatGia: ngayKtDatGia,
        ngayBdLamViec: ngayBdLamViec,
        ngayKtLamViec: ngayKtLamViec,
        loaiViecLam: loaiViecLam);
    if (rest.result) {
      ResultNotification resultNotification =
          resultNotificationFromJson(rest.data);
      String notification;
      if (resultNotification.data.result) {
        notification = resultNotification.data.message;
      } else
        notification = resultNotification.error.message;
      Get.snackbar('Message', notification);
    } else {
      if (rest.code != 200) print('Lỗi');
    }
  }

  static Future<List<ListCategory>> getCategory() async {
    List<ListCategory> list = [];
    ResultData rest = await authenticationRepositories.getListCategory();
    if (rest.result) {
      ResultGetCategory resultGetCategory =
          resultGetCategoryFromJson(rest.data);
      if (resultGetCategory.data.result)
        list.addAll(resultGetCategory.data.listCategory);
    } else {
      if (rest.code != 200) print('Lỗi');
    }
    return list;
  }

  static Future<UserInfor> userInfo() async {
    ResultData rest = await authenticationRepositories.getOnlyToken(
        Address.FREELANCER_INFOR,
        token: SpUtil.getString(ConstString.token));
    if (rest.result) {
      ResultGetInforFreelancer resultGetInforFreelancer =
          ResultGetInforFreelancer.fromRawJson(rest.data);
      if (resultGetInforFreelancer.data.result)
        return resultGetInforFreelancer.data.userInfor;
    } else {
      if (rest.code != 200) print('Lỗi');
    }
    return UserInfor();
  }

  static Future<EmployerInfor> employerInfor() async {
    ResultData rest = await authenticationRepositories.getOnlyToken(
        Address.HIEN_THI_THONG_TIN_NTD,
        token: SpUtil.getString(ConstString.token));
    if (rest.result) {
      ResultGetInforNtd resultGetInforNtd =
          resultGetInforNtdFromJson(rest.data);
      if (resultGetInforNtd.data.result)
        return resultGetInforNtd.data.employerInfor;
    } else {
      if (rest.code != 200) print('Lỗi');
    }
    return EmployerInfor();
  }

  static Future<void> renew({@required String token, @required String idViecLam}) async{
    ResultData rest = await companyRepositories.renew(token: token, idViecLam: idViecLam);
    if(rest.result){
      ResultRenew renew = ResultRenew.fromRawJson(rest.data);
      String noti;
      if(renew.result){
        noti = "Làm mới thành công";
      }else  noti = 'Làm mới không thành công';

      Get.snackbar('Message', noti);
    }else{
      if(rest.code != 200) print('Lỗi');
    }
  }

  static launchURL(String url) async{
    await launch(url);
  }

  static checkFileSize(File file){
    return (file.lengthSync() ~/ 1024) ~/ 1024;
  }

  static Future<File> compressionFile(File file) async{
    final lastIndex = file.path.lastIndexOf(RegExp(r'.jpg'));
    final splitted = file.path.substring(0, (lastIndex));
    final outPath = "${splitted}_out${file.path.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 94
    );
    return result;
  }

  static launchTelUrl(String numPhone) async{
    String url = 'tel:' + numPhone;
    if(await canLaunch(url)){
      await launch(url);
    }else Utils.showToast("Không gọi được");
  }

  static timeStampToDateTime(String time){
    DateFormat format = DateFormat('dd-MM-yyyy');
    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(time) * 1000);
    return format.format(date);
  }
}
