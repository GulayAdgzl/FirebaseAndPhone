import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_full_learn/view/phoneview.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase/firebaseView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'glyadgzl',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 0,
          ),
        ),
        home: FutureBuilder(
            future: _initialization,
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Beklenmeyen hata'),
                );
              } else if (snapshot.hasData) {
                return FireBase(
                  title: 'Demo',
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })));
  }
}
