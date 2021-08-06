
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login/src/pages/forget_pw.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signin extends StatelessWidget {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn googleSignin = GoogleSignIn();

  void _signUp() async {
    if (_formkey.currentState!.validate()) {  
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
            sendVerificationEamil();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void _signIn() async {
    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  Future<UserCredential> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignin.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Future<UserCredential> _signInWithFacebook() async {
  //   // ignore: omit_local_variable_types
  //   final AccessToken result =
  //       (await FacebookAuth.instance.login() as AccessToken);
  //   final facebookAuthCredential =
  //       FacebookAuthProvider.credential(result.token);

  //   return await FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential);
  // }

  Future<void> sendVerificationEamil() async {
    if (FirebaseAuth.instance.currentUser!= null && FirebaseAuth.instance.currentUser!.emailVerified==false) {
    
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();

    Fluttertoast.showToast(msg: 'Please verify your email');
    }

  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Stack(
          children: <Widget>[
            _inputForm(context),
            _authButton(deviceWidth, deviceHight),
            _snsButton(deviceWidth, deviceHight),
          ],
        ));
  }

  Widget _inputForm(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            key: ValueKey('email'),
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
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
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgetPw()));
              },
              child: Text('Forgot Password'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _authButton(deviceWidth, deviceHight) => Positioned(
        left: deviceWidth * 0.3,
        right: deviceWidth * 0.2,
        bottom: deviceHight * 0.5,
        child: Row(
          children: <Widget>[
            ElevatedButton(
              onPressed: _signIn,
              child: Text('Login'),
            ),
            Container(
              width: deviceWidth * 0.05,
            ),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
          ],
        ),
      );

  Widget _snsButton(deviceWidth, deviceHight) => Positioned(
        left: deviceWidth * 0.2,
        right: deviceWidth * 0.2,
        bottom: deviceHight * 0.45,
        child: Column(
          children: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: _signInWithGoogle,
              child: Text('Sign In with Google'),
            ),
            // ignore: deprecated_member_use
            // FlatButton(
            //   onPressed: _signInWithFacebook,
            //   child: Text('Sign In with Facebook'),
            // ),
            Container(
              width: deviceWidth * 0.05,
            ),
          ],
        ),
      );
}
