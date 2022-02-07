import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  label: Text('title'),
                  border: OutlineInputBorder(),
                ),
                controller: titleController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  label: Text('description'),
                  border: OutlineInputBorder(),
                ),
                controller: descriptionController,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    notes.add({
                      'title': titleController.text,
                      'description': descriptionController.text,
                    });
                    titleController.clear();
                    descriptionController.clear();
                    const snackBar = SnackBar(
                      content: Text('Note Added'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
