import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signin extends StatelessWidget {
  // const Signin({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // void _signUp() async {
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: "barry.allen@example.com", password: "SuperSecretPassword!");
  //     // _emailControllor =
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void _signIn() async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: "barry.allen@example.com", password: "SuperSecretPassword!");
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }

  void _signIn() {
    if (_formkey.currentState!.validate()) {
      print(_emailController.text.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Stack(
          children: <Widget>[
            _inputForm(),
            _authButton(),
          ],
        ));
  }

  Widget _inputForm() {
    return Form(
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
          TextFormField(
            obscureText: true, //hide password
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please input corrent email.';
              }
              return null;
            },
          ),
          Container(
            height: 10,
          ),
          Text('Forgot Password'),
          Container(
            height: 20,
          ),
          Text('Sign Up'),
          Container(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _authButton() => Positioned(
        left: 100,
        right: 100,
        bottom: 350,

        // ignore: deprecated_member_use
        child: RaisedButton(
          onPressed: _signIn,
          child: Text('Login'),
        ),
      );
}
