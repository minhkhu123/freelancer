import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_data_by_project.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';

class PostJobsByProjectController extends GetxController {
  final _formatDate = DateFormat("dd-MM-yyyy");
  final _formatNumber = NumberFormat('#,###');

  DataPost dataPost;

  PostJobsByProjectController({this.dataPost});

  DropListModel listRecruitmentFieldModel = DropListModel(listItem: []);
  OptionItem optionItemRecruitmentFieldSelected = OptionItem(id: null, title: "Chọn lĩnh vực");

  DropListModel listModelSkill = DropListModel(listItem: []);
  OptionItem optionItemSelectedSkill = OptionItem(id: null, title: 'Chọn kỹ năng');

  DropListModel listModelWorkForm = DropListModel(listItem: [
    OptionItem(id: 1, title: "Toàn thời gian cố định"),
    OptionItem(id: 2, title: "Toàn thời gian tạm thời"),
    OptionItem(id: 3, title: "Bán thời gian"),
    OptionItem(id: 4, title: "Bán thời gian tạm thời"),
    OptionItem(id: 5, title: "Hợp đồng"),
    OptionItem(id: 6, title: "Khác"),
  ]);
  OptionItem optionItemWorkForm = OptionItem(id: null, title: "Chọn hình thức");

  DropListModel listExp = DropListModel(listItem: [
    OptionItem(id: 0, title: 'Chưa có kinh nghiệm'),
    OptionItem(id: 1, title: 'Dưới 1 năm'),
    OptionItem(id: 2, title: '1 năm'),
    OptionItem(id: 3, title: '2 năm'),
    OptionItem(id: 4, title: '3 năm'),
    OptionItem(id: 5, title: '4 năm'),
    OptionItem(id: 6, title: '5 năm'),
    OptionItem(id: 7, title: 'Trên 5 năm'),
  ]);

  OptionItem selectedExp = OptionItem(id: null, title: 'Chon kinh nghiệm');

  DropListModel listModelBy = DropListModel(listItem: [
    OptionItem(id: 1, title: 'Ngày'),
    OptionItem(id: 2, title: 'Tuần'),
    OptionItem(id: 3, title: 'Tháng'),
    OptionItem(id: 4, title: 'Năm')
  ]);

  OptionItem optionSelectedBy = OptionItem(id: 1, title: 'Ngày');

  DropListModel listModelCity = DropListModel(listItem: []);
  OptionItem optionSelectedCity = OptionItem(id: null, title: "Chọn nơi làm việc");

  Rx<File> _imageLogo = File('').obs;
  Rx<File> _listFile = File('').obs;
  bool isEstimatesOrPermanent = true;
  RxString _oldPathLogo = ''.obs;
  RxString _oldPathFile = ''.obs;
  RxInt currentIndex = 0.obs;

  File get imageLogo => _imageLogo.value;

  File get listFile => _listFile.value;

  TextEditingController textEdtCtrlNameJobsRecruitment = TextEditingController();

  String get textNameJobsRecruitment => textEdtCtrlNameJobsRecruitment.text;

  TextEditingController textEdtCtrlRequest = TextEditingController();

  String get textRequest => textEdtCtrlRequest.text;

  TextEditingController luongCoDinh = TextEditingController(text: '0');
  TextEditingController luongULBD = TextEditingController(text: '0');
  TextEditingController luongULKT = TextEditingController(text: '0');
  TextEditingController texWorkoutTimeCtrl = TextEditingController();

  DateTime valueDateStartDG = DateTime.now();
  DateTime valueDateEndDG = DateTime.now();
  DateTime valueDateStartWorking = DateTime.now();
  DateTime valueDateEndWorking = DateTime.now();
  RxString textError = ''.obs;
  RxString textErrorCD = ''.obs;

  RxList<FocusNode> _isFocus = [FocusNode(), FocusNode()].obs;
  RxList<bool> _error = [false, false].obs;

  RxList<FocusNode> get  isFocus => _isFocus;
  RxList<bool> get error => _error;

  List<String> listMessage = [
    "Chọn ngày bắt đầu",
    "Chọn ngày kết thúc",
    "Chọn ngày",
    "Chọn ngày",
  ];

  Future getImage() async {
    final img = await ImagePicker().getImage(source: ImageSource.gallery);
    _imageLogo.value = File(img.path);
  }

  void onChangeMonth(OptionItem m) {
    optionSelectedBy = m;
    update();
  }

