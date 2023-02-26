import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: SizeUtil.paddingSmall),
      child: Text(title,
          textAlign: TextAlign.center, style: themeData.textTheme.headline3),
    );
  }
}
