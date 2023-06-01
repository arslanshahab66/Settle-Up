import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:settle_up_expenses/View/account_settings_screen.dart';
import 'package:settle_up_expenses/View/create_account_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String? _userEmail;
  String? _userName;
  String? _userPhotoUrl;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _userEmail = user.email;
        _userName = user.displayName;
        _userPhotoUrl = user.photoURL;
      });
    } else {
      GoogleSignInAccount? googleUser = _googleSignIn.currentUser;
      if (googleUser != null) {
        setState(() {
          _userEmail = googleUser.email;
          _userName = googleUser.displayName;
          _userPhotoUrl = googleUser.photoUrl;
        });
      }
    }
  }

  void _logout(context) async {
    await _auth.signOut();
    await _googleSignIn.signOut();

    // Redirect to the login screen or any other desired screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CreateAccount()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = kToolbarHeight;
    final drawerHeaderHeight = screenHeight * 0.3;
    final drawerHeaderPadding = EdgeInsets.only(bottom: 5);

    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: drawerHeaderHeight,
              decoration: const BoxDecoration(
                color: Color(0xff5CAF9F),
              ),
              child: Padding(
                padding: drawerHeaderPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: _userPhotoUrl != null
                          ? NetworkImage(_userPhotoUrl!)
                              as ImageProvider<Object>?
                          : const AssetImage('assets/Lucy_stark.png'),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _userName ?? 'Lucy Stark',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _userEmail ?? 'LucyStark@gmail.com',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ListTile(
            //   leading: const Image(
            //     height: 25,
            //     image: AssetImage('assets/settings.png'),
            //   ),
            //   title: const Text('Settings'),
            //   trailing: const Image(
            //     height: 15,
            //     image: AssetImage('assets/forward_arrow.png'),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const AccountSettingsScreen(),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              leading: const Image(
                height: 25,
                image: AssetImage('assets/star.png'),
              ),
              title: const Text('Rate Splitwise'),
              trailing: const Image(
                height: 15,
                image: AssetImage('assets/forward_arrow.png'),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Image(
                height: 25,
                image: AssetImage('assets/telephone.png'),
              ),
              title: const Text('Contact us'),
              trailing: const Image(
                height: 15,
                image: AssetImage('assets/forward_arrow.png'),
              ),
              onTap: () async {
                final Uri params = Uri(
                  scheme: 'mailto',
                  path: 'arslanshahab66@gmail.com',
                  query: '',
                );

                if (await canLaunch(params.toString())) {
                  await launch(params.toString());
                } else {
                  throw 'Could not launch $params';
                }
              },
            ),
            ListTile(
              leading: const Image(
                height: 25,
                image: AssetImage('assets/turn-off.png'),
              ),
              title: const Text('Logout'),
              trailing: const Image(
                height: 15,
                image: AssetImage('assets/forward_arrow.png'),
              ),
              onTap: () {
                _logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
