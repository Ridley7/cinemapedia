import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_navigation_bar.dart';

import 'package:cinemapedia/presentation/widgets/widgets_barrel.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = "home-screen";

  @override
  Widget build(BuildContext context) {
    //final List<Movie> getNowPlaying = ref.watch( nowPlayingProvider);

    return const Scaffold(
      body: HomeView(),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Llenamos el estado de valores
    ref.read(nowPlayingProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> peliculasEnCartelera = ref.watch(nowPlayingProvider);
    final List<Movie> slideShowMovies = ref.watch(moviesSlideshowProvider);

    return Column(
      children: [
        const CustomAppBar(),
        MoviesSlideShow(movies: slideShowMovies),
        MovieHorizontalListview(
          movies: peliculasEnCartelera,
          title: "Proximamente",
          subtitle: "Lunes 20",
        )
      ],
    );
  }
}
