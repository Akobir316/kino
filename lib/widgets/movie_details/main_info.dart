import 'package:flutter/material.dart';
import 'package:kino/resources/resources.dart';

class MainInfoWidget extends StatelessWidget {
  const MainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopPosterWidget(),
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          child: Image(
            image: AssetImage(AppImages.film),
            fit: BoxFit.cover,
          ),
        ),
        Image.asset(AppImages.logo)
      ],
    );
  }
}
