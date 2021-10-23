import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/screens/candidate/commplete_your_profile/complete_your_profile_screen.dart';
import 'package:freelancer_app/screens/candidate/list_job/list_job_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:get/get.dart';

class SelectDropListManagement extends StatefulWidget {
  final DropListModel listManagementModel;

  const SelectDropListManagement({Key key, this.listManagementModel})
      : super(key: key);

  @override
  _SelectDropListManagementState createState() =>
      _SelectDropListManagementState();
}

class _SelectDropListManagementState extends State<SelectDropListManagement>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  bool isShow = false;
  int id;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    _runExpand();
  }

  void _runExpand() {
    if (isShow) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        InkWell(
          onTap: () {
            this.isShow = !this.isShow;
            _runExpand();
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    colors: [AppColors.lightBlue, AppColors.blue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Row(
              children: [
                SvgPicture.asset(Images.menu),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Quản lý chung",
                  style: AppTextStyles.regularW500(context, size: 16),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(
                      Images.ic_down,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: animationController,
          child: _buildList(context),
        )
      ],
    );
  }

  Widget _buildList(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.listManagementModel.listItem
          .map((e) => _buildItem(e))
          .toList(),
    );
  }

  Widget _buildItem(OptionItem e) {
    NavigationController navigationController = Get.put(NavigationController());
    return Padding(
      padding: const EdgeInsets.only(left: 45, top: 20),
      child: Row(
        children: [
          (id == e.id)
              ? SvgPicture.asset(Images.ic_dot)
              : SizedBox(
                  width: 6,
                ),
          SizedBox(
            width: 20,
          ),
          InkWell(
              onTap: () {
                setState(() {
                  id = e.id;
                });
                switch (e.id) {
                  case 1:
                    Get.to(CompleteYourProfileScreen());
                    break;
                  case 2:
                    navigationController.resetFilter();
                    navigationController.clearListSearch();
                    navigationController.getListJob();
                    Get.to(ListJobScreen());
                    break;
                }
              },
              child: Text(
                e.title,
                style: AppTextStyles.regularW500(context,
                    size: 16,
                    color: (id == e.id) ? AppColors.blue : AppColors.black3),
              )),
        ],
      ),
    );
  }
}
