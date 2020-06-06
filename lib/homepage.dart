import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tutorialfetchdata/search_page.dart';
import 'post_model.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Post> _posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello World'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx)=> SearchPage(posts: _posts,)
              ));
            },
          )
        ],
      ),

      body: FutureBuilder(
        future: _getData(),
        builder: (ctx,snapshot){
          if(snapshot.connectionState ==  ConnectionState.waiting)
            return CircularProgressIndicator();
//
          return ListView.builder(
            itemBuilder: (ctx,i){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(_posts[i].title),
                    subtitle: Text(_posts[i].body),
                  ),
                  Divider(height: 0,)
                ],
              );
            },
            itemCount: _posts.length,
          );
        },
      ),
    );
  }

  Future<void> _getData() async{
    var url = 'https://jsonplaceholder.typicode.com/posts';
    http.get(url).then((data){
     return json.decode(data.body);
    }).then((data){
      for(var json in data){
        _posts.add(Post.fromJson(json));
      }
    }).catchError((e){
      print(e);
    });
  }
}
