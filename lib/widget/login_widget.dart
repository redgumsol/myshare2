import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshare/main.dart';
import 'package:myshare/utils/utils.dart';

// Test git comment

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final formKey = GlobalKey<FormState>();
  // TODO Remove placeholder values from authentication text boxes
  final emailController    = TextEditingController(text: 'aa@gmail.com');
  final passwordController = TextEditingController(text: 'abcd1234');
  // final emailController    = TextEditingController();
  // final passwordController = TextEditingController();
  String authMessage = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 60),
          FlutterLogo(size: 120),
          SizedBox(height: 20),
          Text(
            'Hey There,\n Welcome Back',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Email'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
              email != null && !EmailValidator.validate(email)
                ? 'Enter a valid email'
                : null,
          ),
          SizedBox(height: 4),
          TextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != null && value.length < 8
                ? 'Password minimum length is 8 characters'
                : null,
          ),
          SizedBox(height: 8),
          Text(
            authMessage,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.red),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            icon: Icon(Icons.lock_open, size: 32),
            label: Text(
              'Sign In',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: signIn,
          ),
        ],
      ),
    ),
  );

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      print(e.message);

      setState(() {
        authMessage = "Sorry, the provided Email and Password combination were not accepted";
      });
    }

    // Navigator.of(context) not working!
    // Hide the loading indicator when no longer required.
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
