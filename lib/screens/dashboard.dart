import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:to_do_app/api/api_integration.dart';
import 'package:to_do_app/drewer_routes/done_notes.dart';
import 'package:to_do_app/reusable_widgets/reuse.dart';
import 'package:to_do_app/screens/reuseable_dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:to_do_app/screens/search_delegate.dart';
import 'package:to_do_app/screens/show_items_in_specific_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard();

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Todo> _todos = [];
  List<SearchModel> _usersearch=[];
  String? q;
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    _fetch();
  }

  _fetch() async {
    _todos = await API().getItems();
    _usersearch = await API().searchItem(q);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          elevation: 15,
          child: Material(
            color: Colors.amberAccent,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(
                  height: 20,
                ),
                const TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hoverColor: Colors.blue,
                    border: OutlineInputBorder(),
                    labelText: "Search",
                    hintText: "Search",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                buildMenuItems(
                    text: "Notifications",
                    icon: Icons.notifications,
                    onClicked: () => navigator_pages(context, 0)),
                const SizedBox(
                  height: 15,
                ),
                buildMenuItems(
                    text: "Done Notes",
                    icon: Icons.done_outline,
                    onClicked: () => navigator_pages(context, 1)),
                const SizedBox(
                  height: 15,
                ),
                buildMenuItems(
                    text: "Upcomming Notes",
                    icon: Icons.upcoming,
                    onClicked: () => navigator_pages(context, 2)),
                const SizedBox(
                  height: 15,
                ),
                buildMenuItems(
                    text: "Pending",
                    icon: Icons.hourglass_bottom,
                    onClicked: () => navigator_pages(context, 3)),
                const SizedBox(
                  height: 15,
                ),
                buildMenuItems(
                    text: "Favorites Notes",
                    icon: Icons.favorite_border,
                    onClicked: () => navigator_pages(context, 4)),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1.5,
                ),
                const SizedBox(
                  height: 20,
                ),
                buildMenuItems(
                    text: "Manage Account",
                    icon: Icons.manage_accounts,
                    onClicked: () => navigator_pages(context, 5)),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              showSearch(context: context, delegate: Search(searching: _usersearch ));
            }, icon: const Icon(Icons.search))

            ,IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.account_circle_rounded,
                  color: Colors.black,
                  size: 30,
                )),
          ],
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: const Text(
            "To Do App",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //     decoration: InputDecoration(
            //       hintText: "Searsh",
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(15)),
            //     ),
            //     onTap: (){
            //       showSearch(context: context, delegate: Search());
            //     },
            //   ),
            // ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4),
                child: RefreshIndicator(onRefresh: ()async{},
                  child: ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        final todo = _todos[index];

                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ShowItems(
                                      todo: todo,
                                    )));
                          },
                          child: Card(
                            elevation: 15,
                            color: Colors.amber,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              todo.title!,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            const Text(
                                              "8/10/2021",
                                              style: TextStyle(
                                                fontSize: 15,
                                                //fontWeight: FontWeight.w900
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Checkbox(
                                          value: todo.completed,
                                          onChanged: (val) {
                                            todo.completed = val;
                                            if (val == true) {
                                              todo.completed != val;
                                             // completedTodos.add(todo);
                                            } else {
                                              todo.completed != val;
                                              //completedTodos.remove(todo);

                                            }
                                            setState(() {});
                                            List<Todo> completedTodos = [];
                                          }),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            var response = await http.delete(
                                                Uri.parse(
                                                    "https://jsonplaceholder.typicode.com/todos/${todo.id}"),
                                                body: jsonEncode({
                                                  "title": title.text,
                                                }));
                                            body = jsonDecode(response.body);
                                            log(response.statusCode.toString());
                                            log(response.body.toString());
                                            return jsonDecode(response.body);

                                            // var response = await http.delete(
                                            //     Uri.parse(
                                            //         "http://10.0.2.2:8000/api/items/${todo.id}"),
                                            //     headers: {
                                            //       ...API.headers,
                                            //       'Authorization':
                                            //           'Bearer ${API.token}'
                                            //     },
                                            //     body: jsonEncode({
                                            //       "title": title.text,
                                            //       "description":
                                            //           description.text
                                            //     }));
                                            // body =
                                            //     jsonDecode(response.body);
                                            // log(response.statusCode
                                            //     .toString());
                                            // log(response.body.toString());
                                            // return jsonDecode(
                                            //     response.body);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 35,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                              ],
                            ),
                          ),
                        ); //widget.todo!.title!

                        //   ListTile(
                        //   title: Text(snapshot.data! [index]["title"].toString()),
                        //   subtitle: Text(snapshot.data! [index]["description"].toString()),
                        //   trailing: IconButton(
                        //       onPressed: () {}, icon: Icon(Icons.delete)),
                        //   onTap: ()
                        //   {
                        //
                        //   },
                        // );
                      }),
                ),

                // ScaffoldMessenger.of(context)
                //     .showSnackBar(SnackBar(content: Text("Invalid")));
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ReUseDashboard()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
