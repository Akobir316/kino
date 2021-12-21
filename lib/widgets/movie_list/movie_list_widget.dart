// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kino/resources/resources.dart';
import 'package:kino/widgets/navigation/main_navigation.dart';

class Movie {
  final int id;
  final String title;
  final String imageName;
  final String date;
  final String description;

  Movie(
      {required this.id,
      required this.title,
      required this.imageName,
      required this.date,
      required this.description});
}

class MovieListWidget extends StatefulWidget {
  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(
        id: 1,
        title: 'Akobir',
        imageName: AppImages.film,
        date: '9 may 2010',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem'),
  ];

  final _searchController = TextEditingController();

  var _filterMovies = <Movie>[];
  void _serchMovies() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filterMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filterMovies = _movies;
    }
    setState(() {});
  }

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.pushNamed(context, MainNavigationRouteNames.mavieDetails, arguments: id);
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filterMovies = _movies;
    _searchController.addListener(_serchMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            padding: EdgeInsets.only(top: 70),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: 10,
            itemExtent: 163,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 2)),
                          ]),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        children: [
                          Image.asset(AppImages.film),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Mortal Combat',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'April 7, 2021',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        onTap: () => _onMovieTap(index),
                      ),
                    ),
                  ],
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                labelText: 'Поиск',
                filled: true,
                fillColor: Colors.white.withAlpha(235),
                border: OutlineInputBorder()),
          ),
        ),
      ],
    );
  }
}
