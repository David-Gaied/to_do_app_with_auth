import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:to_do_app/api/api_integration.dart';
import 'package:to_do_app/reusable_widgets/reuse.dart';
import 'package:http/http.dart' as http;

class ShowItems extends StatefulWidget {
  final Todo? todo;
  ShowItems({this.todo});
  @override
  _ShowItemsState createState() => _ShowItemsState();
}

class _ShowItemsState extends State<ShowItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text("My Notes"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          reusableCard(
              colors: Colors.amber,
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              dbl: 15,
              wig1: Column(
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
                                widget.todo!.title!,
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
                ],
              )),
        ]),
      ),
    );
  }
}
