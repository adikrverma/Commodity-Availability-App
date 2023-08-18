import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KnAdminPage extends StatefulWidget {
  final String title;

  KnAdminPage({required Key key, required this.title}) : super(key: key);

  @override
  _KnAdminPageState createState() => _KnAdminPageState();
}

class _KnAdminPageState extends State<KnAdminPage> {
  TextEditingController _nameController = TextEditingController();
  bool _available = true;

  void _addItem() {
    FirebaseFirestore.instance.collection('kn_admin').add({
      'name': _nameController.text,
      'available': _available,
    }).then((value) {
      setState(() {
        _nameController.clear();
        _available = true;
      });
    });
  }

  void _deleteItem(String id) {
    FirebaseFirestore.instance
        .collection('kn_admin')
        .doc(id)
        .delete()
        .then((value) => print('Item Deleted'))
        .catchError((error) => print('Failed to delete item: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: _available,
                onChanged: (newValue) {
                  setState(() {
                    _available = newValue ?? true;
                  });
                },
              ),
              Text('Available'),
            ],
          ),
          ElevatedButton(
            onPressed: _addItem,
            child: Text('Add Item'),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('kn_admin').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data!.docs[index];
                    return Dismissible(
                      key: Key(item.id),
                      onDismissed: (direction) {
                        _deleteItem(item.id);
                      },
                      background: Container(
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                      ),
                      child: ListTile(
                        title: Text(item['name']),
                        trailing: Switch(
                          value: item['available'],
                          onChanged: (newValue) {
                            FirebaseFirestore.instance
                                .collection('kn_admin')
                                .doc(item.id)
                                .update({'available': newValue});
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
