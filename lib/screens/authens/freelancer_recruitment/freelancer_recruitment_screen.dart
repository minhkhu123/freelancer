import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/shared/data/models/result_get_data_by_project.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/screens/authens/freelancer_recruitment/post_jobs_by_project/post_jobs_by_project_screen.dart';
import 'package:freelancer_app/screens/authens/freelancer_recruitment/post_parttime_jobs/post_parttime_jobs_screen.dart';

class FreelancerRecruitmentScreen extends StatelessWidget {
  final int isWork;
  final DataPost dataPost;

  FreelancerRecruitmentScreen({Key key, this.isWork, this.dataPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (isWork == 1) ? "Đăng việc theo dự án" : "Đăng việc bán thời gian",
          style: AppTextStyles.regularW500(context, size: 18),
        ),
        elevation: 0,
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 288,
              child: Stack(
                children: [
                  Image.asset(Images.top_watch_detail),
                  Positioned(
                    bottom: 0,
                    left: MediaQuery.of(context).size.width * 0.37,
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: AppColors.grey,
                            offset: Offset(0, 10),
                            blurRadius: 10,
                            spreadRadius: -5)
                      ], borderRadius: BorderRadius.circular(50)),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.white,
                        child: SvgPicture.asset(Images.ic_book),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isWork == 1 ? PostJobsByProjectScreen(dataPost: dataPost,) : PostPartTimeJobsScreen(dataPost: dataPost,),
          ],
        ),
      ),
    );
  }
}
