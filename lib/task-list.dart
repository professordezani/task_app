import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskListPage extends StatelessWidget {
  var user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks de ${user?.displayName}'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/create");
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('uid', isEqualTo: user!.uid)
            .orderBy('title')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var docs = snapshot.data!.docs;

          return ListView(
            children: [
              for (var doc in docs)
                Dismissible(
                  key: Key(doc.id),
                  onDismissed: (_) {
                    doc.reference.delete();
                  },
                  background: Container(color: Colors.red),
                  child: Card(
                    child: CheckboxListTile(
                      title: Text(doc.data()["title"]),
                      value: doc.data()["done"],
                      onChanged: (value) {
                        doc.reference.update({"done": value});
                      },
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
