import 'package:flutter/material.dart';
import 'package:to_do_app/log_reg/login.dart';
import 'package:to_do_app/screens/dashboard.dart';
import 'package:to_do_app/screens/search_delegate.dart';
import 'package:to_do_app/screens/reuseable_dashboard.dart';
import 'package:to_do_app/screens/single_todo.dart';
import 'package:to_do_app/screens/splash_screen.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   runApp( MyApp());
// }

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Dashboard(),
    );
  }
}
