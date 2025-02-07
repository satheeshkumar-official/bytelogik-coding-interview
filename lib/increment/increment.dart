import 'package:bytelogik/login,register/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class CountNotifier extends StateNotifier<int> {
  CountNotifier() : super(0);

  void setPreviousCount(int value) => state = value;
  void increment() => state++;
}
final countProvider =
    StateNotifierProvider<CountNotifier, int>((ref) => CountNotifier());

class Bytelogik extends ConsumerStatefulWidget {
  final String uid;
  Bytelogik({required this.uid});

  @override
  _BytelogikState createState() => _BytelogikState();
}

class _BytelogikState extends ConsumerState<Bytelogik> {
  int previouscount = 0;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        previouscount = userDoc['count'] ?? 0;
      });
      ref.read(countProvider.notifier).setPreviousCount(0);
    }
  }

  void incrementcount() async {
    ref.read(countProvider.notifier).increment();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .update({
      'count': ref.read(countProvider),
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentcount = ref.watch(countProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('homepage'),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Color.fromARGB(255, 238, 229, 183),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("The page shows your previous and current count values:"),
            SizedBox(height: 10),
            Text('Previous count value: $previouscount',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Current count value: $currentcount',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 224, 199, 14)),
              ),
              onPressed: incrementcount,
              child: Text('Increment Count',
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Loginn()));
                },
                icon: Icon(Icons.logout_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
