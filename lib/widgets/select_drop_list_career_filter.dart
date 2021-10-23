import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/screens/authens/register/register_controller.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/menu/menu_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/drop_list_model_city.dart';
import 'package:get/get.dart';

class SelectDropListCareerFilter extends StatefulWidget {

  final String title;

  SelectDropListCareerFilter({Key key, this.title});

  @override
  _SelectDropListCareerFilterState createState() => _SelectDropListCareerFilterState();
}

class _SelectDropListCareerFilterState extends State<SelectDropListCareerFilter>
    with SingleTickerProviderStateMixin {
  MenuController _menuController = Get.put(MenuController());
  RegisterController _registerController = Get.put(RegisterController());

  AnimationController expandController;
  Animation<double> animation;

  bool isShow = false;

  _SelectDropListCareerFilterState();

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
                          controller.chooseCareer.value ? widget.title : 'Chọn lĩnh vực',
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
                      _registerController.getSearchListCategoryFilter();
                    },
                    controller: _registerController.searchCategoryFilterTextEditingController,
                    // focusNode: focusNode,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: AppColors.white,
                        contentPadding: EdgeInsets.all(5),
                        filled: true,
                        hintText: 'Nhập lĩnh vực',
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
                    itemCount: _registerController.listSearchCategory.length,
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
                                    child: Text(_registerController.listSearchCategory[index].tenLinhVuc,
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
                              controller.indexCategory.value = int.parse(_registerController.listSearchCategory[index].maLinhVuc);
                              controller.nameCareer.value = _registerController.listSearchCategory[index].tenLinhVuc;
                              controller.chooseCareer.value = true;
                              controller.listTag.clear();
                              controller.chooseSkills.value = false;
                              controller.showSkills();
                              controller.getTagFromCategory(controller.indexCategory.value);
                              controller.showCareer();
                              isShow = false;
                              expandController.reverse();
                              print(_registerController.listCategory[index].maLinhVuc);
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
