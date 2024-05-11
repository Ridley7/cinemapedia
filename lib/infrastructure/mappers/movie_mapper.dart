import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/movie_themoviedb.dart';

class MovieMapper {

  static Movie theMovieDbToMovie(MovieTheMovieDB movieDB) =>
      Movie(
          adult: movieDB.adult,
          backdropPath: movieDB.backdropPath != '' ? "https://image.tmdb.org/t/p/w500${movieDB.backdropPath}" : "https://ih1.redbubble.net/image.1893341687.8294/flat,750x,075,f-pad,750x1000,f8f8f8.jpg",
          genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
          id: movieDB.id,
          originalLanguage: movieDB.originalLanguage,
          originalTitle: movieDB.originalTitle,
          overview: movieDB.overview,
          popularity: movieDB.popularity,
          posterPath: movieDB.posterPath != '' ? "https://image.tmdb.org/t/p/w500${movieDB.posterPath}" : "no-poster",
          releaseDate: movieDB.releaseDate,
          title: movieDB.title,
          video: movieDB.video,
          voteAverage: movieDB.voteAverage,
          voteCount: movieDB.voteCount);

}