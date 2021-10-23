import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/career_freelancer.dart';
import 'package:freelancer_app/widgets/comment_salary.dart';
import 'package:freelancer_app/widgets/file_with.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailJobPosted extends StatelessWidget {
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

  const DetailJobPosted(
      {Key key,
      this.nameProject,
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
      this.turnedDeal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    NavigationController navigationController = Get.put(NavigationController());
    // var convert0 = NumberFormat('###,###,###,###,###,##0', 'en_US');
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.whiteDot,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              navigationController.checkDetailJob.value = false;
              navigationController.checkDetailJobPost();
              navigationController.clearListDetailJob();
              Get.back();
            }),
        title: Container(
            width: width * 0.8,
            child: Text(
              'Việc làm Freelancer... / $nameProject',
              style: AppTextStyles.regularW500(context, size: 18),
              overflow: TextOverflow.ellipsis,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(Images.top_watch_detail),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GetBuilder<NavigationController>(
                init: NavigationController(),
                builder: (controller) => Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(Images.top_container),
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
                            thickness: 0.5,
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
                                    Text(
                                      phone,
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.orange),
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
                                    Text(
                                      email,
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.orange),
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
                                      style: AppTextStyles.regularW400(context, size: 15, color: AppColors.blue),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 23),
                          ClipRRect(
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
                          ),
                          SizedBox(height: 10),
                          Text(
                            nameProject,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.3),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          Stack(
                            children: [
                              Center(child: SvgPicture.asset(Images.bg_salary)),
                              Column(
                                children: [
                                  SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      money,
                                      style: AppTextStyles.regularW700(context, size: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
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
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 25),
                                  height: height * 0.02,
                                  width: 1.5,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey,
                                  ),
                                ),
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
                          SizedBox(height: 12),
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
                                      padding: const EdgeInsets.only(right: 12),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                describe,
                                style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'File đính kèm:',
                                style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                              ),
                              SizedBox(height: 15),
                              FileWith(
                                link: file,
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    'Kỹ năng:',
                                    style: AppTextStyles.regularW400(context, size: 16, color: AppColors.black),
                                  ),
                                  SizedBox(width: 10),
                                  CareerFreelancer(
                                    name: 'PHP',
                                  ),
                                ],
                              ),
                              SizedBox(height: 60)
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Column(
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: 'Có ',
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, height: 1.4, color: AppColors.black),
                                    children: [
                                  TextSpan(
                                    text: turnedDeal,
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, height: 1.4, color: AppColors.blue),
                                  ),
                                  TextSpan(
                                    text: ' Freelancer đang đặt giá cho công việc này',
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, height: 1.4, color: AppColors.black),
                                  )
                                ])),
                            Container(
                              constraints: BoxConstraints(minHeight: 100),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.listLoadMoreFreelancerDeal.length,
                                itemBuilder: (context, index) => CommentSalary(
                                  urlAvatar: controller.listLoadMoreFreelancerDeal[index].linkAvtFlc +
                                      controller.listLoadMoreFreelancerDeal[index].avatarFlc,
                                  name: controller.listLoadMoreFreelancerDeal[index].tenFlc,
                                  job: controller.listLoadMoreFreelancerDeal[index].ngheNghiepFlc,
                                  deal: controller.listLoadMoreFreelancerDeal[index].datGia,
                                  desc: controller.listLoadMoreFreelancerDeal[index].gioiThieu,
                                  rate: double.parse(controller.listLoadMoreFreelancerDeal[index].saoTbFlc.toString()),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                controller.loadMoreFreelancerD();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Xem thêm',
                                    style: AppTextStyles.regularW700(context, size: 18, color: AppColors.orange),
                                  ),
                                  SizedBox(width: 5),
                                  SvgPicture.asset(Images.ic_more),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            WillPopScope(
              onWillPop: () {
                navigationController.checkDetailJob.value = false;
                navigationController.checkDetailJobPost();
                navigationController.clearListDetailJob();
                Get.back();
              },
              child: Container(),
            )
          ],
        ),
      ),
    ));
  }
}
