import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatelessWidget {
  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          //Titulos
          if (title != null || subtitle != null)
            _Title(
              title: title,
              subtitle: subtitle,
            ),

          //Peliculas
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
              return _Slide(movie: movies[index]);
            }),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({
    super.key, required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          //Imagen de pelicula
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress){
                  if(loadingProgress != null){
                    return const Padding(
                        padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2,),),
                    );
                  }
              
                  return FadeIn(child: child);
                }
              ),
            ),

          ),

          //Titulo
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),

          //Votaciones
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
                Text(movie.voteAverage.toString(), style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800),),
                const Spacer(),
                Text(HumanFormats.number(movie.popularity), style: textStyles.bodySmall,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    super.key,
    this.title,
    this.subtitle,
  });

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              onPressed: () {},
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              child: Text(subtitle!),
            )
        ],
      ),
    );
  }
}
