import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/storage/favorites_movie_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async{
    if(isLoading || isLastPage) return;
    isLoading = true;

    final List<Movie> movies = await ref.read(favoritesMovieProvider.notifier).loadNextPages();
    isLoading = false;

    if(movies.isEmpty){
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {

    final List<Movie> favoritesMovies = ref.watch(favoritesMovieProvider).values.toList();

    if(favoritesMovies.isEmpty){
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary,),
            Text('Oh noo!!', style: TextStyle(fontSize: 30, color: colors.primary),),
            const Text('No tienes películas favoritas', style: TextStyle(fontSize: 20, color: Colors.black45),),

            const SizedBox(height: 20),
            FilledButton.tonal(
                onPressed: () => context.go('/home/0'),
                child: const Text('Empieza a buscar')
            )

          ],
        ),
      );

    }

    return Scaffold(
      body: MovieMasonry(movies: favoritesMovies, loadNextPage: loadNextPage,)
    );
  }
}
