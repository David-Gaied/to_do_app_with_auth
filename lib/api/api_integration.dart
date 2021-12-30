import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:to_do_app/reusable_widgets/reuse.dart';

var body;
var data = [];
List<SearchModel> todoSearch = [];

class API {
  static String token = '';
  static const headers = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };


  // functions  for Search model
  Future<List<SearchModel>> searchItem(String? query) async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await http.get(uri);
    print(response.statusCode);
    print(response.body);

    try {
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);

        todoSearch = data.map((e) => SearchModel.fromJson(e)).toList();
        if (query != null) {
          for (var item in body) {
            todoSearch.add(SearchModel(
                title: item['title']));
            log(response.body);
          }

          todoSearch = todoSearch
              .where((element) =>
                  element.title!.toLowerCase().contains(query.toLowerCase()))
              .toList();

        }
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } on Exception catch (e) {
      print(e);
    }

    return todoSearch;
  }

// Future getAllUsers() async {
//     var url = Uri.parse('http://10.0.2.2:8000/api/');
//     var response = await http.get(url, headers: headers);
//     body = jsonDecode(response.body);
//     return jsonDecode(response.body);
//   }
  Future showItem() async {
    var response = await http.post(Uri.parse("http://10.0.2.2:8000/api/items"),
        headers: {...API.headers, 'Authorization': 'Bearer ${API.token}'},
        body:
            jsonEncode({"title": title.text, "description": description.text}));

    // log(response.statusCode.toString());
    // log(response.body.toString());
    body = jsonDecode(response.body);
    return jsonDecode(response.body);
  }

//   Future<List<Todo>> getItems() async {
//     var uri = Uri.parse('http://10.0.2.2:8000/api/items');
//
//     var response = await http
//         .get(uri, headers: {...headers, 'Authorization': 'Bearer $token'});
//
//     log(response.body);
//     var todos = <Todo>[];
//     final body = jsonDecode(response.body) as List<dynamic>;
//     log("response.body");
//     log(response.body);
//     for (var item in body) {
//       todos.add(Todo(
//           id: item['id'],
//           title: item['title'],
//           description: item['description']));
//       log(response.body);
//
//   }
//     return todos;
//     // print(response.body);
//     // print(response.statusCode); list form todo >> foreach for this list >> insert object from todo for list
//   }
// }

  Future<List<Todo>> getItems() async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/todos');

    var response = await http.get(uri);
    log(response.body);
    var todos = <Todo>[];
    final body = jsonDecode(response.body);
    log("response.body");
    log(response.body);
    for (var item in body) {
      todos.add(Todo(
          id: item['id'], title: item['title'], completed: item['completed']));
      log(response.body);
    }
    return todos;
  }

  Future<List<Todo>> checkItems() async {
    var uri =
        Uri.parse('https://jsonplaceholder.typicode.com/todos?completed=true');

    var response = await http.get(uri);

    log(response.body);
    var todos = <Todo>[];
    final body = jsonDecode(response.body);
    log("response.body");
    log(response.body);
    for (var item in body) {
      todos.add(Todo(
          id: item['id'], title: item['title'], completed: item['completed']));
      log(response.body);
    }
    return todos;
    // print(response.body);
    // print(response.statusCode); list form todo >> foreach for this list >> insert object from todo for list
  }
}

// final aaa=   [
//      'a',
//      'b',
//      'c'
//    ];
// for (var i =0; i<aaa.length;i++)
// {
//   print(aaa[i]);
// }
//
// aaa.forEach((element)
// {
//   print(element);
//
// });
//
// for(var item in aaa)
// {
//   print(item);
//
// }

// body.forEach((element)
// {
//   // todos.add(Todo(id: ))
//
//
// });
//
//
//
// final z = {
//   "id": 60,
//   "user_id": 7,
//   "title": "new to do",
//   "description": "for study",
//   "created_at": "2021-10-08T21:56:07.000000Z",
//   "updated_at": "2021-10-08T21:56:07.000000Z"
// };
// print(z['id']);
