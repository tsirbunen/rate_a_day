import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rate_a_day/packages/localizations.dart';

class Info extends StatefulWidget {
  static const routeName = '/info';
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> with Constants {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  final int _numberOfPages = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleContentPageChanged(final int newPage) {
    if (newPage >= _numberOfPages || newPage < 0) return;
    setState(() {
      _currentIndex = newPage;
    });
  }

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final String title = context.translate(Phrase.infoTitle);
    final String subtitle = context.translate(Phrase.infoSubtitle);
    final Color backgroundColor = StyleUtil.background(themeData);
    final bool showAppBar = SizeUtil.showAppBar(context);

    return SafeArea(
      child: Scaffold(
        appBar: showAppBar ? CustomAppBar() : null,
        body: Container(
          color: backgroundColor,
          padding: EdgeInsets.only(left: paddingL, right: paddingL),
          child: Column(
            children: [
              PageTitle(title: title),
              PageSubtitle(subtitle: subtitle),
              ContentLocationPointer(currentIndex: _currentIndex),
              Content(
                index: _currentIndex,
                pageController: _pageController,
                handleContentPageChanged: _handleContentPageChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
