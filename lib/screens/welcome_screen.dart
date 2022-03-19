import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/material_Button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
  static const String id = 'WelcomeScreen';
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
      // upperBound: 100,
    );

    // animation = CurvedAnimation(
    //   parent: animationController,
    //   curve: Curves.bounceInOut,
    // );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(animationController);

    animationController.forward();

    // animationController.addStatusListener(
    //   (status) {
    //     print(status);
    //     if (status == AnimationStatus.completed) {
    //       animationController.reverse(from: 1.0);
    //     } else if (status == AnimationStatus.dismissed) {
    //       animationController.forward();
    //     }
    //   },
    // );

    animationController.addListener(
      () {
        setState(() {});

        // print(animationController.value);
        // print(animation.value);
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red.withOpacity(animationController.value),
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    // height: animationController.value,
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  // ' ${animationController.value.toInt()}%',
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 16.0),
            //   child: MaterialButton(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     color: Colors.blue,
            //     onPressed: () {
            //       Navigator.pushNamed(context, LoginScreen.id);
            //     },
            //     elevation: 5.0,
            //     minWidth: 200.0,
            //     height: 50.0,
            //     child: Text(
            //       'Log In',
            //     ),
            //   ),
            // ),
            materialButton(
              colors: Colors.lightBlueAccent,
              onPress: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              text: 'login',
            ),
            materialButton(
              colors: Colors.blueAccent,
              onPress: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              text: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
