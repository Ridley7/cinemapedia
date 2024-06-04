import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class PopularView extends ConsumerStatefulWidget {
  const PopularView({super.key});

  @override
  _PopularViewState createState() => _PopularViewState();
}

class _PopularViewState extends ConsumerState<PopularView> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ref.read(popularMoviesProvider.notifier).loadNextPage();
    final List<Movie> popularMovies = ref.watch(popularMoviesProvider);


    if(popularMovies.isEmpty){
      return const Center(child: CircularProgressIndicator(strokeWidth: 2,),);
    }

    return Scaffold(
      body: MovieMasonry(
        loadNextPage: ref.read(popularMoviesProvider.notifier).loadNextPage,
        //Esta es otra alternativa
        //loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
        movies: popularMovies,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


}
