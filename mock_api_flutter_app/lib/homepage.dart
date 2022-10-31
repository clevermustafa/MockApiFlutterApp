import 'dart:developer';

import 'package:flutter/material.dart';

import 'network/network_call.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NetworkCall networkCall = NetworkCall();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: networkCall.getFilms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List data = snapshot.data as List;
            return data.isNotEmpty?  ListView.separated(
              itemCount: data.length,
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemBuilder: (ctx, index) {
                return ListTile(
                  tileColor: Colors.teal,
                  title: Text(
                    data[index]['title'],
                  ),
                  subtitle: Text(
                    data[index]['director'],
                  ),
                );
              },
            ): Center(child: Text("Err"));
          } else {
            return Text("Error");
          }
        },
      ),
    );
  }
}