  Future uploadFile() async {
    final file = await FilePicker.platform.pickFiles();
    if (file != null) {
      _listFile.value = File(file.paths[0]);
    }
    update();
  }

  void onChangePermanentOrEstimate() {
    this.isEstimatesOrPermanent = !this.isEstimatesOrPermanent;
    update();
  }

  Future selectDateStartDG(context) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: valueDateStartDG,
      firstDate: DateTime(valueDateStartDG.year - 10),
      lastDate: DateTime(valueDateStartDG.year + 10),
    );
    if (date != null && date != valueDateStartDG) {
      valueDateStartDG = date;
      listMessage[0] = _formatDate.format(date);
    }
    update();
  }

  Future selectDateEndDG(context) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: valueDateEndDG,
      firstDate: DateTime(valueDateEndDG.year - 10),
      lastDate: DateTime(valueDateEndDG.year + 10),
    );
    if (date != null && date != valueDateEndDG) {
      valueDateEndDG = date;
      listMessage[1] = _formatDate.format(date);
    }
    update();
  }

  Future selectDateStartWorking(context) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: valueDateStartWorking,
      firstDate: DateTime(valueDateStartWorking.year - 10),
      lastDate: DateTime(valueDateStartWorking.year + 10),
    );
    if (date != null && date != valueDateStartWorking) {
      valueDateStartWorking = date;
      listMessage[2] = _formatDate.format(date);
    }
    update();
  }

  Future selectDateEndWorking(context) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: valueDateEndWorking,
      firstDate: DateTime(valueDateEndWorking.year -10),
      lastDate: DateTime(valueDateEndWorking.year+10),
    );
    if(date != null && date != valueDateEndWorking){
      valueDateEndWorking = date;
      listMessage[3] = _formatDate.format(date);
    }
    update();
  }

  bool onValidateSalary() {
    if (isEstimatesOrPermanent) {
      if (int.parse(luongCoDinh.text.replaceAll(',', '')) < 0) {
        textErrorCD.value = 'Mức lương không được để âm';
        return true;
      }
    } else {
      if (int.parse(luongULBD.text.replaceAll(',', '')) > int.parse(luongULKT.text.replaceAll(',', ''))) {
        textError.value = 'Mức lương bắt đầu phải nhỏ hơn mức lương kết thúc';
        return true;
      } else if (int.parse(luongULBD.text.replaceAll(',', '')) < 0 || int.parse(luongULKT.text.replaceAll(',', '')) < 0) {
        textError.value = 'Mức lương không được để âm';
        return true;
      }
    }
    textErrorCD.value = '';
    textError.value = '';
    update();
    return false;
  }

  void onUpdateJob() {
    if (textEdtCtrlNameJobsRecruitment.text.isEmpty ||
        optionItemRecruitmentFieldSelected.id == null ||
        optionItemWorkForm.id == null ||
        selectedExp.id == null ||
        optionSelectedCity.id == null ||
        textEdtCtrlRequest.text.isEmpty ||
        optionItemSelectedSkill.id == null ||
        (isEstimatesOrPermanent ? luongCoDinh.text.isEmpty : (luongULBD.text.isEmpty || luongULKT.text.isEmpty)) ||
        listMessage[0] == 'Chọn ngày bắt đầu' ||
        listMessage[1] == 'Chọn ngày kết thúc' ||
        listMessage[2] == 'Chọn ngày' ||
        listMessage[3] == 'Chọn ngày') {
      Get.snackbar('Message', 'Mời bạn điền đầy đủ thông tin');
      if(textEdtCtrlNameJobsRecruitment.text.isEmpty) {
        _isFocus[0].requestFocus();
        _error[0] = true;
      }
      if(textEdtCtrlRequest.text.isEmpty) {
        _isFocus[1].requestFocus();
        _error[1] = true;
      }
    } else if (onValidateSalary()) {
      Get.snackbar('Message', "Lương ước lương bạn đã nhập sai");
    } else {
      _error[0] = false;
      _error[1] = false;
      UtilsData.updateWorkByProject(_oldPathLogo.value, _oldPathFile.value,
          token: SpUtil.getString(ConstString.token),
          logo: _imageLogo.value,
          maViec: dataPost.idPost,
          tenCongViec: textEdtCtrlNameJobsRecruitment.text,
          linhVuc: optionItemRecruitmentFieldSelected.id.toString(),
          maKyNang: optionItemSelectedSkill.id.toString(),
          hinhThuc: optionItemWorkForm.id.toString(),
          noiLamViec: optionSelectedCity.id.toString(),
          kinhNghiem: selectedExp.id.toString(),
          noiDungViec: textEdtCtrlRequest.text,
          file: listFile,
          theLoaiChiPhi: isEstimatesOrPermanent ? 1 : 2,
          chiPhiTheoGiDo: optionSelectedBy.id,
          chiPhi: isEstimatesOrPermanent
              ? luongCoDinh.text.replaceAll(',', '')
              : '${luongULBD.text.replaceAll(',', '')},${luongULKT.text.replaceAll(',', '')}',
          ngayBdDatGia: listMessage[0],
          ngayKtDatGia: listMessage[1],
          ngayBdLamViec: listMessage[2],
          ngayKtLamViec: listMessage[3],
          loaiViecLam: 1);
      Get.back();
    }
    update();
  }

  void onChangeFormat(String str, TextEditingController ctrl) {
    String text = _formatNumber.format(int.tryParse(str.replaceAll(',', '')) ?? 0);
    ctrl.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  void getSkillFromCategory(int idCategory) async {
    optionItemSelectedSkill = OptionItem(id: null, title: 'Chọn kỹ năng');
    listModelSkill = await UtilsData.getTagFromCategory(idCategory);
    update();
  }

  void setUp() async {
    String logo = dataPost.srcLogo;
    String fileName = dataPost.filePath + '/' + dataPost.fileName;
    _imageLogo.value = File(logo);
    _oldPathLogo.value = logo;
    this._listFile.value = File(fileName);
    _oldPathFile.value = fileName;
    textEdtCtrlNameJobsRecruitment.text = dataPost.titlePost;
    listRecruitmentFieldModel.listItem.forEach((element) {
      if (element.id.toString() == dataPost.idLinhVuc) optionItemRecruitmentFieldSelected = OptionItem(id: element.id, title: element.title);
    });
    listModelWorkForm.listItem.forEach((element) {
      if (element.id.toString() == dataPost.idHinhThuc) optionItemWorkForm = OptionItem(id: element.id, title: element.title);
    });

    listExp.listItem.forEach((element) {
      if (element.id.toString() == dataPost.idKinhNghiem) selectedExp = OptionItem(id: element.id, title: element.title);
    });

    listModelCity.listItem.forEach((element) {
      if (element.id.toString() == dataPost.idNoiLam) optionSelectedCity = OptionItem(id: element.id, title: element.title);
    });

    textEdtCtrlRequest.text = dataPost.moTa;

    listModelSkill = await UtilsData.getTagFromCategory(int.parse(dataPost.idLinhVuc));

    listModelSkill.listItem.forEach((element) {
      if (element.id.toString() == dataPost.idKyNang) optionItemSelectedSkill = OptionItem(id: element.id, title: element.title);
    });
    List<String> luong = dataPost.mucLuong.split(',');
    if (luong.length == 2) {
      luongULBD.text = _formatNumber.format(int.parse(luong[0]));
      luongULKT.text = _formatNumber.format(int.parse(luong[1]));
    } else
      luongCoDinh.text = _formatNumber.format(int.parse(luong[0]));

    listModelBy.listItem.forEach((element) {
      if (element.id.toString() == dataPost.idHinhThucTraLuong) optionSelectedBy = OptionItem(id: element.id, title: element.title);
    });

    listMessage[0] = dataPost.ngayBdDatGia;
    listMessage[1] = dataPost.ngayKtDatGia;
    listMessage[2] = dataPost.ngayBdLamViec;
    listMessage[3] = dataPost.ngayKtLamViec;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    textEdtCtrlNameJobsRecruitment.addListener(() {});
    textEdtCtrlRequest.addListener(() {});
    texWorkoutTimeCtrl.addListener(() {});
    luongULBD.addListener(() {
      onChangeFormat(luongULBD.text, luongULBD);
      onValidateSalary();
      update();
    });
    luongULKT.addListener(() {
      onChangeFormat(luongULKT.text, luongULKT);
      onValidateSalary();
      update();
    });
    luongCoDinh.addListener(() {
      onChangeFormat(luongCoDinh.text, luongCoDinh);
      onValidateSalary();
      update();
    });
    listRecruitmentFieldModel.listItem =
        List<OptionItem>.from((await UtilsData.getCategory()).map((e) => OptionItem(id: int.parse(e.maLinhVuc), title: e.tenLinhVuc)));
    listModelCity = await UtilsData.getCity();
    setUp();
  }
}
