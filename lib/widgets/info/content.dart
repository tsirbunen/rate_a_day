import 'package:flutter/material.dart';
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

class Content extends StatelessWidget {
  final int index;
  final PageController pageController;
  final void Function(int) handleContentPageChanged;
  const Content({
    Key? key,
    required this.index,
    required this.pageController,
    required this.handleContentPageChanged,
  }) : super(key: key);

  Widget _buildDescriptions(
      final BuildContext context, final List<Phrase> descriptions) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      children: descriptions.map((final Phrase phrase) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
          child: Text(
            context.translate(phrase),
            textAlign: TextAlign.left,
            style: themeData.textTheme.bodyText1
                ?.copyWith(color: themeData.colorScheme.secondary),
          ),
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

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.65,
      child: PageView.builder(
        itemCount: 3,
        controller: pageController,
        onPageChanged: handleContentPageChanged,
        itemBuilder: (final BuildContext context, final int pageIndex) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
            width: MediaQuery.of(context).size.width * 0.5,
            child: Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ContentTitle(text: context.translate(itemData.title)),
                    ],
                  ),
                  _buildDescriptions(context, itemData.descriptions)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
