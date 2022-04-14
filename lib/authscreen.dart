import 'package:dishes/phoneauth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'home.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.blue,
              ),
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                children: [
                  const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Future<UserCredential> signInWithGoogle() async {
                          // Trigger the authentication flow
                          final GoogleSignInAccount? googleUser =
                              await GoogleSignIn().signIn();

                          // Obtain the auth details from the request
                          final GoogleSignInAuthentication? googleAuth =
                              await googleUser?.authentication;

                          // Create a new credential
                          final credential = GoogleAuthProvider.credential(
                            accessToken: googleAuth?.accessToken,
                            idToken: googleAuth?.idToken,
                          );

                          // Once signed in, return the UserCredential
                          return await FirebaseAuth.instance
                              .signInWithCredential(credential);
                        }

                        // signInWithGoogle().then((value) {
                        //   if (value.user != null) {
                                  Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => const HomePage()));
                            
                          // }
                        // });
                      },
                      child: const Text(
                        "Google",
                        style: TextStyle(color: Colors.white),
                      )),
                  const Spacer(),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.blue,
              ),
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                children: [
                  const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () async {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SignIn()));
                      },
                      child: const Text(
                        "Phone",
                        style: TextStyle(color: Colors.white),
                      )),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
