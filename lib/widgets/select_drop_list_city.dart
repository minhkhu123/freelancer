import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/widgets/custom_textinput_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/drop_list_model_city.dart';
import 'package:get/get.dart';

class SelectDropListCity extends StatefulWidget {

  final String title;
  final String error;

  SelectDropListCity({Key key, this.title, this.error});

  @override
  _SelectDropListCityState createState() => _SelectDropListCityState();
}

class _SelectDropListCityState extends State<SelectDropListCity>
    with SingleTickerProviderStateMixin {
  RegisterController _registerController = Get.put(RegisterController());

  AnimationController expandController;
  Animation<double> animation;

  bool isShow = false;

  _SelectDropListCityState();

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
            hintText: _registerController.chooseCity.value ? widget.title : 'Chọn tỉnh/thành phố',
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
              margin: const EdgeInsets.only(left: 5, right: 5),
              // padding: const EdgeInsets.only(bottom: 10),
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.black26,
                      offset: Offset(0, 2))
                ],
                color: Colors.white,
              ),
              child: Center(
                child: TextField(
                  onChanged: (value) {
                    _registerController.getSearchListCity();
                  },
                  controller: _registerController.searchCityTextEditingController,
                  // focusNode: focusNode,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                  decoration: InputDecoration(
                      fillColor: AppColors.white,
                      contentPadding: EdgeInsets.all(5),
                      filled: true,
                      hintText: 'Nhập tỉnh thành phố',
                      hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.hintText),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                      ),
                      prefixIcon: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: SvgPicture.asset(
                            Images.ic_search,
                            color: AppColors.hintText,
                            height: 10,
                            width: 10,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Container(
              constraints: BoxConstraints(
                minHeight: 60,
                maxHeight: height * 0.35,
              ),
                // height: height * 0.35,
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
                  itemCount: _registerController.listSearchCity.length,
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
                              child: Text(_registerController.listSearchCity[index].name,
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
                        _registerController.indexCity.value = int.parse(_registerController.listSearchCity[index].id);
                        _registerController.nameCity.value = _registerController.listSearchCity[index].name;
                        _registerController.chooseCity.value = true;
                        _registerController.listDistrict.clear();
                        _registerController.chooseDistrict.value = false;
                        _registerController.showDistrict();
                        _registerController.getListDistrict();
                        _registerController.showCity();
                        isShow = false;
                        expandController.reverse();
                        print(_registerController.listCity[index].id);
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
