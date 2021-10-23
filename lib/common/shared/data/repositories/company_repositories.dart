import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/shared/data/http/address.dart';
import 'package:freelancer_app/common/shared/data/http/api.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';

class CompanyRepositories {
  Future<ResultData> getPostedNew({
    @required String token,
    int xemThem,
  }) async {
    Map<String, dynamic> body = {"token": token, "xemThem": xemThem};

    ResultData rest = await httpManager.netFetch(Address.TIN_DA_DANG, body, null, Options(method: "post"));
    return rest;
  }

  Future<ResultData> getFreelancerHasSetAPrice({@required String token, int xemThem}) async {
    Map<String, dynamic> body = {'token': token, 'xemThem': xemThem};

    ResultData rest = await httpManager.netFetch(Address.FREELANCER_DA_DAT_GIA, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> changePW(String url, {@required String token, String oldPW, String newPW}) async {
    Map<String, dynamic> body = {'token': token, 'old_pwd': oldPW, 'new_pwd': newPW};
    ResultData rest = await httpManager.netFetch(url, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> getHaveTokenAndLoadTime(String url, {@required String token, int xemThem}) async {
    Map<String, dynamic> body = {'token': token, 'xemThem': xemThem};
    ResultData rest = await httpManager.netFetch(url, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> updateWorkByProject(String oldPathLogo, String oldPathFile,
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
      //Để dạng int. value = 1 nếu là sửa việc theo dự án; value = 2 nếu là sửa việc bán thời gian
      @required int loaiViecLam}) async {
    String fileNameLogo = logo.path != oldPathLogo? logo.path.split('/').last : '';
    String fileName = file.path != oldPathFile ? file.path.split('/').last : '';
    Map<String, dynamic> body = {
      'token': token,
      'logo': logo.path != oldPathLogo ? await MultipartFile.fromFile(logo.path, filename: fileNameLogo) :  null,
      'ma_viec': maViec,
      'ten_cong_viec': tenCongViec,
      'linh_vuc': linhVuc,
      'ma_ky_nang': maKyNang,
      'hinh_thuc': hinhThuc,
      'noi_lam_viec': noiLamViec,
      'kinh_nghiem': kinhNghiem,
      'noi_dung_viec': noiDungViec,
      'file': file.path != oldPathFile? await MultipartFile.fromFile(file.path, filename: fileName) : null,
      'the_loai_chi_phi': theLoaiChiPhi,
      'chi_phi_theo_gi_do': chiPhiTheoGiDo,
      'chi_phi': chiPhi,
      'ngay_bd_dat_gia': ngayBdDatGia,
      'ngay_kt_dat_gia': ngayKtDatGia,
      'ngay_bd_lam_viec': ngayBdLamViec,
      'ngay_kt_lam_viec': ngayKtLamViec,
      'loai_viec_lam': loaiViecLam
    };
    ResultData rest = await httpManager.netFetch(Address.SUA_VIEC, body, null, Options(method: 'post'), isFormData: true);
    return rest;
  }

  Future<ResultData> getDataByProject(String url, {@required String token, @required int maViecLam}) async {
    Map<String, dynamic> body = {'token': token, 'ma_viec_lam': maViecLam};
    ResultData rest = await httpManager.netFetch(url, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> acceptOrReject({@required String token, @required String idDatGia, @required String chapNhan}) async {
    Map<String, dynamic> body = {'token': token, 'idDatGia': idDatGia, 'chapNhan': chapNhan};
    ResultData rest = await httpManager.netFetch(Address.CHAP_NHAN_TU_CHOI_DAT_GIA_CUA_FREELANCER, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> renew({@required String token, @required String idViecLam}) async {
    Map<String, dynamic> body = {'token': token, 'id_viec_lam': idViecLam};
    ResultData rest = await httpManager.netFetch(Address.RENEW, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> updateStatus({@required String token, @required String idDatGia, @required String trangThai}) async {
    Map<String, dynamic> body = {'token': token, 'idDatGia': idDatGia, 'trangThai': trangThai};
    ResultData rest = await httpManager.netFetch(Address.CAP_NHAT_TRANG_THAI_FREELANCER_DANG_LAM_VIEC, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> rattingStartWorking({
    @required String token,
    int maFlc,
    int maViecLam,
    int rateStar,
    int trangThai
  }) async {
    Map<String, dynamic> body = {
      'token': token,
      'ma_flc': maFlc,
      'rate_star': rateStar,
      'trang_thai': trangThai,
      'ma_viec_lam': maViecLam
    };
    return httpManager.netFetch(Address.DANH_GIA_FLC_DANG_LAM_VIEC, body, null, Options(method: 'post'));
  }

  Future<ResultData> updateFileProject({@required String token, @required String projectName, File projectFile}) async {
    String fileName = projectFile.path.isNotEmpty ? projectFile.path.split('/').last : '';
    Map<String, dynamic> body = {
      'token': token,
      'project_name': projectName,
      'project_file': projectFile.path.isNotEmpty ? await MultipartFile.fromFile(projectFile.path, filename: fileName) : null
    };
    return httpManager.netFetch(Address.UPLOAD_FILE_PROJECT, body, null, Options(method: 'post'), isFormData: true);
  }

  Future<ResultData> deleteSavedFreelancer({@required String token, @required int idFlc}){
    Map<String, dynamic> body = {
      'token': token,
      'id_flc': idFlc
    };
    return httpManager.netFetch(Address.Xoa_Ung_Vien_Da_Luu, body, null, Options(method: 'post'));
  }

  Future<ResultData> checkOldPassNTD(String token, String passwordHT) async {
    Map<String, dynamic> body = {
      'token': token,
      'old_pwd': passwordHT,
    };
    ResultData rest = await httpManager.netFetch(Address.CHECK_OLD_PWD_NTD, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> checkOldPassFLC(String token, String passwordHT) async {
    Map<String, dynamic> body = {
      'token': token,
      'old_pwd': passwordHT,
    };
    ResultData rest = await httpManager.netFetch(Address.CHECK_OLD_PWD_FLC, body, null, Options(method: 'post'));

    return rest;
  }
}
