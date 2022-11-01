import 'dart:developer';

import 'package:flutter/material.dart';

import 'modal/film_modal.dart';
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
            List<FilmModal> data = snapshot.data as List<FilmModal>;
            return data.isNotEmpty
                ? ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(index: index + 1)));
                        },
                        child: ListTile(
                          tileColor: Colors.teal,
                          title: Text(data[index].title!),
                          subtitle: Text(data[index].director!),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text("Err"),
                  );
          } else {
            return Text("Error");
          }
        },
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final int index;
  const DetailPage({Key? key, required this.index}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  NetworkCall networkCall = NetworkCall();
  @override
  void initState() async {
    final result = networkCall.getFilmDetail(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
