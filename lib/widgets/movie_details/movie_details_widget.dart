import 'package:flutter/material.dart';
import 'package:kino/resources/resources.dart';
import 'package:kino/widgets/movie_details/main_info.dart';

class MovieDetailsWidget extends StatefulWidget {
  final movieId;
  const MovieDetailsWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  _MovieDetailsWidgetState createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppImages.logo),
        centerTitle: true,
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1.0),
        child: ListView(
          children: [
            // ignore: prefer_const_constructors
            MainInfoWidget(),
          ],
        ),
      ),
    );
  }
}
