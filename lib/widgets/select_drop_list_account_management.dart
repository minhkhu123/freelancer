import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/screens/authens/change_password/change_password_screen.dart';
import 'package:freelancer_app/screens/authens/update_profile_ntd/update_profile_ntd_screen.dart';
import 'package:freelancer_app/widgets/dialog_logout.dart';
import 'package:get/get.dart';

class SelectDropListAccountManagement extends StatefulWidget {
  final DropListModel listAccountManagementModel;

  const SelectDropListAccountManagement(
      {Key key, this.listAccountManagementModel})
      : super(key: key);

  @override
  _SelectDropListAccountManagementState createState() =>
      _SelectDropListAccountManagementState();
}

class _SelectDropListAccountManagementState
    extends State<SelectDropListAccountManagement>
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
                SvgPicture.asset(Images.user),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Text(
                    "Quản lý tài khoản",
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
            child: _buildListOption(context, widget.listAccountManagementModel),
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
    return GestureDetector(
      onTap: () {
        switch (e.id) {
          case 1:
            Get.to(UpdateProfileNTDScreen(
              role: false,
            ));
            break;
          case 2:
            Get.to(ChangePasswordScreen(
              checkWhoUr: false,
            ));
            break;
          case 3:
            Get.dialog(DialogLogOut());
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
