import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WriteExample extends StatefulWidget {
  const WriteExample({super.key});

  @override
  State<WriteExample> createState() => _WriteExampleState();
}

class _WriteExampleState extends State<WriteExample> {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/124");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Write Example'),
        ),
        body: Column(
          children: [
            Text("test"),
            ElevatedButton(
                onPressed: () {
                  print("lets go");
                  ref
                      .set({"test": "please work"})
                      .then((_) => print("test test"))
                      .catchError((error) => print('Error $error'));
                },
                child: Text('write'))
          ],
        ));
  }
}
