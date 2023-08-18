import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();

  void _addItem(String item) {
    FirebaseFirestore.instance.collection('items').add({
      'name': item,
      'available': true,
    });
    _textController.clear();
    Navigator.of(context).pop();
  }

  Widget _buildItem(DocumentSnapshot item) {
    return Dismissible(
      key: Key(item.id),
      onDismissed: (direction) {
        FirebaseFirestore.instance.collection('items').doc(item.id).delete();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Item deleted')));
      },
      child: ListTile(
        title: Text(item['name']),
        trailing: Switch(
          value: item['available'],
          onChanged: (bool newValue) {
            FirebaseFirestore.instance
                .collection('items')
                .doc(item.id)
                .update({'available': newValue});
          },
        ),
      ),
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

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: TextField(
                  controller: _textController,
                  decoration: InputDecoration(hintText: 'Enter an item')),
              actions: <Widget>[
                TextButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop()),
                TextButton(
                    child: Text('Add'),
                    onPressed: () => _addItem(_textController.text))
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
          onPressed: _showDialog, tooltip: 'Add Item', child: Icon(Icons.add)),
    );
  }
}
