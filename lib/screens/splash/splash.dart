import 'dart:async';

import 'package:embrapa/widgets/layout/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('dashboard');
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: false,
      bottomBar: false,
      body: Container(
        child: Center(
          child: Image.asset(
            'assets/png/logo.png',
            width: MediaQuery.of(context).size.width * 0.275,
          ),
        ),
      ),
    );
  }
}
