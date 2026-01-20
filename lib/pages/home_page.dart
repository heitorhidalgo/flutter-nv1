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
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Heitor"),
              accountEmail: Text("teste@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.purple,
                child: Text("H"),
              ),
            ),
            ListTile(
              title: Text("item 1"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                _pageController.jumpToPage(0);
                Navigator.pop(context);
                setState(() {
                  indexBottomNavigationBar = 0;
                });
              },
            ),
            ListTile(
              title: Text("item 2"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                _pageController.jumpToPage(1);
                setState(() {
                  indexBottomNavigationBar = 1;
                });
              },
            ),
            ListTile(
              title: Text("item 3"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                _pageController.jumpToPage(2);
                setState(() {
                  indexBottomNavigationBar = 2;
                });
              },
            ),
          ],
        ),
      ),
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
            page,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
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
