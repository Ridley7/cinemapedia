import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_implementation.dart';
import 'package:cinemapedia/presentation/providers/storage/local_storage_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final favoritesMovieProvider = StateNotifierProvider<StorageMovieNotifier, Map<int, Movie>>((ref){
  final LocalStorageRepositoryImplementation localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMovieNotifier(localStorageRepository: localStorageRepository);
});


class StorageMovieNotifier extends StateNotifier<Map<int, Movie>>{
  StorageMovieNotifier({required this.localStorageRepository}): super({});
  
  final LocalStorageRepository localStorageRepository;
  int page = 0;

  Future<List<Movie>> loadNextPages() async{
    final List<Movie> movies = await localStorageRepository.loadMovies(offset: page * 10, limit: 20);
    page++;

    //Convertimos lista a mapa
    final Map<int, Movie> tempMap = {};
    for(final movie in movies){
      tempMap[movie.id] = movie;
    }

    state = {...state, ...tempMap};

    return movies;
  }

  Future<void> toggleFavoriteMovie(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isFavoriteMovie = state[movie.id] != null;
    if(isFavoriteMovie){
      state.remove(movie.id);
      state = {...state};

    }else{
      state = {...state, movie.id: movie};
    }
  }



}


//family es para que acepte parametros
//El autoDispose destruye el estado del provider cuando ya no se usa.
//Es decir que cuando salimos de movie_screen este estado se destruye y cuando
//entramos se vuelve a construir haciendo una nueva peticion a la BD.
//Dandonos el ultimo valor que hay
final isFavoriteMovieProvider = FutureProvider.family.autoDispose((ref, int movieId){
  final movieRepository = ref.watch(localStorageRepositoryProvider);
  return movieRepository.isMovieFavorite(movieId);
});