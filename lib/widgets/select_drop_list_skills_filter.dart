import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/menu/menu_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/drop_list_model_city.dart';
import 'package:get/get.dart';

class SelectDropListSkillsFilter extends StatefulWidget {

  final String title;

  SelectDropListSkillsFilter({Key key, this.title});

  @override
  _SelectDropListSkillsFilterState createState() => _SelectDropListSkillsFilterState();
}

class _SelectDropListSkillsFilterState extends State<SelectDropListSkillsFilter>
    with SingleTickerProviderStateMixin {

  AnimationController expandController;
  Animation<double> animation;

  bool isShow = false;

  _SelectDropListSkillsFilterState();

  @override
  void initState() {
    super.initState();
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
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
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: GetBuilder<NavigationController>(
        init: NavigationController(),
        builder: (controller) => Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: AppColors.grey),
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
                          controller.chooseSkills.value ? widget.title : 'Chọn kỹ năng',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.hintText),
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
                  constraints: BoxConstraints(
                    minHeight: 50,
                    maxHeight: 300
                  ),
                  margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          color: Colors.black26,
                          offset: Offset(0, 2))
                    ],
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.listTag.length,
                    itemBuilder: (context, index) =>
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
                          child: GestureDetector(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(color: Colors.grey[200], width: 1)),
                                    ),
                                    child: Text(controller.listTag[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: AppColors.hintText),
                                        maxLines: 3,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              controller.indexSkills.value = int.parse(controller.listTag[index].id);
                              controller.nameSkills.value = controller.listTag[index].name;
                              controller.chooseSkills.value = true;
                              controller.showSkills();
                              isShow = false;
                              expandController.reverse();
                              print(controller.listTag[index].id);
                            },
                          ),
                        ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
