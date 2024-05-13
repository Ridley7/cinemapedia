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
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topratedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> slideShowMovies = ref.watch(moviesSlideshowProvider);
    final List<Movie> peliculasEnCartelera = ref.watch(nowPlayingProvider);
    final List<Movie> peliculasPopulares = ref.watch(popularMoviesProvider);
    final List<Movie> peliculasProximas = ref.watch(upcomingMoviesProvider);
    final List<Movie> peliculasMejorVotadas = ref.watch(topratedMoviesProvider);

    return Column(
      children: [
        const CustomAppBar(),
        MoviesSlideShow(movies: slideShowMovies),
        /*
        MovieHorizontalListview(
          movies: peliculasEnCartelera,
          title: "En cartelera",
          subtitle: "Lunes 20",
          loadNextPage: ref.read(nowPlayingProvider.notifier).loadNextPage,
        ),

        MovieHorizontalListview(
          movies: peliculasPopulares,
          title: "Populares",
          loadNextPage: ref.read(popularMoviesProvider.notifier).loadNextPage,
        ),

        MovieHorizontalListview(
          movies: peliculasProximas,
          title: "Proximamente",
          loadNextPage: ref.read(upcomingMoviesProvider.notifier).loadNextPage,
        ),
*/
        MovieHorizontalListview(
          movies: peliculasMejorVotadas,
          title: "De siempre",
          loadNextPage: ref.read(topratedMoviesProvider.notifier).loadNextPage,
        ),


      ],
    );
  }
}
