import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/image/bg_login_smile.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Image.asset("assets/image/ic_smile_logo.png")
            )
          ],
        ),
      ),
    );
  }
}
