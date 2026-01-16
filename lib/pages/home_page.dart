import 'package:flutter/material.dart';
import 'package:flutter_nv1/pages/page_one.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();

  int indexBottomNavigationBar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App bar')),
      body: PageView(
        controller: _pageController,
        children: [
          PageOne(),
          Container(color: Colors.red),
          Container(color: Colors.yellow),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavigationBar,
        onTap: (int page) {
          setState(() {
            indexBottomNavigationBar = page;
          });
          _pageController.animateToPage(
            page, duration: Duration(milliseconds: 300), curve: Curves.ease);
          },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'item 1'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'item 2'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'item 3'),
        ],
      ),
    );
  }
}
