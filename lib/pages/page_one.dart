import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.green),
          child: Center(
            child: Text(
              'Hello World!',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
        Row(
          children: [
            Container(
              color: Colors.red,
              height: 100,
              width: 200,
              child: Center(
                child: Text(
                  'Texto 1',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              height: 100,
              width: 200,
              child: Center(
                child: Text(
                  'Texto 2',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
