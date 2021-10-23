import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_controller.dart';
import 'package:freelancer_app/screens/home/list_job_by_skill.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/card_job_freelancer.dart';
import 'package:freelancer_app/widgets/career_freelancer.dart';
import 'package:freelancer_app/widgets/comment_salary.dart';
import 'package:freelancer_app/widgets/dialog_login.dart';
import 'package:freelancer_app/widgets/dialog_login_save_project.dart';
import 'package:freelancer_app/widgets/dialog_login_watch_contact.dart';
import 'package:freelancer_app/widgets/file_with.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';

class WatchDetailScreen extends StatelessWidget {
  final String nameProject;
  final String money;
  final String id;
  final String datePost;
  final String namePoster;
  final String phone;
  final String email;
  final String urlAvatar;
  final String urlLogo;
  final String addreddLive;
  final String dateJoin;
  final String dateEnd;
  final String postedMany;
  final String form;
  final String dateStart;
  final String deadLine;
  final String addressWork;
  final String exp;
  final String describe;
  final String file;
  final String turnedDeal;
  final List<String> listSkill;

  const WatchDetailScreen({
    Key key,
    this.nameProject,
    this.listSkill,
    this.money,
    this.id,
    this.datePost,
    this.namePoster,
    this.phone,
    this.email,
    this.urlAvatar,
    this.urlLogo,
    this.addreddLive,
    this.dateJoin,
    this.dateEnd,
    this.postedMany,
    this.form,
    this.dateStart,
    this.deadLine,
    this.addressWork,
    this.exp,
    this.describe,
    this.file,
    this.turnedDeal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    NavigationController navigationController = Get.put(NavigationController());
    WaitLoginController waitLoginController = Get.put(WaitLoginController());
    // var convert0 = NumberFormat('###,###,###,###,###,##0', 'en_US');
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.whiteDot,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              navigationController.clearListDetailJob();
              Get.back();
            }),
        title: Text(
          'Việc làm Freelancer... / $nameProject',
          style: AppTextStyles.regularW500(context, size: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<NavigationController>(
          init: NavigationController(),
          builder: (controller) => Column(
            children: [
              Stack(
                children: [
                  Container(
                      color: AppColors.white,
                      child: Image.asset(
                        Images.top_watch_detail,
                        height: 218,
                        width: width,
                      )),
                  Positioned(
                      top: 180,
                      left: 16,
                      right: 16,
                      child: Stack(
                        children: [
                          Container(
                            width: width,
                            height: height,
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                                color: AppColors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.greyBorder)),
                          ),
                        ],
                      )),
                  Positioned(
                      top: 145,
                      left: 140,
                      right: 140,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: urlLogo,
                          height: 67,
                          width: 67,
                          placeholder: (context, url) => SizedBox(
                            child: CircularProgressIndicator(),
                            width: 67,
                            height: 67,
                          ),
                          errorWidget: (context, url, error) => SvgPicture.asset(Images.logo_timviec365_circle),
                        ),
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                    border: Border(
                      left: BorderSide(width: 1, color: AppColors.greyBorder),
                      right: BorderSide(width: 1, color: AppColors.greyBorder),
                      bottom: BorderSide(width: 1, color: AppColors.greyBorder),
                    )),
                child: Column(
                  children: [
                    Text(
                      nameProject,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.3),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Stack(
                      children: [
                        Center(child: SvgPicture.asset(Images.bg_salary)),
                        Column(
                          children: [
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                '$moneyđ',
                                style: AppTextStyles.regularW700(context, size: 20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            'ID dự án: ',
                            style: AppTextStyles.regularW400(context, size: 14, color: AppColors.grey2),
                          ),
                          Text(
                            id,
                            style: AppTextStyles.regularW500(context, size: 14, color: AppColors.black),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            height: height * 0.02,
                            width: 1.5,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Ngày đăng: ',
                            style: AppTextStyles.regularW400(context, size: 14, color: AppColors.grey2),
                          ),
                          Text(
                            datePost,
                            style: AppTextStyles.regularW500(context, size: 14, color: AppColors.black),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        waitLoginController.checkLogin.value ? controller.saveProject() : Get.dialog(DialogLoginSaveProject());
                      },
                      child: Container(
                        width: width * 0.4,
                        height: height * 0.055,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blue),
                          borderRadius: BorderRadius.circular(10),
                          color: controller.saveProjected.value ? AppColors.blue : AppColors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                              child: Icon(
                                Icons.star,
                                color: controller.saveProjected.value ? AppColors.white : AppColors.blue,
                              ),
                            ),
                            Text(
                              'Lưu dự án',
                              style: AppTextStyles.regularW500(context,
                                  size: 14, color: controller.saveProjected.value ? AppColors.white : AppColors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 21),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.grey),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: width,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: urlAvatar,
                                height: 95,
                                width: 95,
                                placeholder: (context, url) => SizedBox(
                                  child: CircularProgressIndicator(),
                                  width: 95,
                                  height: 95,
                                ),
                                errorWidget: (context, url, error) => SvgPicture.asset(Images.logo_user),
                              ),
                            ),
                          ),
                          Text(
                            namePoster,
                            style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                          ),
                          SizedBox(height: 13),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Images.ic_location_detail),
                              SizedBox(width: 8),
                              Text(
                                addreddLive,
                                style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey4),
                              ),
                            ],
                          ),
                          SizedBox(height: 21),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey,
                          ),
                          SizedBox(height: 17),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'SĐT:',
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey4),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: waitLoginController.checkLogin.value ? null : () => Get.dialog(DialogLoginWatchContact()),
                                      child: Text(
                                        waitLoginController.checkLogin.value ? phone : 'Đăng nhập để xem SĐT',
                                        style: AppTextStyles.regularW400(context,
                                            size: 15, color: waitLoginController.checkLogin.value ? AppColors.black : AppColors.orange),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(
                                      'Email:',
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey4),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: waitLoginController.checkLogin.value ? null : () => Get.dialog(DialogLoginWatchContact()),
                                      child: Container(
                                        width: width * 0.5,
                                        child: Text(
                                          waitLoginController.checkLogin.value ? email : 'Đăng nhập để xem Email',
                                          style: AppTextStyles.regularW400(context,
                                              size: 15, color: waitLoginController.checkLogin.value ? AppColors.black : AppColors.orange),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(
                                      'Tham gia:',
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey4),
                                    ),
                                    Spacer(),
                                    Text(
                                      dateJoin,
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(
                                      'Đã đăng:',
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.grey4),
                                    ),
                                    Spacer(),
                                    Text(
                                      postedMany,
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25),
                                InkWell(
                                    onTap: () => controller.jobPosted(),
                                    child: Text(
                                      'Xem thêm',
                                      style: AppTextStyles.regularW400(context, size: 13, color: AppColors.orange),
                                    )),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.grey),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                                child: SvgPicture.asset(Images.ic_infor),
                              ),
                              Text(
                                'Hình thức',
                                style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey4),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 13),
                                child: Text(
                                  form,
                                  style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                                child: SvgPicture.asset(Images.ic_date_start),
                              ),
                              Text(
                                'Ngày bắt đầu',
                                style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey4),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 13),
                                child: Text(
                                  dateStart,
                                  style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                                child: SvgPicture.asset(Images.ic_deadline),
                              ),
                              Text(
                                'Thời hạn',
                                style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey4),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 13),
                                child: Text(
                                  deadLine,
                                  style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                                child: SvgPicture.asset(Images.ic_loca),
                              ),
                              Text(
                                'Địa điểm',
                                style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey4),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 13),
                                child: Text(
                                  addressWork,
                                  style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                                child: SvgPicture.asset(Images.ic_exp),
                              ),
                              Text(
                                'Kinh nghiệm',
                                style: AppTextStyles.regularW400(context, size: 16, color: AppColors.grey4),
                              ),
                              Spacer(),
                              Container(
                                width: width * 0.4,
                                padding: const EdgeInsets.only(right: 13),
                                child: Text(
                                  exp,
                                  style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          height: 28,
                          width: 5,
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                          ),
                        ),
                        SizedBox(width: 14),
                        Text(
                          'Mô tả công việc',
                          style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 13),
                    Text(
                      describe,
                      style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                    ),
                    // SizedBox(height: 20),
                    // Text(
                    //   'File đính kèm:',
                    //   style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                    // ),
                    // SizedBox(height: 15),
                    // FileWith(
                    //   link: file,
                    // ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Kỹ năng:',
                          style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                        ),
                        SizedBox(width: 10),
                        Row(
                          children: List.generate(listSkill.length, (index) {
                            // if (index < navigationController.ind.value) {
                            return CareerFreelancer(
                              name: listSkill[index],
                              onPress: () {
                                controller.indexSkills.value = int.parse(controller.resultJobDetail.data.jobDetail.kyNang);
                                controller.clearListSearch();
                                controller.getListJob();
                                Get.to(ListJobBySkill());
                              },
                            );
                          }),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          height: 28,
                          width: 5,
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                          ),
                        ),
                        SizedBox(width: 14),
                        Text(
                          'Thông tin đặt giá',
                          style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Đặt giá cho công việc này!',
                          style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                        ),
                        SizedBox(height: 15),
                        TextFieldDialog(
                          hintText: 'Nhập mức lương mong muốn',
                          textEditingController: controller.salaryWantTextEditingController,
                          keyboardType: TextInputType.number,
                          error: controller.checkValidSalary(),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                        TextFieldDialog(
                          hintText: 'Nhập địa chỉ Email của bạn',
                          textEditingController: controller.yourEmailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          error: controller.checkValidEmail(),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.white3,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              'Đặt giá kết thúc ngày $dateEnd',
                              style: AppTextStyles.regularW400(context, size: 14, color: AppColors.blue2),
                            )),
                        SizedBox(height: 34),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 27),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  waitLoginController.checkLogin.value
                                      ? controller.dealSalary() : Get.dialog(DialogLogin());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: AppColors.orange,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Đặt giá',
                                    style: AppTextStyles.regularW500(context, size: 16, color: AppColors.white),
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.salaryWantTextEditingController.clear();
                                  controller.yourEmailTextEditingController.clear();
                                  Get.back();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.grey),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Hủy',
                                    style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                                  )),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          height: 28,
                          width: 5,
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                          ),
                        ),
                        SizedBox(width: 14),
                        Text(
                          'Công việc tương tự',
                          style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                        ),
                      ],
                    ),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: 100,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.listSimilarJobProject.length,
                        itemBuilder: (context, index) => DescribeJob(
                          title: controller.listSimilarJobProject[index].tenViecLam,
                          job: controller.listSimilarJobProject[index].nganhNghe,
                          money: controller.listSimilarJobProject[index].mucLuong,
                          time: controller.listSimilarJobProject[index].traLuongTheo,
                          onPress: () {
                            Get.back();
                            controller.indexIdJob.value = controller.listSimilarJobProject[index].id;
                            controller.getDetailJob();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              WillPopScope(
                onWillPop: () {
                  navigationController.clearListDetailJob();
                  Get.back();
                },
                child: Container(),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class DescribeJob extends StatelessWidget {
  final String title;
  final String job;
  final String money;
  final String time;
  final VoidCallback onPress;

  const DescribeJob({Key key, this.title, this.job, this.money, this.time, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: InkWell(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: width * 0.75,
                child: Text(
                  title,
                  style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                  overflow: TextOverflow.ellipsis,
                )),
            SizedBox(height: 6),
            Row(
              children: [
                SvgPicture.asset(Images.ic_work),
                SizedBox(width: 9),
                Text(
                  job,
                  style: AppTextStyles.regularW400(context, size: 14, color: AppColors.black),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SvgPicture.asset(Images.ic_money),
                SizedBox(width: 9),
                Text(
                  '$moneyđ/$time',
                  style: AppTextStyles.regularW400(context, size: 14, color: AppColors.orange),
                ),
              ],
            ),
            SizedBox(height: 13),
            Divider(
              thickness: 0.5,
              color: AppColors.grey,
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
