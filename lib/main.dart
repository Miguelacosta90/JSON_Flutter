import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// https://jsonplaceholder.typicode.com/posts
void main() async{
  List _data = await getJSON();
  print(_data[1]["title"]);
  for(var i = 0; i < _data.length; i++) {
    print("Data: ${_data[i] ["title"]}");
  }


    runApp(new MaterialApp(
      home:new Scaffold(
        appBar: AppBar(
          title: Text("Json Parsin"),
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
            itemCount: _data.length,
            
            padding: const EdgeInsets.all(5.5),
            itemBuilder: (BuildContext context, int position){
                return Column(
                  children: <Widget>[
                    Divider(height: 17.5,),
                    ListTile(
                     title: Text("Title: ${_data[position]["title"]}",
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold,
                      )),

//                     // this is for the body of text for JSON paring
//                      subtitle: Text(_data[position]["body"],
//                      style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        fontSize: 10.5
//                      ),),

                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text(_data[position]["title"][0]),
                      ),
                      onTap: () => showTapMessage(context, _data[position]["body"]),
                    ),
                  ],
                );
            }
        ),
      )
    ));
}
void showTapMessage(BuildContext context, String message){
    var alertDialog = new AlertDialog(
      title: Text(message),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("ok"),
        ),
      ],
    );
        showDialog(context: context, builder:( context){
          return alertDialog;
        });
}
Future<List> getJSON() async{
    String apiUrl = "https://jsonplaceholder.typicode.com/posts";

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
}