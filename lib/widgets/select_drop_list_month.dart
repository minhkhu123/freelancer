import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer_app/common/images.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'drop_list_model_month.dart';

class SelectDropListMonth extends StatefulWidget {
  final OptionItemMonth itemSelectedMonth;
  final DropListModelMonth dropListModelMonth;
  final Function(OptionItemMonth optionItemMonth) onOptionSelectedMonth;

  SelectDropListMonth(this.itemSelectedMonth, this.dropListModelMonth, this.onOptionSelectedMonth);

  @override
  _SelectDropListMonthState createState() => _SelectDropListMonthState(itemSelectedMonth, dropListModelMonth);
}

class _SelectDropListMonthState extends State<SelectDropListMonth> with SingleTickerProviderStateMixin {
  OptionItemMonth optionItemSelectedMonth;
  final DropListModelMonth dropListModelMonth;

  AnimationController expandController;
  Animation<double> animation;

  bool isShow = false;

  _SelectDropListMonthState(this.optionItemSelectedMonth, this.dropListModelMonth);

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
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
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
                        optionItemSelectedMonth.title,
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
                  constraints: BoxConstraints(
                    minHeight: 100
                  ),
                  margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26, offset: Offset(0, 2))],
                    color: Colors.white,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                      children: [_buildDropListOptions(dropListModelMonth.listOptionItemsMonth, context)]))),
        ],
      ),
    );
  }

  Column _buildDropListOptions(List<OptionItemMonth> items, BuildContext context) {
    return Column(
      children: items.map((itemMonth) => _buildSubMenu(itemMonth, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItemMonth itemMonth, BuildContext context) {
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
                  border: Border(top: BorderSide(color: Colors.grey[200], width: 1)),
                ),
                child: Text(itemMonth.title,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.hintText),
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
        onTap: () {
          this.optionItemSelectedMonth = itemMonth;
          isShow = false;
          expandController.reverse();
          widget.onOptionSelectedMonth(itemMonth);
        },
      ),
    );
  }
}
