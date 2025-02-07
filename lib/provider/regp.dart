// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
// final registrationProvider = FutureProvider.family<void, Map<String, String>>((ref, userData) async {
//   final auth = ref.read(authProvider);
//   final firestore = FirebaseFirestore.instance;
//   UserCredential userCredential = await auth.createUserWithEmailAndPassword(
//     email: userData['email']!,
//     password: userData['password']!,
//   );
//   await firestore.collection('users').doc(userCredential.user!.uid).set({
//     'uid': userCredential.user!.uid,
//     'email': userData['email']!,
//     'name': userData['name']!,
//   });
// });
