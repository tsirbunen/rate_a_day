import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/localizations.dart';

enum Item {
  whatIsItAbout,
  evaluateDay,
  monthsEvaluations,
}

class ItemData {
  final Phrase title;
  final List<Phrase> descriptions;
  const ItemData({required this.title, required this.descriptions});
}

class Content extends StatelessWidget with Constants {
  final int index;
  final PageController pageController;
  final void Function(int) handleContentPageChanged;
  Content({
    Key? key,
    required this.index,
    required this.pageController,
    required this.handleContentPageChanged,
  }) : super(key: key);

  Widget _buildDescriptions(
      final BuildContext context, final List<Phrase> descriptions) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle style = StyleUtil.description(themeData);

    return Column(
      children: descriptions.map((final Phrase phrase) {
        return Padding(
          padding: EdgeInsets.only(bottom: paddingS, top: paddingS),
          child: Text(context.translate(phrase),
              textAlign: TextAlign.left, style: style),
        );
      }).toList(),
    );
  }

  _getItemData(final Item item) {
    switch (item) {
      case Item.whatIsItAbout:
        return const ItemData(
          title: Phrase.whatIsItAbout0,
          descriptions: [
            Phrase.whatIsItAbout1,
            Phrase.whatIsItAbout2,
          ],
        );

      case Item.evaluateDay:
        return const ItemData(
          title: Phrase.evaluateDay0,
          descriptions: [
            Phrase.evaluateDay1,
            Phrase.evaluateDay2,
            Phrase.evaluateDay3,
          ],
        );
      case Item.monthsEvaluations:
        return const ItemData(
          title: Phrase.monthsSummary0,
          descriptions: [
            Phrase.monthsSummary1,
            Phrase.monthsSummary2,
            Phrase.monthsSummary3,
            Phrase.monthsSummary4,
          ],
        );
      default:
        throw Exception('Item $item not implemented!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Item item = [
      Item.whatIsItAbout,
      Item.evaluateDay,
      Item.monthsEvaluations,
    ][index];
    final ItemData itemData = _getItemData(item);
    final double textScaleFactor =
        MediaQuery.maybeOf(context)?.textScaleFactor ?? 1.0;
    final double outerWidth = SizeUtil.getInfoPageItemMaxOuterWidth(context);
    final double innerWidth = SizeUtil.getInfoPageItemMaxOuterWidth(context);
    final double height = SizeUtil.getInfoPageItemMaxHeight(context);
    final double emptyEnd = SizeUtil.emptyScrollEnd;

    return SizedBox(
      width: outerWidth,
      height: height,
      child: PageView.builder(
        itemCount: 3,
        controller: pageController,
        onPageChanged: handleContentPageChanged,
        itemBuilder: (final BuildContext context, final int pageIndex) {
          return Container(
            margin: EdgeInsets.only(bottom: paddingS, top: paddingS),
            width: innerWidth,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: paddingL, right: paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ContentTitle(
                            text: context.translate(itemData.title),
                            width: outerWidth - 3 * paddingL),
                      ],
                    ),
                    _buildDescriptions(context, itemData.descriptions),
                    if (textScaleFactor > 1) SizedBox(height: emptyEnd)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
