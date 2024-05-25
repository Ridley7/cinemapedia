

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/initial_loading_provider.dart';
import 'package:cinemapedia/presentation/widgets/widgets_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers_barrel.dart';

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

    final bool initialLoading = ref.watch(initialLoadingProvider);

    if(initialLoading) return const FullScreenLoader();

    final List<Movie> slideShowMovies = ref.watch(moviesSlideshowProvider);
    final List<Movie> peliculasEnCartelera = ref.watch(nowPlayingProvider);
    final List<Movie> peliculasPopulares = ref.watch(popularMoviesProvider);
    final List<Movie> peliculasProximas = ref.watch(upcomingMoviesProvider);
    final List<Movie> peliculasMejorVotadas = ref.watch(topratedMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: 10),
            title: CustomAppBar(),
          ),
        ),


        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MoviesSlideShow(movies: slideShowMovies),
                MovieHorizontalListview(
                  movies: peliculasEnCartelera,
                  title: "En cartelera",
                  subtitle: "Lunes 20",
                  loadNextPage:
                  ref.read(nowPlayingProvider.notifier).loadNextPage,
                ),
                MovieHorizontalListview(
                  movies: peliculasPopulares,
                  title: "Populares",
                  loadNextPage:
                  ref.read(popularMoviesProvider.notifier).loadNextPage,
                ),
                MovieHorizontalListview(
                  movies: peliculasProximas,
                  title: "Proximamente",
                  loadNextPage:
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage,
                ),
                MovieHorizontalListview(
                  movies: peliculasMejorVotadas,
                  title: "De siempre",
                  loadNextPage:
                  ref.read(topratedMoviesProvider.notifier).loadNextPage,
                ),

                const SizedBox(height: 10,)
              ],
            );
          }, childCount: 1),
        ),

      ],
    );
  }
}
