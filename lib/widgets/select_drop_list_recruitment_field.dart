import 'package:flutter/material.dart';
import 'package:freelancer_app/models/drop_list_model.dart';
import 'package:freelancer_app/widgets/custom_textinput_freelance_recruitment.dart';
import 'package:freelancer_app/widgets/item_drop.dart';

class SelectDropListRecruitmentField extends StatefulWidget {
  SelectDropListRecruitmentField({
    Key key,
    this.itemRecruitmentFieldSelect,
    this.listRecruitmentFieldModel,
    this.onOptionSelectRecruitmentField,
  }) : super(key: key);
  OptionItem itemRecruitmentFieldSelect;
  final DropListModel listRecruitmentFieldModel;
  final Function(OptionItem item)
      onOptionSelectRecruitmentField;

  @override
  _SelectDropListRecruitmentFieldState createState() =>
      _SelectDropListRecruitmentFieldState();
}

class _SelectDropListRecruitmentFieldState
    extends State<SelectDropListRecruitmentField>
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
    var width = MediaQuery.of(context).size.width;
    var optionItemSelected;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: <Widget>[
          CustomEditTextFreelancerRecruitment(
            hintText: widget.itemRecruitmentFieldSelect.title,
            onPress: () {
              this.isShow = !this.isShow;
              _runExpand();
              setState(() {});
            },
          ),
          SizeTransition(
            sizeFactor: animation,
            child: ItemDrop(
              width: width,
              title: widget.itemRecruitmentFieldSelect.title,
              list: widget.listRecruitmentFieldModel.listItem,
              onPress: (item) {
                widget.itemRecruitmentFieldSelect = item;
                animationController.reverse();
                widget.onOptionSelectRecruitmentField(item);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
