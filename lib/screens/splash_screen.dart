import 'package:flutter/material.dart';
import 'package:to_do_app/log_reg/login.dart';
import 'package:to_do_app/screens/dashboard.dart';
import 'package:to_do_app/screens/reuseable_dashboard.dart';

class SplashSCreen extends StatefulWidget {
  const SplashSCreen({Key? key}) : super(key: key);

  @override
  _SplashSCreenState createState() => _SplashSCreenState();
}

class _SplashSCreenState extends State<SplashSCreen> {
  @override
  void initState() {
    handleSplash();
    super.initState();
  }
  handleSplash() async {
    await Future.delayed(Duration(seconds: 4));

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Login()));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Image.asset("images/spash.jpg"),
      ),
    ));
  }
}
