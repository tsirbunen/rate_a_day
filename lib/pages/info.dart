import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/widgets.dart';

class Info extends StatelessWidget {
  static const routeName = '/info';

  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(),
          body: Center(
            child: Column(
              children: [
                Text('info'),
              ],
            ),
          )),
    );
  }
}
