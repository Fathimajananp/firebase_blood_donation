import 'package:firebase/screens/add.dart';
import 'package:firebase/screens/home.dart';
import 'package:firebase/screens/update.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      debugShowCheckedModeBanner: false,

      // home: HomeScreen(),
      routes: {
        '/' : (context) => HomeScreen(),
        '/add' : (context) => AddUser(),
        '/update': (context) => UpdateDonor(),
      },
      initialRoute: '/',
    );
  }
}

