import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

class ParagraphTitle extends StatelessWidget with Constants {
  final String title;
  ParagraphTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final double width = SizeUtil.getParagraphTextWidth(context);
    final TextStyle style = StyleUtil.paragraphTitle(themeData);

    return SizedBox(
      width: SizeUtil.getInfoTextWidth(context),
      child: Container(
        width: width,
        margin: EdgeInsets.only(top: paddingL, bottom: paddingS),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: style,
        ),
      ),
    );
  }
}
