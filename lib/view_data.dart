import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phpwork/main.dart';


class view_data extends StatefulWidget {
  const view_data({super.key});

  @override
  State<view_data> createState() => _view_dataState();
}

class _view_dataState extends State<view_data> {

  @override
  void initState(){

  }

  get()
  async {
    var url = Uri.parse('https://kevaljasani.000webhostapp.com/view_data.php');
    var response = await http.get(url);

    List l=jsonDecode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print(l);
    return l;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: FutureBuilder(future: get(),
        builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active){

          List m=snapshot.data as List;

          return ListView.builder(
            itemCount: m.length,
            itemBuilder: (context, index) {

              return Card(
                child: ListTile(
                  title: Text("${m[index]['name']}"),
                  subtitle: Text("${m[index]['contact']}"),
                  trailing: Wrap(
                    children: [

                      IconButton(onPressed: () async {

                        var url = Uri.parse('https://kevaljasani.000webhostapp.com/delete_data.php?id=${m[index]['id']}');
                        var response = await http.get(url);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');
                        setState(() {

                        });
                      }, icon: Icon(Icons.delete)),

                      IconButton(onPressed: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return first(m[index]['id'],m[index]['name'],m[index]['contact']);
                        },));
                      }, icon: Icon(Icons.edit))
                    ],
                  ),
                ),
              );
          },);
        }
        else
          {
            return CircularProgressIndicator();
          }
      },),
    );
  }
}
