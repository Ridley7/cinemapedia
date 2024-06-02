import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMasonry extends StatefulWidget {
  const MovieMasonry({
    required this.movies,
    this.loadNextPage,
    super.key});

  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {

    super.initState();
    scrollController.addListener((){
      if(widget.loadNextPage == null) return;

      if((scrollController.position.pixels + 100) >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
          crossAxisCount: 3,
          controller: scrollController,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount: widget.movies.length,
          itemBuilder: (BuildContext context, int index){
            final Movie movie = widget.movies[index];

            if(index == 1){
              return Column(
                children: [
                  const SizedBox(height: 40,),
                  MoviePosterLink(movie: movie)
                ],
              );
            }

            return MoviePosterLink(movie: movie);
          }
      ),
    );
  }
}
