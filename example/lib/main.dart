import 'package:fastboard_flutter_example/page.dart';
import 'package:fastboard_flutter_example/quick_start.dart';
import 'package:flutter/material.dart';

final List<FastExamplePage> _allPages = <FastExamplePage>[
  const QuickStartPage(),
];

void main() {
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
          title: const Text('Fastboard'),
        ),
        body: ListView.builder(
          itemCount: _allPages.length,
          itemBuilder: (appContext, index) => ListTile(
            leading: _allPages[index].leading,
            title: Text(_allPages[index].title),
            onTap: () => _pushPage(appContext, _allPages[index]),
          ),
        ),
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
