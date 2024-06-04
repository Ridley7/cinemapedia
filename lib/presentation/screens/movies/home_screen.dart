
import 'package:cinemapedia/presentation/views/movies/popular_view.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/views/views_barrel.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.indexView});

  static const name = "home-screen";
  final int indexView;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin
{
  late PageController pageController;

  final viewRoutes = const <Widget>[
    HomeView(),
    PopularView(),
    FavoritesView()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(
      keepPage: true
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if(pageController.hasClients){
      pageController.animateToPage(
          widget.indexView,
          duration: const Duration(milliseconds:  250),
          curve: Curves.easeInOut
      );
    }

    return Scaffold(
      body: PageView(
        controller: pageController,
        children: viewRoutes,
      ),

      bottomNavigationBar: CustomNavigationBar(currentIndex: widget.indexView,),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

