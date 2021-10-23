import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/drop_list_model_freelancer.dart';
import 'package:get/get.dart';

class SelectDropListFreelancer extends StatefulWidget {
  final OptionItemFreelancer itemSelectedFreelancer;
  final DropListModelFreelancer dropListModelFreelancer;
  final Function(OptionItemFreelancer optionItemFreelancer) onOptionSelectedFreelancer;

  SelectDropListFreelancer(this.itemSelectedFreelancer, this.dropListModelFreelancer, this.onOptionSelectedFreelancer);

  @override
  _SelectDropListFreelancerState createState() => _SelectDropListFreelancerState(itemSelectedFreelancer, dropListModelFreelancer);
}

class _SelectDropListFreelancerState extends State<SelectDropListFreelancer> with SingleTickerProviderStateMixin {
  OptionItemFreelancer optionItemSelectedFreelancer;
  final DropListModelFreelancer dropListModelFreelancer;

  AnimationController expandController;
  Animation<double> animation;

  bool isShow = false;

  _SelectDropListFreelancerState(this.optionItemSelectedFreelancer, this.dropListModelFreelancer);

  @override
  void initState() {
    super.initState();
    expandController = AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) => Container(
        width: width*0.43,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.only(left: 10),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: AppColors.grey),
                color: Colors.white,
              ),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          this.isShow = !this.isShow;
                          _runExpandCheck();
                          setState(() {});
                        },
                        child: Text(
                          controller.selectedFreelancer.value,
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.hintText),
                        )),
                  ),
                  Align(
                    alignment: Alignment(1, 0),
                    child: SvgPicture.asset(
                      Images.ic_down,
                    ),
                  ),
                ],
              ),
            ),
            SizeTransition(
                axisAlignment: 1.0,
                sizeFactor: animation,
                child: Container(
                    margin: const EdgeInsets.only(bottom: 10,left: 5,right: 5),
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            color: Colors.black26,
                            offset: Offset(0, 2))
                      ],
                      color: Colors.white,
                    ),
                    child: _buildDropListOptions(dropListModelFreelancer.listOptionItemsFreelancer, context))),
          ],
        ),
      ),
    );
  }

  Column _buildDropListOptions(List<OptionItemFreelancer> items, BuildContext context) {
    return Column(
      children: items.map((itemFreelancer) => _buildSubMenu(itemFreelancer, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItemFreelancer itemFreelancer, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
      child: GetBuilder<NavigationController>(
        init: NavigationController(),
        builder: (controller) => GestureDetector(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey[200], width: 1)),
                  ),
                  child: Text(itemFreelancer.title,
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.hintText),
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
          onTap: () {
            this.optionItemSelectedFreelancer = itemFreelancer;
            isShow = false;
            expandController.reverse();
            widget.onOptionSelectedFreelancer(itemFreelancer);
            controller.selectedFreelancer.value = optionItemSelectedFreelancer.title;
          },
        ),
      ),
    );
  }
}
