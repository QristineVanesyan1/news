import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/screens/news_list.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StroiesProvider(
        child: MaterialApp(
      title: 'Hacker news',
      home: NewsList(),
    ));
  }
}
