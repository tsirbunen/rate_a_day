import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: Text(title,
          style: themeData.textTheme.headline3
              ?.copyWith(color: themeData.colorScheme.primary)),
    );
  }
}
