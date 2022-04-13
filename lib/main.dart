import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_shortner/provider.dart';

import 'home_page.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

    ChangeNotifierProvider(create: (_)=> UrlShortenerState()),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
