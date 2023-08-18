import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class StationeryPage extends StatefulWidget {
  final List<String> items;
  final String title;

  StationeryPage({required this.items, required this.title});

  @override
  _StationeryPageState createState() => _StationeryPageState();
}

class _StationeryPageState extends State<StationeryPage> {
  Widget _buildItem(DocumentSnapshot item) {
    return ListTile(
      title: Text(item['name'],
          style:
              TextStyle(color: item['available'] ? Colors.green : Colors.red)),
    );
  }

  Widget _buildList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('items').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) =>
              _buildItem(snapshot.data!.docs[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // Use the title from the widget
        actions: [
          IconButton(
            icon: Icon(Icons.admin_panel_settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: _buildList(),
    );
  }
}
