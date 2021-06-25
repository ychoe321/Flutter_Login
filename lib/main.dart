import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_login/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: FutureBuilder(
      //   future: _fbApp,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       print('You have an error! ${snapshot.error.toString()}');
      //       return Text('Something went wrong!');
      //     } else if (snapshot.hasData) {
      //       return MyHomePage(title: 'LOGIN');
      //     } else {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // )
      home: App(),
    );
  }
}
