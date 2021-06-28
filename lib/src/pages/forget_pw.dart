import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPw extends StatefulWidget {
  @override
  _ForgetPwState createState() => _ForgetPwState();
}

class _ForgetPwState extends State<ForgetPw> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Forget Password'),
        ),
        body: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please input corrent email.';
                    }
                    return null;
                  },
                ),
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () async {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailController.text);
                      final snackBar = SnackBar(
                        content: Text('Check your email for password reset'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text('Reset Password'))
              ],
            )));
  }
}
