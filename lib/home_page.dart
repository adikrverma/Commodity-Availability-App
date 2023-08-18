import 'package:flutter/material.dart';
import 'stationery_page.dart';
import 'kn_foods_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  void _navigateToStationery(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StationeryPage(
                title: 'Stationery',
                items: [],
              )),
    );
  }

  void _navigateToKNFoods(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => KnFoodsPage(title: 'KN Foods')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () => _navigateToStationery(context),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        border: Border.all(width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                        child: Text('📚 STATIONERY',
                            style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)))),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => _navigateToKNFoods(context),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        border: Border.all(width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                        child: Text('🍲 KN FOODS',
                            style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
