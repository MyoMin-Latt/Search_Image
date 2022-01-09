import 'package:flutter/material.dart';
import 'package:search_image_p1/result/result_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  TextEditingController _searchTextEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Images by Pixabay'),
        actions: [
          Text(DateTime.now().toString())
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
                contentPadding: EdgeInsets.all(10),
                label: Text('Enter name'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context){
                    return ResultPage(_searchTextEC.text);
                  })
                );
              }, 
              child: const Text('Serach')
            )
          ],
        ),
      ),
    );
  }
}