import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/screens/home/home_controller.dart';
import 'package:freelancer_app/screens/navigation/navigation_controller.dart';
import 'package:freelancer_app/widgets/drop_list_model_form.dart';
import 'package:get/get.dart';

class SelectDropListForm extends StatefulWidget {
  final OptionItemForm itemSelectedForm;
  final DropListModelForm dropListModelForm;
  final Function(OptionItemForm optionItemForm) onOptionSelectedForm;

  SelectDropListForm(
      this.itemSelectedForm, this.dropListModelForm, this.onOptionSelectedForm);

  @override
  _SelectDropListFormState createState() =>
      _SelectDropListFormState(itemSelectedForm, dropListModelForm);
}

class _SelectDropListFormState extends State<SelectDropListForm>
    with SingleTickerProviderStateMixin {
  OptionItemForm optionItemSelectedForm;
  final DropListModelForm dropListModelForm;

  AnimationController expandController;
  Animation<double> animation;

  bool isShow = false;

  _SelectDropListFormState(this.optionItemSelectedForm, this.dropListModelForm);

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
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) => Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
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
                          controller.nameForm.value,
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
                    child: _buildDropListOptions(
                        dropListModelForm.listOptionItemsForm, context))),
          ],
        ),
      ),
    );
  }

  Column _buildDropListOptions(
      List<OptionItemForm> items, BuildContext context) {
    return Column(
      children: items.map((item) => _buildSubMenu(item, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItemForm item, BuildContext context) {
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
                    border: Border(
                        top: BorderSide(color: Colors.grey[200], width: 1)),
                  ),
                  child: Text(item.title,
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
            this.optionItemSelectedForm = item;
            isShow = false;
            expandController.reverse();
            widget.onOptionSelectedForm(item);
            controller.nameForm.value = optionItemSelectedForm.title;
            controller.chooseForm.value = true;
            setState(() {});
          },
        ),
      ),
    );
  }
}
