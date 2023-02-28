import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

class PageTitle extends StatelessWidget with Constants {
  final String title;
  PageTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle style = StyleUtil.pageTitle(themeData);

    return Container(
      margin: EdgeInsets.only(top: paddingS),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }
}
