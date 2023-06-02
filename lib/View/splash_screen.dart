import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:settle_up_expenses/View/tab_bar.dart';

import 'create_account_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.repeat(reverse: true);
    checkUserLoggedIn(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void checkUserLoggedIn(BuildContext context) async {
    User? user = _auth.currentUser;
    await Future.delayed(
        const Duration(seconds: 2)); // Add a delay for splash screen

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TabBarScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CreateAccount()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.asset(
                  'assets/Rectangle.png', // Replace with your PNG file path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // const SpinKitDoubleBounce(
            //   color: Colors.blue,
            //   size: 40.0,
            // ),
          ],
        ),
      ),
    );
  }
}
