import 'package:flutter/material.dart';
import 'post_model.dart';

class SearchPage extends StatefulWidget {
  final List<Post> posts;

  SearchPage({@required this.posts});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Post> _searchedPost = [];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search Post',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none
          ),
          onChanged: (val){
            setState(() {
              _searchedPost = widget.posts.where(
                  (el)=>el.title.contains(val)
              ).toList();
            });
          },
        ),
      ),

      body: _searchedPost.isEmpty ?
        Center(
          child: Text('No match',style: Theme.of(context).textTheme.headline3,),
        ):
      ListView.builder(
        itemCount: _searchedPost.length,
        itemBuilder: (ctx,i){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(_searchedPost[i].title),
                subtitle: Text(_searchedPost[i].body),
              ),
              Divider(height: 0,)
            ],
          );
        },
      ),
    );
  }
}
