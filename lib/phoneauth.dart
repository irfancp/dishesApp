
// ignore_for_file: prefer_function_declarations_over_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class SignIn extends StatefulWidget {
  @override
  _SignIn_State createState() => _SignIn_State();
}

// ignore: camel_case_types
class _SignIn_State extends State<SignIn> {
  bool verifyWidget = false;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  String? mobileNumber;

  String _verificationId = '';

  // final AuthService _auth = AuthService();
  final _formKeynumber = GlobalKey<FormState>();
  final _formKeyverify = GlobalKey<FormState>();



  Future<void> _verifyPhoneNumber() async {


    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await auth.signInWithCredential(phoneAuthCredential);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Phone number verified successfully'),
      ));
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
         // ignore: prefer_const_constructors
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
            'Phone number verification failed'),
      ));
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please check your phone for otp.'),
      ));
      _verificationId = verificationId;
      setState(() {
        verifyWidget = true;
      });
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    try {
      await auth.verifyPhoneNumber(
          phoneNumber: '+91${phoneNumberController.text}',
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to Verify Phone Number'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        // backgroundColor: Colors.amber[600],
        body: verifyWidget == false
            ? SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: height / 7),
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKeynumber,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          // Container(
                          //   margin: EdgeInsets.all(30),
                          //   height: 100,
                          //   width: 100,
                          //   child:
                          //    Image.asset(
                          //     'images/syllabuslogo.png',
                          //   ),
                          // ),
                          // Text(
                          //   "Welcome",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 20,
                          //       fontFamily: 'Montserrat'),
                          // ),
                          const Text(
                            "Please enter your mobile number",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset('images/indiaflag.png')),
                              Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: const Text(
                                    "+91",
                                    style: TextStyle(fontSize: 16),
                                  )),
                              SizedBox(
                                // margin: EdgeInsets.only(top: 30),
                                height: 70,
                                width: width / 2,
                                child: TextFormField(
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  controller: phoneNumberController,
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the mobile number';
                                    } else if (value.length < 10) {
                                      return 'Mobile number must be 10 digits';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.amber[600],
                                    hintText: "9400 650 888",
                                    contentPadding: const EdgeInsets.only(top: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            // style: blackButton,
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKeynumber.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Verifying..please wait')));
                                _formKeynumber.currentState!.save();
                                _verifyPhoneNumber();
                              }
                            },
                            child: const Text('Continue'),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: height / 2),
                  child: Center(
                    child: Column(children: [
                      Container(
                        height: 40,
                        width: 120,
                        child: Form(
                          key: _formKeyverify,
                          child: TextFormField(
                            controller: codeController,
                            keyboardType: TextInputType.number,
                             maxLength: 6,
                          
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the otp';
                              } else if (value.length < 6)
                                return 'otp must have 6 digits';
                          

                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.amber[600],
                              hintText: "enter OTP",

                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          // style: blackButton,
                          onPressed: () async {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKeyverify.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Signing you in')));
                              _formKeyverify.currentState!.save();
                              try {
                                PhoneAuthCredential credential =
                                    PhoneAuthProvider.credential(
                                        verificationId: _verificationId,
                                        smsCode: codeController.text);

                                // Sign the user in (or link) with the credential
                                await auth.signInWithCredential(credential);
                              
                               

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Successfully logged in'),
                                ));
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text('Failed to Verify Phone Number: $e'),
                                ));
                              }
                            }
                          },
                          child: Text('Continue'),
                        ),
                      ),
                    ]),
                  ),
                ),
              ));
  }
}