import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesRepository{

  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopularMovies({int page = 1});

  Future<List<Movie>> getUpcomingMovies({int page = 1});

  Future<List<Movie>> getTopratedMovies({int page = 1});

  Future<Movie> getMovieById( String movieId);

}