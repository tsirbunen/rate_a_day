import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';

class TextInfo extends StatelessWidget {
  final String? primary;
  final String? secondary;
  const TextInfo({Key? key, this.primary, this.secondary}) : super(key: key);

  Widget _buildPrimaryText(final BuildContext context, final String text) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
      child: Text(text,
          style: themeData.textTheme.headline5
              ?.copyWith(color: themeData.colorScheme.primary)),
    );
  }

  Widget _buildSecondaryText(final BuildContext context, final String text) {
    final ThemeData themeData = Theme.of(context);
    return Text(
      text,
      textAlign: TextAlign.center,
      style: themeData.textTheme.bodyText1
          ?.copyWith(color: themeData.colorScheme.secondary),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(primary != null || secondary != null,
        'Either primary or secondary text must be provided for INFO TEXT');

    return SizedBox(
      width: ScreenSizeUtil.getInfoTextWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (primary != null) _buildPrimaryText(context, primary!),
          if (secondary != null) _buildSecondaryText(context, secondary!),
        ],
      ),
    );
  }
}
