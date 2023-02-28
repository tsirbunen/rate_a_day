import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

class ContentTitle extends StatelessWidget with Constants {
  final String text;
  final double width;
  ContentTitle({Key? key, required this.text, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle style = StyleUtil.contentTitle(themeData);

    return Container(
      width: width,
      margin: EdgeInsets.only(bottom: paddingXS, top: paddingL),
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
        style: style,
      ),
    );
  }
}
