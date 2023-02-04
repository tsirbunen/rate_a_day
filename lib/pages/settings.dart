import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/widgets.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';

  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const CustomAppBar(),
          body: Center(
            child: Column(
              children: [
                Text('settings'),
              ],
            ),
          )),
    );
  }
}
