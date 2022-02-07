import 'package:flutter/material.dart';
import 'package:flutter_crud_firestore/add_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_crud_firestore/edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddScreen()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: notes.orderBy('title').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading'));
            }
            return ListView(
              children: snapshot.data!.docs.map((note) {
                return Center(
                  child: Card(
                    child: ListTile(
                      title: Text(note['title']),
                      subtitle: Text(
                        note['description'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      onLongPress: () {
                        note.reference.delete();
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditScreen(note)),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
