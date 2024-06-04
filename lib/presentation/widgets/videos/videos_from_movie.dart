import 'package:cinemapedia/domain/entities/video.dart';
import 'package:cinemapedia/presentation/providers/videos/trailer_movie_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosFromMovie extends ConsumerWidget {
  const VideosFromMovie({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final trailersProvider = ref.watch(trailerMovieProvider(movieId));

    return trailersProvider.when(
        data: (trailers) => _TrailersList(trailers: trailers,),
        error:(_, __) => const Center(child: Text('No se pudo cargar trailer'),),
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2,),)
    );
  }
}

class _TrailersList extends StatelessWidget {
  const _TrailersList({
    super.key,
    required this.trailers
  });

  final List<Video> trailers;

  @override
  Widget build(BuildContext context) {
    if(trailers.isEmpty){
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Trailer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        _YouTubeVideoPlayer(youtubeId: trailers.first.youtubeKey, name: trailers.first.name,)
      ],
    );
  }
}

class _YouTubeVideoPlayer extends StatefulWidget {
  const _YouTubeVideoPlayer({
    super.key, required this.youtubeId, required this.name,

  });

  final String youtubeId;
  final String name;

  @override
  State<_YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<_YouTubeVideoPlayer> {

  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = YoutubePlayerController(
        initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true
      )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name),
          YoutubePlayer(controller: _controller
          )
        ],
      ),
    );
  }
}
