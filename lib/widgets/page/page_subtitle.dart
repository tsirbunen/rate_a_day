import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

class PageSubtitle extends StatelessWidget with Constants {
  final double widthFraction = 0.8;
  final String subtitle;
  PageSubtitle({Key? key, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final double width = MediaQuery.of(context).size.width * widthFraction;
    final TextStyle style = StyleUtil.pageSubtitle(themeData);

    return Container(
      width: width,
      margin: EdgeInsets.only(top: paddingXS, bottom: paddingL),
      child: Text(
        subtitle,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }
}
