import 'package:equatable/equatable.dart';
import 'package:cubit_sample_app/src/movies/movie_model.dart';

abstract class MoviesState extends Equatable {}

class InitialState extends MoviesState {
  @override
  List<Object> get props => [];
}

class LoadingState extends MoviesState {
  @override
  List<Object> get props => [];
}

class LoadedState extends MoviesState {
  LoadedState(this.movies);

  final List<MovieModel> movies;

  @override
  List<Object> get props => [movies];
}

class ErrorState extends MoviesState {
  @override
  List<Object> get props => [];
}
