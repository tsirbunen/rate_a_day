import 'package:flutter/material.dart';

class ContentTitle extends StatelessWidget {
  final String text;
  final double width;
  const ContentTitle({Key? key, required this.text, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      width: width,
      margin: const EdgeInsets.only(bottom: 5.0, top: 20.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
        style: themeData.textTheme.headline4,
      ),
    );
  }
}
