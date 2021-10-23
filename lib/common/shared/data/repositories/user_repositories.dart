import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/shared/data/http/address.dart';
import 'package:freelancer_app/common/shared/data/http/api.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:freelancer_app/models/drop_list_model.dart';

class UserRepository {
  Future<ResultData> getProjectFreelancerIsDoing({@required String token, int loadTime}) async {
    Map<String, dynamic> body = {'token': token, 'load_time': loadTime};
    ResultData rest = await httpManager.netFetch(Address.PROJECT_FREELANCER_IS_DOING, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> getProjectFreelancerSave({@required String token, int loadTime}) async {
    Map<String, dynamic> body = {'token': token, 'load_time': loadTime};
    ResultData rest = await httpManager.netFetch(Address.PROJECT_FREELANCER_SAVED, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> deleteProjectFreelancerSave({@required String token, @required int idProject}) async {
    Map<String, dynamic> body = {'token': token, 'id_project': idProject};
    ResultData rest = await httpManager.netFetch(Address.DELETE_PROJECT_SAVED, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> getAllSkill() async {
    ResultData rest = await httpManager.netFetch(Address.GET_ALL_SKILLS, null, null, null);
    return rest;
  }

  Future<ResultData> updateSkillFreelancer({@required String token, @required String category, @required String skills}) async {
    Map<String, dynamic> body = {'token': token, 'category': category, 'skills': skills};
    ResultData rest = await httpManager.netFetch(Address.UPDATE_SKILLS, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> updateIntroduce({@required String token, @required String expWork, String introSelf}) async {
    Map<String, dynamic> body = {'token': token, 'exp_work': expWork, 'intro_self': introSelf};

    ResultData rest = await httpManager.netFetch(Address.UPDATE_INTRO_FREELANCER, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> updateJobDesired(
      {@required String token, String job, int desiredJob, int type, int desiredCity, int salaryType, String salary, int salaryDepend}) async {
    Map<String, dynamic> body = {
      'token': token,
      'job': job,
      'desired_job': desiredJob,
      'type': type,
      'desired_city': desiredCity,
      'salary_type': salaryType,
      'salary': salary,
      'salary_depend': salaryDepend
    };
    ResultData rest = await httpManager.netFetch(Address.UPDATE_DESIRED_JOB, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> freelancerInfo(String token) async {
    Map<String, dynamic> body = {
      'token': token,
    };
    ResultData rest = await httpManager.netFetch(Address.FREELANCER_INFOR, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> ntdInfo(String token) async {
    Map<String, dynamic> body = {
      'token': token,
    };
    ResultData rest = await httpManager.netFetch(Address.HIEN_THI_THONG_TIN_NTD, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> freelancerRattingJob({
    @required String token,
    int rateStar,
    int trangThai,
    int maViecLam,
  }) async {
    Map<String, dynamic> body = {
      'token': token,
      'rate_star': rateStar,
      'trang_thai': trangThai,
      'ma_viec_lam': maViecLam
    };
    return httpManager.netFetch(Address.FLC_DANH_GIA_DU_AN, body, null, Options(method: 'post'));
  }

  Future<ResultData> updateStatus({@required String token, @required String idDatGia, @required String trangThai}){
    Map<String, dynamic> body = {'token': token, 'id_dat_gia': idDatGia, 'trang_thai': trangThai};
    return httpManager.netFetch(Address.FLC_UPDATE_TRANG_THAI_JOB, body, null, Options(method: 'post'));
  }
}
