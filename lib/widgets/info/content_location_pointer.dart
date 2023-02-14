import 'package:flutter/material.dart';

class ContentLocationPointer extends StatelessWidget {
  final int currentIndex;
  const ContentLocationPointer({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [0, 1, 2].map((final int index) {
        final bool isShowing = index == currentIndex;
        final Color color = isShowing
            ? themeData.colorScheme.primary
            : themeData.colorScheme.primaryContainer;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            elevation: 10.0,
            child: SizedBox(
              width: 15.0,
              height: 15.0,
              child: Container(color: color),
            ),
          ),
        );
      }).toList(),
    );
  }
}
