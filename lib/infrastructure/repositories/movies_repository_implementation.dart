import 'package:cinemapedia/domain/datasources/movies_data_sources.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/video.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MoviesRepositoryImplementation extends MoviesRepository{

  final MoviesDataSources dataSource;

  MoviesRepositoryImplementation(this.dataSource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return dataSource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) {
    return dataSource.getPopularMovies(page: page);
  }

  @override
  Future<List<Movie>> getTopratedMovies({int page = 1}) {
    return dataSource.getTopratedMovies(page: page);
  }

  @override
  Future<List<Movie>> getUpcomingMovies({int page = 1}) {
    return dataSource.getUpcomingMovies(page: page);
  }

  @override
  Future<Movie> getMovieById(String movieId) {
    return dataSource.getMovieById(movieId);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return dataSource.searchMovies(query);
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) {
    return dataSource.getSimilarMovies(movieId);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) {
    return dataSource.getYoutubeVideosById(movieId);
  }

}