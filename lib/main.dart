import 'package:bytelogik/increment/increment.dart';
import 'package:bytelogik/login,register/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDC_qttfYyz9RoQUySi4Ydgwouyn-Liuo0",
  authDomain: "bytelogik-392e2.firebaseapp.com",
  projectId: "bytelogik-392e2",
  storageBucket: "bytelogik-392e2.firebasestorage.app",
  messagingSenderId: "469244652125",
  appId: "1:469244652125:web:179d7f1b8a92ca2e097bb4",
  measurementId: "G-SE2NVTRQ7L"
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Loginn(),
      debugShowCheckedModeBanner: false,
    );
  }
}


