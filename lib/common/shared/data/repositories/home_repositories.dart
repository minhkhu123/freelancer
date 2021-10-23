import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freelancer_app/common/shared/data/http/address.dart';
import 'package:freelancer_app/common/shared/data/http/api.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:http_parser/http_parser.dart';

class HomeRepositories {
  //Ung vien
  Future<ResultData> listJobProjectHome() async {
    ResultData rest = await httpManager.netFetch(Address.LIST_JOB_PROJECT_INDEX, null, null, Options(method: 'get'));

    return rest;
  }

  Future<ResultData> listJobPartimeHome() async {
    ResultData rest = await httpManager.netFetch(Address.LIST_JOB_PARTIME_INDEX, null, null, Options(method: 'get'));

    return rest;
  }

  Future<ResultData> listJob(String search, int tinhThanh, int nganhNghe, int kyNang, int loaiViecLam, int loadtime) async {
    Map<String, dynamic> body = {
      'keyword': search,
      'tinh_thanh': tinhThanh,
      'nganh_nghe': nganhNghe,
      'ky_nang': kyNang,
      'loai_viec_lam': loaiViecLam,
      'xemThem': loadtime,
    };
    ResultData rest = await httpManager.netFetch(Address.LIST_JOB, body, null, Options(method: 'post'));

    return rest;
  }

  //NTD
  Future<ResultData> listJobLatestHome(String token) async {
    ResultData rest = await httpManager.netFetch(Address.listFreelancerLatestIndex(token), null, null, Options(method: 'get'));

    return rest;
  }

  Future<ResultData> listJobOutstandingHome(String token) async {
    ResultData rest = await httpManager.netFetch(Address.listFreelancerOutstandingIndex(token), null, null, Options(method: 'get'));

    return rest;
  }

  Future<ResultData> listFreelancer(
      String token, String search, int city, int category, int skills, int typeOfWorking, int orderByValue, int loadtime) async {
    Map<String, dynamic> body = {
      'token': token,
      'keyword': search,
      'city': city,
      'category': category,
      'skills': skills,
      'typeofworking': typeOfWorking,
      'order_by_value': orderByValue,
      'xemThem': loadtime,
    };
    ResultData rest = await httpManager.netFetch(Address.LIST_FREELANCER, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> saveProject(String token, int idProject) async {
    Map<String, dynamic> body = {
      'token': token,
      'id_project': idProject,
    };
    ResultData rest = await httpManager.netFetch(Address.FREELANCER_SAVE_PROJECT, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> dealSalary(String token, int idProject, String salaryWant, String yourEmail) async {
    Map<String, dynamic> body = {
      'token': token,
      'id_project': idProject,
      'luong_mong_muon': salaryWant,
      'email_add': yourEmail,
    };
    ResultData rest = await httpManager.netFetch(Address.FREELANCER_DAT_GIA, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> detailJob(String token, String maViec) async {
    Map<String, dynamic> body = {
      'token': token,
      'ma_viec': maViec,
    };
    ResultData rest = await httpManager.netFetch(Address.CHI_TIET_VIEC_LAM, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> detailFreelancer(int idFreelancer, String token) async {
    Map<String, dynamic> body = {
      'id_flc': idFreelancer,
      'token': token,
    };
    ResultData rest = await httpManager.netFetch(Address.FREELANCER_DETAILS, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> saveFreelancer(String token, String idFreelancer) async {
    Map<String, dynamic> body = {
      'token': token,
      'ma_flc': idFreelancer,
    };
    ResultData rest = await httpManager.netFetch(Address.LUU_FREELANCER, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> jobPosted(int mantd, int xemThem) async {
    Map<String, dynamic> body = {
      'ma_ntd': mantd,
      'xemThem': xemThem,
    };
    ResultData rest = await httpManager.netFetch(Address.VIEC_LAM_DA_DANG, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> loadMoreFreelancerDeal(int maViec, int xemThem) async {
    Map<String, dynamic> body = {
      'ma_viec': maViec,
      'xemThem': xemThem,
    };
    ResultData rest = await httpManager.netFetch(Address.XEM_THEM_UV_DAT_GIA_CUA_VIEC_LAM, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> postJob(
    String token,
    File logo,
    String nameCV,
    int linhVuc,
    int maKyNang,
    int hinhThuc,
    int noiLamViec,
    int kinhNghiem,
    String noiDungViec,
    File file,
    int theLoaiChiPhi,
    int chiPhiTheoGiDo,
    String chiPhi,
    String ngayBDDatGia,
    String ngayKTDatGia,
    String ngayBDLamViec,
    String ngayKTLamViec,
    int loaiViecLam,
  ) async {
    Map<String, dynamic> body = {
      'token': token,
      'logo': logo != null
          ? await MultipartFile.fromFile(
              logo.path,
              filename: logo.path.split('/').last,
              contentType: new MediaType("image", "jpeg"),
            )
          : null,
      'ten_cong_viec': nameCV,
      'linh_vuc': linhVuc,
      'ma_ky_nang': maKyNang,
      'hinh_thuc': hinhThuc,
      'noi_lam_viec': noiLamViec,
      'kinh_nghiem': kinhNghiem,
      'noi_dung_viec': noiDungViec,
      'file': file,
      'the_loai_chi_phi': theLoaiChiPhi,
      'chi_phi_theo_gi_do': chiPhiTheoGiDo,
      'chi_phi': chiPhi,
      'ngay_bd_dat_gia': ngayBDDatGia,
      'ngay_kt_dat_gia': ngayKTDatGia,
      'ngay_bd_lam_viec': ngayBDLamViec,
      'ngay_kt_lam_viec': ngayKTLamViec,
      'loai_viec_lam': loaiViecLam,
    };
    ResultData rest = await httpManager.netFetch(Address.DANG_VIEC, body, null, Options(method: 'post'), isFormData: true);

    return rest;
  }

  Future<ResultData> getNotifyCandidate(String token) async {
    Map<String, dynamic> body = {
      'token': token,
    };
    ResultData rest = await httpManager.netFetch(Address.GET_NOTIFY_CADIDATE, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> deleteNotifyCandidate(String token) async {
    Map<String, dynamic> body = {
      'token': token,
    };
    ResultData rest = await httpManager.netFetch(Address.XEM_THEM_UV_DAT_GIA_CUA_VIEC_LAM, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> getNotifyCompany(String token) async {
    Map<String, dynamic> body = {
      'token': token,
    };
    ResultData rest = await httpManager.netFetch(Address.XEM_THEM_UV_DAT_GIA_CUA_VIEC_LAM, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> deleteNotifyCompany(String token) async {
    Map<String, dynamic> body = {
      'token': token,
    };
    ResultData rest = await httpManager.netFetch(Address.XEM_THEM_UV_DAT_GIA_CUA_VIEC_LAM, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> minusPointContact(String token, String idFlc) async {
    Map<String, dynamic> body = {
      'token': token,
      'id_flc': idFlc,
    };
    ResultData rest = await httpManager.netFetch(Address.TRU_DIEM_XEM_TT_FLC_CUA_NTD, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> getAllSkills() async {
    ResultData rest = await httpManager.netFetch(Address.GET_ALL_SKILLS, null, null, Options(method: 'get'));

    return rest;
  }
}
