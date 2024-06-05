import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

typedef SearchMovieCallback = Future Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMovieCallback searchMovieCallback;
  List<Movie> initialMovies;

  SearchMovieDelegate({required this.searchMovieCallback, required this.initialMovies});

  @override
  String get searchFieldLabel => "Buscar películas";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [

      StreamBuilder<bool>(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {

          if(snapshot.data ?? false){
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                  onPressed: () => query = '',
                  //Query es palabra reservada de Search Delegate
                  icon: Icon(Icons.refresh_rounded)),
            );
          }

            return FadeIn(
              animate: query.isNotEmpty,
              child: IconButton(
                  onPressed: () => query = '',
                  //Query es palabra reservada de Search Delegate
                  icon: Icon(Icons.clear)),
            );



        }
      )

      /*
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
            onPressed: () => query = '',
            //Query es palabra reservada de Search Delegate
            icon: Icon(Icons.clear)),
      )

       */
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
          //El null es para devolver cosas desde donde es llamado el search
          //delegate. Para mas claridad se tipa el SearchDelegate arriba
        },
        icon: Icon(Icons.arrow_back));
  }

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? debounceTimer;

  void clearStreams() {
    debouncedMovies.close();
    isLoadingStream.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    //2. Comprobamos que el timer esta activo y tiene valor, por lo tanto si
    //el debounceTimer es true se cancela
    if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();

    //Montamos nuevo timer y añadimos valores al stream
    debounceTimer = Timer(const Duration(milliseconds: 500), () async {


      //Llamamos pelis
      final List<Movie> movies = await searchMovieCallback(query);
      debouncedMovies.add(movies);

      //cambiamos el valor de initialMovies porque queremos evitar una doble
      //peticion http cuando se crean los resultados.
      //Cuando se ejecuta por ultima vez el metodo _onQueryChanged, es decir, cuando
      //el usuario presiona la ultima letra de la pelicula que va a buscar initialMovies
      //las peliculas que se han encontrado de guardan en initialMovies.
      //Debido a que puede pasar un tiempo no definido entre que el usuario presiona la
      //ultima tecla y le da al boton buscar en su teclado para que se ejecute este metodo
      //es bastante probable que el Stream que hay en builResults no tenga valores
      //para leer ya que ha pasado mucho tiempo y el stream montaria un widget con valores vacios.
      //De manera que si initialMovies ya tiene asignado valores, el stream puede crear la lista
      //de resultados con valores iniciales.
      initialMovies = movies;
      isLoadingStream.add(false);
    });
  }

  StreamBuilder _buildResultsAndSuggestions(){
    return StreamBuilder(
        initialData: initialMovies,
        stream: debouncedMovies.stream,
        builder: (BuildContext context, snapshot) {

          final List<Movie> movies = snapshot.data ?? [];

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return MovieSearchItem(
                    movie: movies[index],
                    onMovieSelected: (BuildContext context, Movie movie) {
                      clearStreams();
                      close(context, movie);
                    });
              });
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Para hacer que solo se efectue una peticion despues de 500 milisegundos
    //1. Evaluamos la query.
    _onQueryChanged(query);

    return _buildResultsAndSuggestions();
  }
}

typedef OnMovieSelectedCallback = void Function(
    BuildContext context, Movie movie);

class MovieSearchItem extends StatelessWidget {
  const MovieSearchItem({
    required this.movie,
    super.key,
    required this.onMovieSelected,
  });

  final Movie movie;
  final OnMovieSelectedCallback onMovieSelected;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: FadeIn(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            children: [
              
              //Imagen
              SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    height: 130,
                    fit: BoxFit.cover,
                    image: NetworkImage(movie.posterPath), 
                    placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                  ) 
                  /*
                  Image.network(movie.posterPath,
                      loadingBuilder: (context, child, loadingProgress) {
                    return FadeIn(child: child);
                  }),
                  
                  */
                ),
              ),
        
              const SizedBox(
                width: 10,
              ),
        
              //Descripcion
              SizedBox(
                width: size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyles.titleMedium,
                    ),
                    movie.overview.length > 100
                        ? Text('${movie.overview.substring(0, 100)}...')
                        : Text(movie.overview),
                    Row(
                      children: [
                        Icon(
                          Icons.star_half_outlined,
                          color: Colors.yellow.shade900,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          HumanFormats.number(movie.voteAverage, 1),
                          style: textStyles.bodyMedium!
                              .copyWith(color: Colors.yellow.shade900),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
