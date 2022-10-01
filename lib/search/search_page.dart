import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:search_image_p1/result/result_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchTextEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('search_image')),
        actions: [
          Center(
              child: Text(
            DateFormat('d/ MM/ yyyy').format(DateTime.now()),
            style: const TextStyle(fontSize: 17),
          ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchTextEC,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  label: Text(tr('enter_name')),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(),
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ResultPage(_searchTextEC.text);
                  }));
                },
                child: Text(tr('search')))
          ],
        ),
      ),
    );
  }
}
