  import 'package:flutter/material.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:freelancer_app/common/images.dart';
  import 'package:freelancer_app/common/theme/app_color.dart';
  import 'package:freelancer_app/common/theme/app_text_style.dart';
  import 'package:freelancer_app/screens/menu/post_project_screen.dart';
  import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
  import 'package:get/get.dart';

  class TutorialScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      NavigationController navigationController = Get.put(NavigationController());
      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;
      return SafeArea(
          child: Scaffold(
        backgroundColor: AppColors.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Hướng dẫn thuê Freelancer',
                      style: AppTextStyles.regularW500(context, size: 18, color: AppColors.black),
                    ),
                  ],
                ),
                Image.asset(Images.tutorial_pic_1),
                SizedBox(height: 20),
                Center(
                    child: Text(
                  'Đăng việc để thuê Freelancer làm việc ngay!',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, height: 1.4),
                  textAlign: TextAlign.center,
                )),
                SizedBox(height: 20),
                InkWell(
                  onTap: () => navigationController.changePageOut(PostProjectScreen()),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 33, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [Color(0xFFF89820), Color(0xFFFCC63C)]),
                      ),
                      child: Text(
                        'Đăng việc ngay',
                        style: AppTextStyles.regularW700(context, size: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Images.ic_1),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vào mục đăng dự án',
                          style: AppTextStyles.regularW700(context, size: 20, color: AppColors.blue),
                        ),
                        SizedBox(height: 10),
                        Container(
                            width: width * 0.63,
                            child: Text(
                              'Bấm vào nút đăng dự án hiển thị trong Trang cá nhân.\nChọn Tuyển dụng Freelancer đăng việc theo dự án hoặc đăng việc bán thời gian\nMẫu đăng việc của Timviec365 đã sẵn sàng để bạn sử dụng.',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.3),
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Image.asset(Images.tutorial_pic_2),
                SizedBox(height: 40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Images.ic_2),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Điền đầy đủ thông tin',
                          style: AppTextStyles.regularW700(context, size: 20, color: AppColors.blue),
                        ),
                        SizedBox(height: 10),
                        Container(
                            width: width * 0.57,
                            child: Text(
                              'Sau khi vào mục Đăng việc theo dự án hoặc Đăng việc bán thời gian, bạn điền đầy đủ thông tin tuyển dụng như sau:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.3),
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'Viết tên việc ngắn gọn',
                  style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                ),
                SizedBox(height: 10),
                Text(
                  'Ví dụ:\n- Dịch báo Việt - Anh đề tài du lịch\n- Thiết kế trang web bán hàng',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppColors.grey78, height: 1.3),
                ),
                SizedBox(height: 20),
                Text(
                  'Chọn lĩnh vực cần tuyển',
                  style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                ),
                SizedBox(height: 10),
                Text(
                  '- Chọn lĩnh vực bạn cần tuyển\n- Chọn dịch vụ phù hợp nhất để tuyển Freelancer chính xác.',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppColors.grey78, height: 1.3),
                ),
                SizedBox(height: 20),
                Text(
                  'Mô tả rõ ràng',
                  style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                ),
                SizedBox(height: 10),
                Text(
                  '- Nên viết mô tả bằng tiếng Việt có dấu\n- Mỗi yêu cầu thể hiện bằng 1 gạch đầu dòng (làm việc gì, yêu cầu thế nào về kinh nghiệm...)',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppColors.grey78, height: 1.3),
                ),
                SizedBox(height: 20),
                Text(
                  'Thêm kỹ năng',
                  style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                ),
                SizedBox(height: 10),
                Text(
                  '- Chọn 1 vài kỹ năng cần nhất với yêu cầu dự án và thêm vào cuối dự án.\n- Tag kỹ năng giúp freelancer liên quan tiếp cận dự án của bạn nhanh hơn.',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppColors.grey78, height: 1.3),
                ),
                SizedBox(height: 20),
                Text(
                  'Chọn ngân sách hấp dẫn',
                  style: AppTextStyles.regularW500(context, size: 16, color: AppColors.black),
                ),
                SizedBox(height: 10),
                Text(
                  '- Hãy đưa ra mức ngân sách bằng đúng khả năng chi trả của bạn.\n- Con số phải thực tế. Nếu quá thấp hoặc quá cao freelancer sẽ cho rằng bạn thiếu nghiêm túc.',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppColors.grey78, height: 1.3),
                ),
                SizedBox(height: 40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Images.ic_3),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Đăng dự án',
                          style: AppTextStyles.regularW700(context, size: 20, color: AppColors.blue),
                        ),
                        SizedBox(height: 10),
                        Container(
                            width: width * 0.57,
                            child: RichText(
                              text: TextSpan(
                                text: 'Sau khi đã điền đầy đủ thông tin trên form mẫu của Timviec365.com bạn hãy bấm vào nút ',
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,height: 1.3,color: AppColors.black),
                                children: [
                                  TextSpan(
                                    text: 'Đăng việc',
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,height: 1.3,color: AppColors.orange),
                                  )
                                ]
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Image.asset(Images.tutorial_pic_3),
                SizedBox(height: 30),
                WillPopScope(
                  onWillPop: () {
                    navigationController.changePage(4);
                    navigationController.isBackApp.value = true;
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
