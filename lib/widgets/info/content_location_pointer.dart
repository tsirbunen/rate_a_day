import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

class ContentLocationPointer extends StatelessWidget with Constants {
  final int currentIndex;
  ContentLocationPointer({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Color selectedColor = StyleUtil.contentSelected(themeData);
    final Color notSelectedColor = StyleUtil.contentNotSelected(themeData);
    final double size = SizeUtil.contentLocationPointer;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [0, 1, 2].map(
        (final int index) {
          final bool isShowing = index == currentIndex;
          final Color color = isShowing ? selectedColor : notSelectedColor;
          return Padding(
            padding: EdgeInsets.all(paddingS),
            child: Material(
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              elevation: elevation,
              child: SizedBox(
                width: size,
                height: size,
                child: Container(color: color),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
