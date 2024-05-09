import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{

  static String theMovieDbkey = dotenv.env["THE_MOVIE_DB"] ?? "No hay api Key";
}