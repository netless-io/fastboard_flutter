import 'package:flutter/material.dart';

import 'custom_layout.dart';
import 'page.dart';
import 'quick_start.dart';

final List<FastExamplePage> _allPages = <FastExamplePage>[
  const QuickStartPage(),
  const CustomLayoutPage(),
];

void main() {
  const bool isProduction = bool.fromEnvironment('dart.vm.product');
  if (isProduction) {
    debugPrint = (String? message, {int? wrapWidth}) => null;
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('FFastboard'),
          ),
          body: ListView.builder(
            itemCount: _allPages.length,
            itemBuilder: (appContext, index) => ListTile(
              leading: _allPages[index].leading,
              title: Text(_allPages[index].title),
              onTap: () => _pushPage(appContext, _allPages[index]),
            ),
          )
          // body: _allPages[0],
          ),
    );
  }

  void _pushPage(BuildContext context, FastExamplePage page) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (_) => Scaffold(
              body: page,
              // prevent resize, when the keyboard appears
              resizeToAvoidBottomInset: false,
            )));
  }
}
