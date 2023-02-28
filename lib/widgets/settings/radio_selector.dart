import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

class RadioSelector<T> extends StatelessWidget with Constants {
  final Map<T, String> data;
  final void Function(T?) onSelected;
  final String title;
  final String info;
  final T currentValue;

  RadioSelector({
    Key? key,
    required this.data,
    required this.onSelected,
    required this.title,
    required this.info,
    required this.currentValue,
  }) : super(key: key);

  List<Widget> _buildRadioItems(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Color selectedColor = StyleUtil.radioSelected(themeData);
    final Color notSelectedColor = StyleUtil.radioNotSelected(themeData);

    List<Widget> items = [];

    data.forEach((final T value, final String label) {
      final Color color =
          value == currentValue ? selectedColor : notSelectedColor;
      final TextStyle style = StyleUtil.radioLabel(themeData, color);

      items.add(
        Row(
          children: [
            Transform.scale(
              scale: 1.5,
              child: Radio<T>(
                value: value,
                groupValue: currentValue,
                onChanged: onSelected,
                activeColor: selectedColor,
              ),
            ),
            Text(label, style: style),
          ],
        ),
      );
    });

    return items;
  }

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle titleStyle = StyleUtil.radioSelectorTitle(themeData);
    final TextStyle infoStyle = StyleUtil.radioInfo(themeData);

    return SizedBox(
      width: SizeUtil.getCalendarWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: paddingS),
            child: Text(title, style: titleStyle),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: paddingS, top: paddingXS, bottom: paddingXS),
            child: Text(info, style: infoStyle),
          ),
          Column(
            children: _buildRadioItems(context),
          ),
        ],
      ),
    );
  }
}
