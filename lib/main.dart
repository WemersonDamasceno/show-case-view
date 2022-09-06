import 'dart:developer';

import 'package:application_test/pages/my_home_page.dart';
import 'package:application_test/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: ShowCaseWidget(
          blurValue: 1,
          enableAutoScroll: true,
          onStart: (index, key) {
            log('onStart: $index, $key');
          },
          onComplete: (index, key) {
            log('onComplete: $index, $key');
            SharedPref().save('showcase', true);
          },
          builder: Builder(
            builder: (context) => const MyHomePage(title: "ShowCase Demo"),
          ),
        ),
      ),
    );
  }
}
