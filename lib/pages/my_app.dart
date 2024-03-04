import 'package:article_add_proj/pages/add_article_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

/*
  Key widgetKey=UniqueKey();

  void resetWidget(){
      widgetKey = UniqueKey();
  }
*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddArticlePage(),

    );
  }
}
