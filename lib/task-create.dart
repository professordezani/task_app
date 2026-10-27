import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskCreatePage extends StatelessWidget {
  TextEditingController txtTitle = TextEditingController();

  void save(BuildContext context) async {
    await FirebaseFirestore.instance.collection("tasks").add({
      "title": txtTitle.text,
      "done": false,
      "uid": FirebaseAuth.instance.currentUser?.uid,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            TextField(
              controller: txtTitle,
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Title",
              ),
            ),
            ElevatedButton(
              onPressed: () => save(context),
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
