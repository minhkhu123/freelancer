import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/widgets/custom_textinput_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/drop_list_model_sex.dart';

class SelectDropListSex extends StatefulWidget {
  final OptionItemSex itemSelected;
  final DropListModelSex dropListModel;
  final Function(OptionItemSex optionItemSex) onOptionSelected;
  final String error;

  SelectDropListSex(
      this.itemSelected, this.dropListModel, this.onOptionSelected, this.error);

  @override
  _SelectDropListSexState createState() =>
      _SelectDropListSexState(itemSelected, dropListModel);
}

class _SelectDropListSexState extends State<SelectDropListSex>
    with SingleTickerProviderStateMixin {
  OptionItemSex optionItemSelected;
  final DropListModelSex dropListModel;

  AnimationController expandController;
  Animation<double> animation;

  bool isShow = false;

  _SelectDropListSexState(this.optionItemSelected, this.dropListModel);

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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: <Widget>[
          CustomEditTextFreelancerRecruitment(
            hintText: optionItemSelected.title,
            id: optionItemSelected.id,
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
                      dropListModel.listOptionItems, context))),
        ],
      ),
    );
  }

  Column _buildDropListOptions(
      List<OptionItemSex> items, BuildContext context) {
    return Column(
      children: items.map((item) => _buildSubMenu(item, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItemSex item, BuildContext context) {
    return Padding(
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
          this.optionItemSelected = item;
          isShow = false;
          expandController.reverse();
          widget.onOptionSelected(item);
          setState(() {});
        },
      ),
    );
  }
}
