import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/screens/authens/freelancer_has_set_a_price/freelancer_has_set_a_price_screen.dart';
import 'package:freelancer_app/screens/authens/freelancer_is_working/freelance_is_working_screen.dart';
import 'package:freelancer_app/screens/authens/freelancer_is_working/freelancer_is_working_controller.dart';
import 'package:freelancer_app/screens/authens/freelancer_saved/freelancer_saved_sceen.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class SelectDropListRecordsManagement extends StatefulWidget {
  final DropListModel listRecordsManagementModel;

  const SelectDropListRecordsManagement(
      {Key key, this.listRecordsManagementModel})
      : super(key: key);

  @override
  _SelectDropListRecordsManagementState createState() =>
      _SelectDropListRecordsManagementState();
}

class _SelectDropListRecordsManagementState
    extends State<SelectDropListRecordsManagement>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  bool isShow = false;

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
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              this.isShow = !this.isShow;
              _runExpand();
              setState(() {});
            },
            child: Row(
              children: [
                SvgPicture.asset(Images.setting),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Text(
                    "Quản lý hồ sơ",
                    style: AppTextStyles.regularW400(context,
                        size: 16, color: AppColors.black3),
                  ),
                ),
                isShow
                    ? SvgPicture.asset(Images.ic_down)
                    : SvgPicture.asset(Images.horizon)
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: animation,
            child: _buildListOption(context, widget.listRecordsManagementModel),
          ),
        ],
      ),
    );
  }

  Widget _buildListOption(context, DropListModel listRecordsManagementModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listRecordsManagementModel.listItem
          .map((e) => _buildItem(e))
          .toList(),
    );
  }

  Widget _buildItem(OptionItem e) {
    FreelancerIsWorkingController freelancerIsWorkingController = Get.put(FreelancerIsWorkingController());
    return GestureDetector(
      onTap: () {
        switch (e.id) {
          case 1:
            Get.to(FreelancerHasSetAPriceScreen());
            break;
          case 2:
            // freelancerIsWorkingController.listResultGetFreelancerWorking.clear();
            freelancerIsWorkingController.onInit();
            Get.to(FreelancerIsWorkingScreen());
            break;
          case 3:
            Get.to(FreelancerSavedScreen());
            break;
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 35, top: 17),
        child: Text(
          e.title,
          style: AppTextStyles.regularW400(context,
              size: 16, color: AppColors.black3),
        ),
      ),
    );
  }
}
