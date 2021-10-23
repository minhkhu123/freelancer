import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_freelancer_working.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/common/utils_data.dart';
import 'package:freelancer_app/screens/authens/freelancer_is_working/freelancer_is_working_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/custom_textfield_ongoing_project.dart';
import 'package:freelancer_app/widgets/top_employer_profile.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class FreelancerIsWorkingScreen extends StatelessWidget {
  FreelancerIsWorkingScreen({Key key}) : super(key: key);
  final NavigationController navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<FreelancerIsWorkingController>(
            init: FreelancerIsWorkingController(),
            builder: (controller) => Column(
              children: [
                TopEmployerProfile(
                  onPress: () {
                    Get.back();
                    controller.listResultGetFreelancerWorking.clear();
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 2, color: AppColors.blue)),
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15,
                          ),
                          child: Text(
                            "Freelancer đang làm việc",
                            style: AppTextStyles.regularW500(context, size: 19),
                          ),
                        ),
                      ),
                      controller.listResultGetFreelancerWorking.isEmpty
                          ? Container(
                              height: height * 0.45,
                              child: Center(
                                child: Text(
                                  controller.message.value,
                                  style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    children: List.generate(
                                        controller.listResultGetFreelancerWorking.length,
                                        (index) => _itemListFreelancerHasSetAPrice(context, height, width, index,
                                            item: controller.listResultGetFreelancerWorking[index])),
                                  ),
                                ),
                                controller.message.value.isEmpty
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              InkWell(
                                                child: Text(
                                                  "Xem thêm",
                                                  style: AppTextStyles.regularW700(context, size: 15, color: AppColors.orange),
                                                ),
                                                onTap: controller.loadTime,
                                              ),
                                              Container(
                                                height: 2,
                                                width: 65,
                                                color: AppColors.orange,
                                                child: Text(" "),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SvgPicture.asset(Images.ic_doubleDown)
                                        ],
                                      )
                                    : SizedBox(),
                              ],
                            ),
                      SizedBox(height: 15)
                    ],
                  ),
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemListFreelancerHasSetAPrice(context, height, width, index, {ListElement item}) {
    return GetBuilder<FreelancerIsWorkingController>(
      init: FreelancerIsWorkingController(),
      builder: (controller) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                CustomTextFieldOnGoingProject(
                  text: "Tên Freelancer",
                  height: height * 0.09,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          item.tenFreelancer,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        InkWell(
                          onTap: () {
                            navigationController.indexIdFreelancer.value = item.maFrelancer;
                            navigationController.detailFreelancer();
                          },
                          child: Text(
                            "(Xem chi tiết)",
                            style: AppTextStyles.regularW400(
                              context,
                              size: 13,
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                CustomTextFieldOnGoingProject(
                  text: "Tên dự án",
                  height: height * 0.09,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          item.tenDuAn,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        InkWell(
                          onTap: () {
                            navigationController.indexIdJob.value = item.maViec;
                            navigationController.getDetailJob();
                          },
                          child: Text(
                            "(Xem chi tiết)",
                            style: AppTextStyles.regularW400(
                              context,
                              size: 13,
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                CustomTextFieldOnGoingProject(
                  text: "Ngân sách",
                  height: height * 0.07,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: Text(
                        item.nganSach,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.regularW500(
                          context,
                          size: 16,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                CustomTextFieldOnGoingProject(
                  text: "Ngày hết hạn",
                  height: height * 0.07,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      UtilsData.timeStampToDateTime(item.ngayHetHan),
                      style: AppTextStyles.regularW400(
                        context,
                        size: 16,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                CustomTextFieldOnGoingProject(
                  text: "Trạng thái",
                  height: height * 0.07,
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: DropdownButton(
                        value: (controller.idStatus[index].isEmpty)
                            ? controller.getStatus(item.trangThai)
                            : controller.getStatus(controller.idStatus[index]),
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        onChanged: (value) {
                          controller.onChangeStatus(value, index);
                          print(index);
                          controller.updateStatus(
                              token: SpUtil.getString(ConstString.token),
                              idDatGia: item.idDatGia,
                              trangThai: controller.trangThai.indexOf(value).toString());
                        },
                        items: controller.trangThai
                            .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                                value: e,
                                child: Container(
                                    width: 130,
                                    child: Text(
                                      e,
                                      textAlign: TextAlign.center,
                                    ))))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                CustomTextFieldOnGoingProject(
                  text: "Đánh giá",
                  height: height * 0.07,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 2,
                      ),
                      RatingBar.builder(
                        itemSize: 20,
                        allowHalfRating: false,
                        // ignoreGestures: true,
                        initialRating: item.danhGia.toDouble(),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: AppColors.orange,
                        ),
                        onRatingUpdate: (value) {
                          controller.onChangeStatusRate(value, index);
                          controller.rattingStartWorking(
                              token: SpUtil.getString(ConstString.token),
                              rateStar: value.toInt(),
                              maFlc: int.parse(item.maFrelancer),
                              maViecLam: int.parse(item.maViec),
                              trangThai: (controller.idStatus[index].isEmpty) ? int.parse(item.trangThai) : int.parse(controller.idStatus[index]));
                        },
                      ),
                      Text(
                        '(${controller.danhGia[controller.idStatusRate[index] == 10 ? item.danhGia.toDouble() : controller.idStatusRate[index]]})',
                        style: AppTextStyles.regularW400(
                          context,
                          size: 13,
                          color: AppColors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
