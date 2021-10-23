import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/screens/menu/menu_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/custom_textinput_freelance_recruitment.dart';
import 'package:get/get.dart';

class SelectDropListSkills extends StatefulWidget {

  final String title;
  final String error;
  final int index;
  final RxInt indexPostJob;

  SelectDropListSkills({Key key, this.title, this.error, this.index, this.indexPostJob});

  @override
  _SelectDropListSkillsState createState() => _SelectDropListSkillsState();
}

class _SelectDropListSkillsState extends State<SelectDropListSkills>
    with SingleTickerProviderStateMixin {
  MenuController _menuController = Get.put(MenuController());
  NavigationController navigationController = Get.put(NavigationController());

  AnimationController expandController;
  Animation<double> animation;

  bool isShow = false;

  _SelectDropListSkillsState();

  @override
  void initState() {
    super.initState();
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    widget.indexPostJob.listen((int value) {
      if(widget.index != value && isShow){
        expandController.reverse();
        setState(() {

        });
      }else if(widget.index == value && !isShow){
        expandController.forward();
        setState(() {

        });
      }
    });
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
      widget.indexPostJob.value = widget.index;
    } else {
      expandController.reverse();
      widget.indexPostJob.value = 0;
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
      child: Column(
        children: <Widget>[
          CustomEditTextFreelancerRecruitment(
            hintText: _menuController.chooseSkills.value ? widget.title : 'Chọn kỹ năng',
            textError: widget.error,
            onPress: () {
              widget.indexPostJob.value = widget.index;
              if(widget.index == widget.indexPostJob.value){
                setState(() {
                  this.isShow = !this.isShow;
                  _runExpandCheck();
                });
              }
            },
          ),
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Container(
                constraints: BoxConstraints(
                  minHeight: 60,
                  maxHeight: height * 0.35,
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
                  itemCount: navigationController.listTag.length,
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
                                  child: Text(navigationController.listTag[index].name,
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
                            _menuController.indexSkills.value = int.parse(navigationController.listTag[index].id);
                            _menuController.nameSkills.value = navigationController.listTag[index].name;
                            _menuController.chooseSkills.value = true;
                            _menuController.showSkills();
                            isShow = false;
                            expandController.reverse();
                            print(navigationController.listTag[index].id);
                          },
                        ),
                      ),
                )),
          )
        ],
      ),
    );
  }
}
