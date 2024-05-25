import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/movie_themoviedb.dart';

class MovieMapper {
  static Movie movieDetailsToMovie(MovieDetails movieDetails) => Movie(
      adult: movieDetails.adult,
      backdropPath: movieDetails.backdropPath != ''
          ? "https://image.tmdb.org/t/p/w500${movieDetails.backdropPath}"
          : "https://ih1.redbubble.net/image.1893341687.8294/flat,750x,075,f-pad,750x1000,f8f8f8.jpg",
      genreIds: movieDetails.genres.map((e) => e.name).toList(),
      id: movieDetails.id,
      originalLanguage: movieDetails.originalLanguage,
      originalTitle: movieDetails.originalTitle,
      overview: movieDetails.overview,
      popularity: movieDetails.popularity,
      posterPath: movieDetails.posterPath != ''
          ? "https://image.tmdb.org/t/p/w500${movieDetails.posterPath}"
          : "https://www.movienewz.com/img/films/poster-holder.jpg",
      releaseDate: movieDetails.releaseDate,
      title: movieDetails.title,
      video: movieDetails.video,
      voteAverage: movieDetails.voteAverage,
      voteCount: movieDetails.voteCount);

  static Movie theMovieDbToMovie(MovieTheMovieDB movieDB) => Movie(
      adult: movieDB.adult,
      backdropPath: movieDB.backdropPath != ''
          ? "https://image.tmdb.org/t/p/w500${movieDB.backdropPath}"
          : "https://ih1.redbubble.net/image.1893341687.8294/flat,750x,075,f-pad,750x1000,f8f8f8.jpg",
      genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
      id: movieDB.id,
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      popularity: movieDB.popularity,
      posterPath: movieDB.posterPath != ''
          ? "https://image.tmdb.org/t/p/w500${movieDB.posterPath}"
          : "https://www.movienewz.com/img/films/poster-holder.jpg",
      releaseDate: movieDB.releaseDate != null ? movieDB.releaseDate! : DateTime.now(),
      title: movieDB.title,
      video: movieDB.video,
      voteAverage: movieDB.voteAverage,
      voteCount: movieDB.voteCount);
}
