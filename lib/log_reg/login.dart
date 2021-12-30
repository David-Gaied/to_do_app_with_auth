import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_app/api/api_integration.dart';
import 'package:to_do_app/log_reg/register.dart';
import 'package:to_do_app/reusable_widgets/reuse.dart';
import 'package:to_do_app/screens/dashboard.dart';
import 'package:connectivity/connectivity.dart';
import 'package:to_do_app/screens/reuseable_dashboard.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailControler = TextEditingController();
  var passwordControler = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future login() async {
    if (emailControler.text.isNotEmpty && passwordControler.text.isNotEmpty) {
      // if(emailControler.text==body['email'] && passwordControler.text==body['password'][{'${API.token}'}]){
      print("iam here");
      try {
        print("iam here......");
        var response;
        response = await http.post(Uri.parse('http://10.0.2.2:8000/api/login'),
            headers: <String, String>{
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            },
            body: jsonEncode({
              "email": emailControler.text,
              "password": passwordControler.text
            }));
        print("iam here num 2");
        print(response.statusCode);

        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);
          API.token = await body["token"];

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Dashboard()));
        }
        print(response.statusCode);
        print("00");
        print(response.body);
      } catch (e, trace) {
        log(e.toString());
        log(trace.toString());
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Wrong Email or password")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Login"),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              child: Form(
                  key: _formKey,
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
                      sizeBox(15.0),
                      Text("Password"),
                      sizeBox(5.0),
                      TextFormField(
                        controller: passwordControler,
                        obscureText: true,
                        autofocus: false,
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
                      ),
                      sizeBox(10.0),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult !=
                                        ConnectivityResult.mobile &&
                                    connectivityResult !=
                                        ConnectivityResult.wifi) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("no internet connection")));
                                } else {
                                  login();

                                }
                              }
                            },
                            child: Text("Login")),
                      ),
                      sizeBox(5.0),
                      TextButton(
                        child: const Text("Forgot password?",
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        onPressed: () {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("If you don\'t have an account ?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                              },
                              child: Text("Sing Up"))
                        ],
                      )
                    ],
                  )),
            ),
          )),
    );
  }
}
