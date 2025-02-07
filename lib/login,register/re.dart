import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

final registerLoadingProvider = StateProvider<bool>((ref) => false);

class Re extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final isLoading = ref.watch(registerLoadingProvider);

    void register() async {
      ref.read(registerLoadingProvider.notifier).state = true;
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        String uid = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration Successful! Please Login.')));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Loginn()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration Failed: ${e.toString()}')));
      }
      ref.read(registerLoadingProvider.notifier).state = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.amber,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Loginn()));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      backgroundColor: Color.fromARGB(255, 238, 229, 183),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name')),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber)),
              onPressed: isLoading ? null : register,
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text('Register', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
