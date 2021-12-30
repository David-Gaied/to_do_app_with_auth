import 'package:flutter/material.dart';
import 'package:to_do_app/api/api_integration.dart';
import 'package:to_do_app/reusable_widgets/reuse.dart';

class DoneNotes extends StatefulWidget {
  @override
  _DoneNotesState createState() => _DoneNotesState();
}

class _DoneNotesState extends State<DoneNotes> {
  List<Todo> _todos = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    _completedItems();
  }

  _completedItems() async {
    _todos = await API().checkItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber,
        title: Text("Done Notes"),
      ),
      body: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            final todo = _todos[index];

            return Card(
              elevation: 15,
              color: Colors.amber,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todo.title!,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                ],
              ),
            );
          }),
    );
  }
}
