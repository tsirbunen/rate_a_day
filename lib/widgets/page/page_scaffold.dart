import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';

class PageScaffold extends StatelessWidget {
  final Widget child;
  const PageScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Color backgroundColor = StyleUtil.background(themeData);
    final bool showAppBar = SizeUtil.showAppBar(context);

    return SafeArea(
      child: Scaffold(
        appBar: showAppBar ? CustomAppBar() : null,
        body: Container(
          color: backgroundColor,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                child,
                const ScrollBottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
