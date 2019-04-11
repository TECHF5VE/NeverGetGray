import 'package:flutter/material.dart';

import 'package:never_get_gray_mobile/app_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(
        home: AppRoute.global.buildPage(RoutePath.login, <String, dynamic>{})
      );
}
