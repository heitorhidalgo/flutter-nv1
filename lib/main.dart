import 'package:flutter/material.dart';
import 'package:flutter_nv1/second_page.dart';
import 'one_page.dart';


main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      home: OnePage(),
      initialRoute: '',
      routes: {
        '': (_) => OnePage(),
        '/secondPage': (_) => SecondPage(),
      },
    );
  }
}
