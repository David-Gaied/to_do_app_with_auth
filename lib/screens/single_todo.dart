import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowTimeAndDate extends StatefulWidget {
  ShowTimeAndDate({this.textDate,this.textTime});
  TextEditingController? textTime = TextEditingController();
  TextEditingController? textDate = TextEditingController();

  @override
  _ShowTimeAndDateState createState() => _ShowTimeAndDateState();
}

class _ShowTimeAndDateState extends State<ShowTimeAndDate> {
  final TextEditingController _textTime = TextEditingController();
  final TextEditingController _textDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select Date"),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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

          ],
        ),
      ),
    );
  }
}
