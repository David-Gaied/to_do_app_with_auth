import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_app/api/api_integration.dart';

class ReUseDashboard extends StatefulWidget {
  const ReUseDashboard({Key? key}) : super(key: key);

  // final String? token;
  // ReUseDashboard({this.token});

  @override
  _ReUseDashboardState createState() => _ReUseDashboardState();
}

class _ReUseDashboardState extends State<ReUseDashboard> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  final TextEditingController _textTime = TextEditingController();
  final TextEditingController _textDate = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.amber,
          centerTitle: true,
          title: Text("Item List"),
        ),
        body: SingleChildScrollView(padding: EdgeInsets.only(right: 10,left: 10),
          child: Column(
            children: [
            const  SizedBox(
                height: 12,
              ),
              TextField(
                controller: title,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Title",
                  hintText: "Your Title",
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: description,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hoverColor: Colors.blue,
                  border: OutlineInputBorder(),
                  labelText: "Description",
                  hintText: "Your Descriptions",
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: _textDate,
                decoration: const InputDecoration(hintText: "Select Your Date",
                  hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2100),
                  );
                  setState(() {
                    if (date != null)
                    {
                      _textDate.text = "${date.day} / ${date.month} / ${date.year} ";
                    }
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Please Complete the Proccess")));
                    }
                  });
                },
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),


              ),
              const SizedBox(height: 20,),
              TextField(
                controller: _textTime,
                decoration: const InputDecoration(hintText: "Select Your Time",
                  hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  final time = await showTimePicker(context: context,
                      initialTime: TimeOfDay.now()
                  );
                  setState(() {
                    if (time != null)
                    {
                      _textTime.text = time.format(context);
                    }
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Please Complete the Proccess")));
                    }
                  });
                },
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),


              ),


              ElevatedButton(
                  onPressed: () async {
                    if (title.text.isNotEmpty && description.text.isNotEmpty) {
                      var response = await http.post(
                          Uri.parse("http://10.0.2.2:8000/api/addItem"),
                          headers: {
                            ...API.headers,
                            'Authorization': 'Bearer ${API.token}'
                          },
                          body: jsonEncode({
                            "title": title.text,
                            "description": description.text
                          }));
                      log(response.statusCode.toString());
                      log(response.body.toString());

                      Navigator.of(context).pop();
                    } else if (title.text.isEmpty || description.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Please Complete the Proccess")));
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
