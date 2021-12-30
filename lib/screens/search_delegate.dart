import 'package:flutter/material.dart';
import 'package:to_do_app/api/api_integration.dart';
import 'package:to_do_app/reusable_widgets/reuse.dart';
import 'package:to_do_app/screens/show_items_in_specific_page.dart';

class Search extends SearchDelegate<String> {
  Search({required this.searching});
  List<SearchModel> searching = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print(query);
    List<SearchModel> filterName =
        searching.where((element) => element.title!.startsWith(query)).toList();
    return ListView.builder(
        itemCount: query == "" ? searching.length : filterName.length,
        itemBuilder: (context, index) {
          final todo = searching[index];

          return query == ""
              ? Text(
                  todo.title![index],
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900),
                )
              : Container(
                  child: Text(
                    filterName.length.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print("searching");
    print(searching);

    print(query);
    List<SearchModel> filterName =
        searching.where((element) => element.title!.contains(query)).toList();

    return ListView.builder(
        itemCount: filterName.length,
        itemBuilder: (context, index) {
          final todo = filterName[index];

          return Container(
            padding: EdgeInsets.all(10),
            child: Card( elevation: 15,

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                todo.title.toString(),
                textAlign: TextAlign.left,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
          );
        });
  }
}
