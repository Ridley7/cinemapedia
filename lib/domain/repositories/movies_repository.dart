import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/video.dart';

abstract class MoviesRepository{

  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopularMovies({int page = 1});

  Future<List<Movie>> getUpcomingMovies({int page = 1});

  Future<List<Movie>> getTopratedMovies({int page = 1});

  Future<Movie> getMovieById( String movieId);

  Future<List<Movie>> searchMovies( String query);

  Future<List<Movie>> getSimilarMovies (int movieId);

  Future<List<Video>> getYoutubeVideosById( int movieId );

}