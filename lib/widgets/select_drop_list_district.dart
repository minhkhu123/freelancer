import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/widgets/custom_textinput_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/drop_list_model_form.dart';
import 'package:get/get.dart';

class SelectDropListDistrict extends StatefulWidget {
  final String title;
  final String error;

  SelectDropListDistrict({Key key, this.title, this.error});

  @override
  _SelectDropListDistrictState createState() =>
      _SelectDropListDistrictState();
}

class _SelectDropListDistrictState extends State<SelectDropListDistrict>
    with SingleTickerProviderStateMixin {
  RegisterController _registerController = Get.put(RegisterController());

  AnimationController expandController;
  Animation<double> animation;

  bool isShow = false;

  _SelectDropListDistrictState();

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
      child: Column(
        children: <Widget>[
          CustomEditTextFreelancerRecruitment(
            hintText: _registerController.chooseDistrict.value ? widget.title : 'Chọn quận/huyện',
            textError: widget.error,
            onPress: () {
              setState(() {
                this.isShow = !this.isShow;
                _runExpandCheck();
              });
            },
          ),
          SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: animation,
              child: Container(
                  height: height * 0.35,
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
                    itemCount: _registerController.listDistrict.length,
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
                                    child: Text(_registerController.listDistrict[index].name,
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
                              _registerController.indexDistrict.value = int.parse(_registerController.listDistrict[index].id);
                              _registerController.nameDistrict.value = _registerController.listDistrict[index].name;
                              _registerController.chooseDistrict.value = true;
                              _registerController.showDistrict();
                              isShow = false;
                              expandController.reverse();
                              print(_registerController.listDistrict[index].id);
                            },
                          ),
                        ),
                  ))),
        ],
      ),
    );
  }
}
