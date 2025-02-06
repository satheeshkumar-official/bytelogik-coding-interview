import 'package:bytelogik/increment/increment.dart';
import 'package:bytelogik/login,register/re.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loginn extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginn> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  void login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );

      String uid = userCredential.user!.uid;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Bytelogik(uid: uid)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'),backgroundColor: Colors.amber,),
      backgroundColor: Color.fromARGB(255, 238, 229, 183),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordcontroller,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 224, 199, 14))
              ),
              onPressed: login,
              child: Text('Login',style: TextStyle(color: Colors.white),),
            ),
            Align(alignment:  Alignment.centerRight,
              child: TextButton(
              style: ButtonStyle(
                alignment: Alignment.bottomRight
              ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Re()),
                  );
                },
                child: Text('Register',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
