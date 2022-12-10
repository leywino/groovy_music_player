import 'package:firstproject/widgets/navbar.dart';
import 'package:flutter/material.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    navigateToHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 80),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

navigateToHome(BuildContext ctx) async {
  await Future.delayed(const Duration(milliseconds: 1500), () {
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const NavBarBottom(),
      ),
    );
  });
}
