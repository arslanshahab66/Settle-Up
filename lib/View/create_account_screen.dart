import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:settle_up_expenses/View/tab_bar.dart';


class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (_isSigningIn) {
                  setState(() {
                    _isSigningIn = false;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.58,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F5F5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 2.0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image(
                        image: const AssetImage('assets/Rectangle.png'),
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 15),
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 19.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Track Your',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: ' Expenses ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff5CAF9F),
                                ),
                              ),
                              TextSpan(
                                text: 'and',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: ' control',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff5CAF9F),
                                ),
                              ),
                              TextSpan(
                                text: ' your wallet everywhere',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const TabBarScreen(),
                //       ),
                //     );
                //   },
                //   child: reusebaleButton('Create Account', context),
                // ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100,
                        child: const Divider(
                          color: Color(0xff5CAF9F),
                          thickness: 1,
                        ),
                      ),
                      const Text(
                        'Continue Sign in with',
                        style: TextStyle(
                          fontSize: 15
                          ,
                          color: Color(0xff5CAF9F),
                        ),
                      ),
                      Container(
                        width: 100,
                        child: const Divider(
                          color: Color(0xff5CAF9F),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff5CAF9F),
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSigningIn = true;
                          });
                          signInWithGoogle().then((userCredential) {
                            if (userCredential != null) {
                              User? user = userCredential.user;
                              String? displayName = user?.displayName;
                              String? email = user?.email;
                              String? photoURL = user?.photoURL;
                              print('logged in.....');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TabBarScreen(),
                                ),
                              );
                            }
                            setState(() {
                              _isSigningIn = false;
                            });
                          });
                        },
                        child: Center(
                          child: Image.asset(
                            'assets/google_logo.jpg',
                            width: 30.0,
                            height: 30.0,
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // Container(
                    //   width: 60,
                    //   height: 60,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //       color: const Color(0xff5CAF9F),
                    //       width: 1.0,
                    //       style: BorderStyle.solid,
                    //     ),
                    //     borderRadius: BorderRadius.circular(10.0),
                    //   ),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       _loginWithFacebook();
                    //     },
                    //     child: Center(
                    //       child: Image.asset(
                    //         'assets/facebbok_logo.png',
                    //         width: 30.0,
                    //         height: 30.0,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Do you have an account? ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Log in',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff5CAF9F),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_isSigningIn)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Color(0xff5CAF9F),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (error) {
      print('Google Sign-In error: $error');
      return null;
    }
  }

  Future<void> _loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
      // Use the access token to authenticate with your backend or perform other actions
      print('Facebook Access Token: ${accessToken.token}');
    } else {
      print('Facebook login failed. ${result.message}');
    }
  }
}
