import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myshare/model/fbuser.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  User? user = FirebaseAuth.instance.currentUser!;


    print (user.uid);


    // Create user object from Firebase user
    FBUser? _userFromFirebaseUser (User user) {
      user != null ? FBUser(userUid: user.uid) : null;
    }

    print('------------');
    print (_userFromFirebaseUser.toString().);
    print('------------');

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              color: Colors.blue,
              child: Center(
                child: Text(
                   "Admin Dashboard",
                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Signed In as',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              user.email!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "(uid: " + user.uid + ")",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.blue[300]),
            ),
            SizedBox(height: 8),
            Text(
              "(uid: " + _userFromFirebaseUser.toString() + ")",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.green[300]),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(Icons.arrow_back, size: 32),
              label: Text(
                'Sign Out',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), padding: EdgeInsets.all(5)),
                child: Icon(
                  Icons.add,
                  size: 50,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
