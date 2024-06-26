import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_project/core/config/Constants.dart';
import 'package:movies_project/features/home_screen/widgets/popular_movies_widget.dart';

import '../../../core/models/api_models.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as ApisCaller;
    return SafeArea(
      child: SizedBox(
        height: Constants.mediaQuery.height * 0.37,
        child: FutureBuilder(
          future: args.popularApi,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            var dataList = snapshot.data ?? [];
            return CarouselSlider.builder(
              itemCount: dataList.length,
              options: CarouselOptions(
                height: Constants.mediaQuery.height * 0.37,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 2),
                viewportFraction: 1,
                scrollDirection: Axis.horizontal,
              ),
              itemBuilder: (context, index, realIndex) => PopularMoviesWidget(
                popularMovies: dataList[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
