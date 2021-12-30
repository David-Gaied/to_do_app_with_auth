import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:to_do_app/drewer_routes/done_notes.dart';
import 'dart:convert';
import 'package:to_do_app/drewer_routes/favorites_notes.dart';
import 'package:to_do_app/drewer_routes/notifications.dart';

final emailvalidator = MultiValidator([
  EmailValidator(errorText: "Email Format is not valid"),
  RequiredValidator(errorText: "Email is Required")
]);
final passwordvalidator = MultiValidator([
  RequiredValidator(errorText: "Password is Required"),
  MinLengthValidator(8,
      errorText: "Password must contain at least 8 charachter"),
  PatternValidator(r'(?=.*?[!@#\$&*~])',
      errorText: "Password must contain at least one special charachter")
]);

sizeBox(double height) => SizedBox(
      height: height,
    );
// InputDecoration buildInputDecorationEmail( labelText, IconData icon) {
//   return InputDecoration(
//     prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
//     labelText: labelText,
//     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//     border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
//   );
// }
// InputDecoration buildInputDecorationPassword( labelText,IconData iconPre, IconData iconSuf ) {
//   return InputDecoration(
//     prefixIcon: Icon(iconPre, color: Color.fromRGBO(50, 62, 72, 1.0)),
//     suffixIcon: Icon(iconSuf, color: Color.fromRGBO(50, 62, 72, 1.0)),
//     labelText: labelText,
//     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//     border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
//   );
// }
var emailControler = TextEditingController();
var passwordControler = TextEditingController();
var nameControler = TextEditingController();
var title = TextEditingController();
var description = TextEditingController();

Widget reusableCard({
  //required String text,
  required Color colors,
  required Widget wig1,
  required ShapeBorder shapeBorder,
  required double dbl,
}) {
  return Card(
    shape: shapeBorder,
    color: colors,
    child: wig1,
    elevation: dbl,
  );
}
Widget buildMenuItems({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = Colors.black;
  final hoverColor = Colors.green;

  return ListTile(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    leading: Icon(
      icon,
      color: color,
      size: 25,
    ),
    title: Text(
      text,
      style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 25),
    ),
    hoverColor: hoverColor,
    onTap: () {
      onClicked!();
    },
  );
}

void navigator_pages(BuildContext context, int index) {
  if (index == 0) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Notifications()));
  } else if (index == 1) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DoneNotes()));
  } else if (index == 2) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Favorites()));
  } else if (index == 3) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Favorites()));
  } else if (index == 4) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Favorites()));
  } else if (index == 5) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Favorites()));
  }
}

// Todo TodoFromJson(String str) => Todo.fromJson(json.decode(str));
// String TodoToJson(Todo data) => json.encode(data.toJson());
// class Todo {
//   Todo({
//     this.id,
//     this.userId,
//     this.title,
//     this.description,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   int? id;
//   int? userId;
//   String? title;
//   String? description;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   factory Todo.fromJson(Map<dynamic, dynamic> json) => Todo(
//     id: json["id"],
//     userId: json["user_id"],
//     title: json["title"],
//     description: json["description"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<dynamic, dynamic> toJson() => {
//     "id": id,
//     "user_id": userId,
//     "title": title,
//     "description": description,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
Todo TodoFromJson(String str) => Todo.fromJson(json.decode(str));

String TodoToJson(Todo data) => json.encode(data.toJson());

class Todo {
  Todo({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  int? userId;
  int? id;
  String? title;
  bool? completed;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}


class SearchModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  SearchModel({this.userId, this.id, this.title, this.completed});

  SearchModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }
}
