import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

class RadioSelector<T> extends StatelessWidget {
  final Map<T, String> data;
  final void Function(T?) onSelected;
  final String title;
  final String info;
  final T currentValue;

  const RadioSelector({
    Key? key,
    required this.data,
    required this.onSelected,
    required this.title,
    required this.info,
    required this.currentValue,
  }) : super(key: key);

  List<Widget> _buildRadioItems(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    List<Widget> items = [];

    data.forEach((final T value, final String label) {
      final Color color = value == currentValue
          ? themeData.colorScheme.primary
          : themeData.colorScheme.secondaryContainer;
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
                activeColor: themeData.colorScheme.primary,
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
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(title, style: titleStyle),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
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
