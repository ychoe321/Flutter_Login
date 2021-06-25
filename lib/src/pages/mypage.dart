import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Mypage extends StatelessWidget {
  const Mypage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Page"),
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome.\n${FirebaseAuth.instance.currentUser!.email}'),
              ElevatedButton(
                  onPressed: FirebaseAuth.instance.signOut,
                  child: Text('Logout')),
            ],
          ))),
        ],
      ),
    );
  }
}
