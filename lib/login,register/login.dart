import 'package:bytelogik/login,register/re.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bytelogik/increment/increment.dart';

final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
class Loginnotifier extends StateNotifier<bool> {
  Loginnotifier() : super(false);

  void login(WidgetRef ref, BuildContext context, String email,
      String password) async {
    state = true; 
    try {
      UserCredential userCredential =
          await ref.read(authProvider).signInWithEmailAndPassword(
                email: email.trim(),
                password: password.trim(),
              );

      String uid = userCredential.user!.uid;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Bytelogik(uid: uid)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')));
    }
    state = false; 
  }
}

final loginProvider =
    StateNotifierProvider<Loginnotifier, bool>((ref) => Loginnotifier());

class Loginn extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final isLoading = ref.watch(loginProvider); 

    return Scaffold(
      appBar: AppBar(title: Text('Login'), backgroundColor: Colors.amber),
      backgroundColor: Color.fromARGB(255, 238, 229, 183),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              onPressed: isLoading
                  ? null
                  : () => ref.read(loginProvider.notifier).login(
                      ref,
                      context,
                      emailController.text.trim(),
                      passwordController.text.trim()),
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text('Login', style: TextStyle(color: Colors.white)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Re())),
                child: Text('Register', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
