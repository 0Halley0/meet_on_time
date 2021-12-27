import 'package:flutter/material.dart';
import 'package:meet_on_time/screens/home_page.dart';
import 'package:meet_on_time/utils/authentication.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

void main() {
  runApp(
    EasyDynamicThemeWidget(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future getUserInfo() async {
    await getUser();
    setState(() {});
    print(uid);
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MEET ON TIME',
      debugShowCheckedModeBanner: false,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: HomePage(),
    );
  }
}
