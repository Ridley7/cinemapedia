import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_bymovie_provider.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  const MovieScreen({super.key, required this.movieId});

  final String movieId;
  static const name = "movie-screen";

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsBymovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          //Appbar gigante que se desplaza
          _CustomSliverAppBar(movie: movie),

          SliverList(delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie: movie),
              childCount: 1
          ),
          )
        ],
      ),
    );
  }
}


class _MovieDetails extends StatelessWidget {
  const _MovieDetails({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final textStyles = Theme
        .of(context)
        .textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Imagen
              Image.network(
                movie.posterPath,
                width: size.width * 0.3,
              ),

              const SizedBox(width: 10,),

              //Descripcion
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    Text(movie.overview),
                  ],
                ),
              )

            ],
          ),
        ),

        //Generos de la pelicula
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) =>
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),

        //Aqui van los actores
        _ActorsByMovie(movieId: movie.id.toString()),

        const SizedBox(height: 50,)

      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  const _ActorsByMovie({
    super.key, required this.movieId,
  });

  final String movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, List<Actor>> actorsByMovie = ref.watch(
        actorsBymovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2,);
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (BuildContext context, int index) {
            Actor actor = actors[index];
            return Container(
              padding: const EdgeInsets.all(8.0),
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Foto
                  FadeInRight(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        actor.profilePath,
                        height: 180,
                        width: 135,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //Nombre
                  const SizedBox(height: 5,),

                  Text(actor.name, maxLines: 2,),
                  Text(actor.character ?? '', maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),)
                ],
              ),
            );
          }
      ),
    );
  }
}


class _CustomSliverAppBar extends StatelessWidget {
  const _CustomSliverAppBar({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border_outlined)
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(
          children: [

            //Poster o background
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),

            //Gradiente inferior
            const CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.8, 1.0],
                color: [
                  Colors.transparent,
                  Colors.black54
                ]
            ),

            //Gradiente izquierdo
            const CustomGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.2],
                color: [
                  Colors.black87,
                  Colors.transparent
                ]
            ),

            //Gradiente derecho
            const CustomGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.0, 0.2],
                color: [
                  Colors.black54,
                  Colors.transparent
                ]
            ),

          ],
        ),
      ),
    );
  }
}

class CustomGradient extends StatelessWidget {
  const CustomGradient(
      {super.key, required this.begin, required this.end, required this.stops, required this.color});

  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin,
                  end: end,
                  stops: stops,
                  colors: color
              )
          )
      ),
    );
  }
}

