import 'package:flutter/material.dart';

class ContentTitle extends StatelessWidget {
  final String text;
  const ContentTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0, top: 20.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: themeData.textTheme.headline5
            ?.copyWith(color: themeData.colorScheme.primary),
      ),
    );
  }
}
