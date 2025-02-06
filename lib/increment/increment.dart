import 'package:bytelogik/login,register/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Bytelogik extends StatefulWidget {
  final String uid;
  Bytelogik({required this.uid});

  @override
  _BytelogikState createState() => _BytelogikState();
}

class _BytelogikState extends State<Bytelogik> {
  int previouscount = 0;
  int currentcount = 0;

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
        currentcount = 0;
      });
    }
  }

  void incrementcount() async {
    setState(() {
      currentcount += 1;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .update({
      'count':  currentcount,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text(
          'homepage',
        )),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Color.fromARGB(255, 238, 229, 183),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "the page show your previous count value and new count value:"),
            SizedBox(
              height: 10,
            ),
            Text('previous count value: $previouscount',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('current count value: $currentcount',
                style: TextStyle(
                  fontSize: 20,
                )),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 224, 199, 14))),
              onPressed: incrementcount,
              child: Text(
                'Increment Count',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Loginn()));
                },
                icon: Icon(Icons.logout_outlined),
              ),
            )
          ],
        ),
      ),
    );
  }
}
