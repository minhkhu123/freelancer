import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/shared/data/http/address.dart';
import 'package:freelancer_app/common/shared/data/http/api.dart';
import 'package:freelancer_app/common/shared/data/http/result_data.dart';
import 'package:http_parser/http_parser.dart';

class AuthenticationRepositories {
  //Ung vien
  Future<ResultData> loginCandidate(String email, String password) async {
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    ResultData rest = await httpManager.netFetch(Address.LOGIN_CANDIDATE, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> registerCandidate(File imageAvatar, String name, int gender, String birth, String city, int district, String phone, String email,
      String password, String salaryType, String salary, int salaryDepend, String job, String category) async {
    Map<String, dynamic> body = {
      'avatar': imageAvatar != null
          ? await MultipartFile.fromFile(
              imageAvatar.path,
              filename: imageAvatar.path.split('/').last,
              contentType: new MediaType("image", "jpeg"),
            )
          : null,
      'name': name,
      'gender': gender,
      'birth': birth,
      'city': city,
      'district': district,
      'phone_number': phone,
      'email': email,
      'password': password,
      'salary_type': salaryType,
      'salary': salary,
      'salary_depend': salaryDepend,
      'nghe_nghiep': job,
      'category': category,
    };

    ResultData rest = await httpManager.netFetch(Address.SIGN_UP_CANDIDATE, body, null, Options(method: 'post'), isFormData: true);

    return rest;
  }

  Future<ResultData> confirmOTPUV(String otp, String token) async {
    Map<String, dynamic> body = {
      'otp': otp,
      'token': token,
    };
    ResultData rest = await httpManager.netFetch(Address.XAC_THUC_OTP_UV, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> resendOTPUV(String token) async {
    Map<String, dynamic> body = {
      'token': token,
    };
    ResultData rest = await httpManager.netFetch(Address.GUI_LAI_OTP_UV, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> forgotPasswordUV(String email) async {
    Map<String, dynamic> body = {
      'email': email,
    };
    ResultData rest = await httpManager.netFetch(Address.SEND_OTP_RESET_PASS_CANDIDATE, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> confirmOTPForgotPasswordUV(String token, String otp) async {
    Map<String, dynamic> body = {
      'token': token,
      'otp': otp,
    };
    ResultData rest = await httpManager.netFetch(Address.XAC_THUC_OTP_DAT_LAI_MK_UV, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> updatePasswordUV(String token, String newPass) async {
    Map<String, dynamic> body = {
      'token': token,
      'new_pwd': newPass,
    };
    ResultData rest = await httpManager.netFetch(Address.DAT_LAI_MK_UV, body, null, Options(method: 'post'));

    return rest;
  }

  // Nha tuyen dung

  Future<ResultData> loginCompany(String email, String password) async {
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    ResultData rest = await httpManager.netFetch(Address.LOGIN_COMPANY, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> registerCompany(
      File imageAvatar, String name, int gender, String birth, String city, int district, String phone, String email, String password) async {
    Map<String, dynamic> body = {
      'avatar': imageAvatar != null
          ? await MultipartFile.fromFile(
              imageAvatar.path,
              filename: imageAvatar.path.split('/').last,
              contentType: new MediaType("image", "jpeg"),
            )
          : null,
      'name': name,
      'gender': gender,
      'birth': birth,
      'city': city,
      'district': district,
      'phone_number': phone,
      'email': email,
      'password': password,
    };

    ResultData rest = await httpManager.netFetch(Address.SIGN_UP_COMPANY, body, null, Options(method: 'post'), isFormData: true);

    return rest;
  }

  Future<ResultData> getListCity() async {
    ResultData rest = await httpManager.netFetch(Address.GET_CITY, null, null, Options(method: 'get'));

    return rest;
  }

  Future<ResultData> getListDistrict(int city) async {
    Map<String, dynamic> body = {'city': city};

    ResultData rest = await httpManager.netFetch(Address.GET_DISTRICT, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> getListCategory() async {
    ResultData rest = await httpManager.netFetch(Address.GET_CATEGORY, null, null, Options(method: 'get'));

    return rest;
  }

  Future<ResultData> getListTagFromCategory(int category) async {
    Map<String, dynamic> body = {'category': category};
    ResultData rest = await httpManager.netFetch(Address.GET_TAG_FROM_CATEGORY, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> confirmOTPNTD(String otp, String token) async {
    Map<String, dynamic> body = {
      'otp': otp,
      'token': token,
    };
    ResultData rest = await httpManager.netFetch(Address.XAC_THUC_OTP_NTD, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> resendOTPNTD(String token) async {
    Map<String, dynamic> body = {
      'token': token,
    };
    ResultData rest = await httpManager.netFetch(Address.RESEND_EMAIL_COMPANY, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> forgotPasswordNTD(String email) async {
    Map<String, dynamic> body = {
      'email_ntd': email,
    };
    ResultData rest = await httpManager.netFetch(Address.QUEN_MAT_KHAU_NTD, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> confirmOTPForgotPasswordNTD(String token, String otp) async {
    Map<String, dynamic> body = {
      'token': token,
      'otp': otp,
    };
    ResultData rest = await httpManager.netFetch(Address.XAC_THUC_OTP_QUEN_MAT_KHAU_NTD, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> updatePasswordNTD(String token, String newPass) async {
    Map<String, dynamic> body = {
      'token': token,
      'mat_khau_moi': newPass,
    };
    ResultData rest = await httpManager.netFetch(Address.CAP_NHAT_MAT_KHAU_NTD, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> updateProfile(String url,String pathOldImage,
      {@required String token, File avatar, String fullName, int sex, String birthDay, int provin, int district}) async {
    String fileName = avatar.path != pathOldImage ? avatar.path.split('/').last : '';
    Map<String, dynamic> body = {
      'token': token,
      'avatar':
          avatar.path != pathOldImage ? await MultipartFile.fromFile(avatar.path, filename: fileName) : null,
      'full_name': fullName,
      'birth_day': birthDay,
      'sex': sex,
      'provin': provin,
      'district': district
    };
    ResultData rest = await httpManager.netFetch(url, body, null, Options(method: 'post'), isFormData: true);
    return rest;
  }

  Future<ResultData> getOnlyToken(String url, {@required String token}) async {
    Map<String, dynamic> body = {'token': token};
    ResultData rest = await httpManager.netFetch(url, body, null, Options(method: 'post'));
    return rest;
  }

  Future<ResultData> checkEmail(String email, int typeOfUser) async {
    Map<String, dynamic> body = {
      'email': email,
      'type_of_user': typeOfUser,
    };
    ResultData rest = await httpManager.netFetch(Address.CHECK_EMAIL, body, null, Options(method: 'post'));

    return rest;
  }

  Future<ResultData> checkPhoneNumber(String phone, int typeOfUser) async {
    Map<String, dynamic> body = {
      'phone_number': phone,
      'type_of_user': typeOfUser,
    };
    ResultData rest = await httpManager.netFetch(Address.CHECK_PHONE_NUMBER, body, null, Options(method: 'post'));

    return rest;
  }
}
