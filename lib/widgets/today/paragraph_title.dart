import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

class ParagraphTitle extends StatelessWidget {
  final double widthFraction = 0.8;
  final String title;
  const ParagraphTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final double width = MediaQuery.of(context).size.width * widthFraction;
    final TextStyle style = StyleUtil.paragraphTitle(themeData);

    return SizedBox(
        width: SizeUtil.getInfoTextWidth(context),
        child: Container(
          width: width,
          margin: const EdgeInsets.only(top: 30.0, bottom: 10.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: style,
          ),
        ));
  }
}
