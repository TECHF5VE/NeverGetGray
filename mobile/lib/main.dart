import 'package:flutter/material.dart';

// import 'main_menu_page/page.dart';
import 'log_in_page/page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) =>
      // MaterialApp(home: MainMenuPage().buildPage(<String, dynamic> {}));
      MaterialApp(home: LogInPage().buildPage(<String, dynamic> {}));
}
