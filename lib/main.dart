import 'dart:developer';

import 'package:application_test/utils/shared_preferences.dart';
import 'package:application_test/widgets/showcase_widget.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _one = GlobalKey();
  final _two = GlobalKey();
  bool _showCase = true;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    showcase();
  }

  showcase() async {
    _showCase = await SharedPref().read('showcase') == null ? true : false;
    if (_showCase) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([_one, _two]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            CustomShowcase(
              keyGlobal: _one,
              showCase: _showCase,
              title: "Quantidade de cliques",
              description: "Este é o número de vezes que você clicou no botão",
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: CustomShowcase(
          keyGlobal: _two,
          showCase: _showCase,
          description: "Clique aqui para incrementar",
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
