import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

class ScrollBottom extends StatelessWidget {
  const ScrollBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double emptyEndSize = SizeUtil.emptyScrollEnd;

    return SizedBox(height: emptyEndSize);
  }
}
