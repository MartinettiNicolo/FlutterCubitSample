import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_sample_app/src/detail/detail_cubit.dart';
import 'package:cubit_sample_app/src/detail/detail_page.dart';
import 'package:cubit_sample_app/src/movies/movie_cubit.dart';
import 'package:cubit_sample_app/src/movies/movie_state.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
      ),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorState) {
            return const Center(
              child: Icon(Icons.close),
            );
          } else if (state is LoadedState) {
            final movies = state.movies;

            return ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(movies[index].title),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(movies[index].urlImage),
                  ),
                  onTap: () {
                    debugPrint('${movies[index].title} tapped');
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => BlocProvider<DetailCubit>(
                          create: (context) => DetailCubit(),
                          child: DetailPage(movies: movies, index: index),
                        ))
                    );
                  },
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}



// StatefulWidget che fa la stessa cosa
/*
class MoviesPage extends StatefulWidget {
  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Movies'),
      ),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorState) {
            return Center(
              child: Icon(Icons.close),
            );
          } else if (state is LoadedState) {
            final movies = state.movies;

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(movies[index].title),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(movies[index].urlImage),
                  ),
                  onTap: () {
                    debugPrint('${movies[index].title} tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BlocProvider<DetailCubit>(
                        create: (context) => DetailCubit(),
                        child: DetailPage(movies: movies, index: index),
                      ))
                    );
                  },
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}*/