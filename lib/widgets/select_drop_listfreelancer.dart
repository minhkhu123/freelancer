import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer_app/common/constants.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/screens/authens/freelancer_recruitment/freelancer_recruitment_screen.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/screens/menu/menu_controller.dart';
import 'package:freelancer_app/screens/menu/post_job_screen.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class SelectDrlFreelancer extends StatefulWidget {
  final DropListModel listFreelancerModel;

  const SelectDrlFreelancer({Key key, this.listFreelancerModel})
      : super(key: key);

  @override
  _SelectDropListFreelancerState createState() =>
      _SelectDropListFreelancerState();
}

class _SelectDropListFreelancerState extends State<SelectDrlFreelancer>
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
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
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
    var optionItemSelected;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              this.isShow = !this.isShow;
              _runExpandCheck();
              setState(() {});
            },
            child: Row(
              children: [
                SvgPicture.asset(Images.send),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Text(
                    "Tuyển dụng Freelancer",
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
            axisAlignment: 1.0,
            child: _buildDropListOption(context, widget.listFreelancerModel),
          ),
        ],
      ),
    );
  }

  Widget _buildDropListOption(context, DropListModel listFreelancerModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listFreelancerModel.listItem.map((e) => _buildItem(e)).toList(),
    );
  }

  Widget _buildItem(OptionItem optionItemFreelancer) {
    return GetBuilder<MenuController>(
      init: MenuController(),
      builder: (controller) => GestureDetector(
        onTap: () {
          switch (optionItemFreelancer.id) {
            case 1:
              // controller.getListCity();
              // controller.getListCategory();
              controller.whatJobUPost.value = 1;
              controller.showWhatJobUPost();
              SpUtil.putInt(ConstString.WHAT_U_POST, controller.whatJobUPost.value);
              Get.to(PostJobScreen());
              break;
            case 2:
              // controller.getListCity();
              // controller.getListCategory();
              controller.whatJobUPost.value = 2;
              controller.showWhatJobUPost();
              SpUtil.putInt(ConstString.WHAT_U_POST, controller.whatJobUPost.value);
              Get.to(PostJobScreen());
              break;
          }
        },
        child: Padding(
            padding: const EdgeInsets.only(left: 35, top: 17),
            child: Text(
              optionItemFreelancer.title,
              style: AppTextStyles.regularW400(context,
                  size: 16, color: AppColors.black3),
            )),
      ),
    );
  }
}
