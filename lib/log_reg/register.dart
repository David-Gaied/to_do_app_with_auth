import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_app/api/api_integration.dart';
import 'package:to_do_app/log_reg/login.dart';
import 'package:to_do_app/reusable_widgets/reuse.dart';
import 'package:to_do_app/screens/dashboard.dart';
import 'package:connectivity/connectivity.dart';

class Register extends StatefulWidget {
  static const headers = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  Future register() async {
    if (emailControler.text.isNotEmpty && passwordControler.text.isNotEmpty) {
      var response;
      try {
        var client = http.Client();

        response = await client.post(
          Uri.parse('http://10.0.2.2:8000/api/register'),
          headers: <String, String>{},
          body: {
            "email": emailControler.text,
            "name": nameControler.text,
            "password": passwordControler.text
          },
        );
      } catch (e, trace) {
        log(e.toString());
        log(trace.toString());
      }

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        API.token = await body["token"];
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid")));
      }

      // );

    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Registrations Page"),
        ),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizeBox(15.0),
                      Text("Email"),
                      sizeBox(5.0),

                      TextFormField(
                        controller: emailControler,
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: emailvalidator,
                        onSaved: (val) {
                          if (val == null) {
                            return;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: "Enter your Email",
                          hintText: "Email Adress",
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      sizeBox(5.0),

                      Text("Name"),
                      sizeBox(5.0),
                      TextFormField(
                        controller: nameControler,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: "Name",
                          hintText: "Enter your Name",
                        ),
                      ),
                      sizeBox(5.0),
                      const Text("Password"),
                      sizeBox(5.0),
                      TextFormField(
                        controller: passwordControler,
//autofocus: false,
                        keyboardType: TextInputType.visiblePassword,
                        validator: passwordvalidator,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "Enter your password",
                          labelText: "Enter Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(Icons.remove_red_eye),

//label:Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                      sizeBox(10.0),
                      // const Text("Confirm Password"),
                      // sizeBox(15.0),
                      // TextFormField(
                      //   autofocus: false,
                      //   validator: passwordvalidator,
                      //   onSaved: (val) => _confirmPassword = val,
                      //   decoration: buildInputDecorationPassword(
                      //       "Confirm Your Password",
                      //       Icons.lock,
                      //       Icons.remove_red_eye),
                      //   obscureText: true,
                      // ),
                      // sizeBox(10.0),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                var connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult !=
                                        ConnectivityResult.mobile &&
                                    connectivityResult !=
                                        ConnectivityResult.wifi) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text('No internet Connections'),
                                    ),
                                  );
                                } else {
                                  try {
                                    await register();
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                }
                              }

                              // 1- call api request to server
                              // 2- add data to request
                              // 3- receive response and check if success
                            },
                            child: Text("Register")),
                      ),
                      sizeBox(5.0),
                      TextButton(
                        child: const Text("Forgot password?",
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        onPressed: () {
                          //Navigator.pushReplacementNamed(context, '/reset-password');
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("If you have already account ?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                              child: Text("Login"))
                        ],
                      )
                    ],
                  )),
            ),
          );
        }),
      ),
    );
  }
}

//   _submit() {
//     // username
//     // password
//     http.
//   }
// }
