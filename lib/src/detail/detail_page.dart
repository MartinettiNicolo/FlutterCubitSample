import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_sample_app/src/detail/detail_cubit.dart';

import '../movies/movie_model.dart';
import 'detail_state.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.movies, required this.index});

  final List<MovieModel> movies;
  final int index;

  @override
  Widget build(BuildContext context) {
    String? swipeDirection;

    BlocProvider.of<DetailCubit>(context).onInit(index);
    //context.read<DetailCubit>().onInit(index);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Movie'),
      ),
      body: BlocBuilder<DetailCubit, DetailState>(
        builder: (context, state) {
          return GestureDetector(
            onPanUpdate: (details) {
              swipeDirection = details.delta.dx < 0 ? 'left' : 'right';
            },
            onPanEnd: (details) {
              if (swipeDirection == 'left') {
                BlocProvider.of<DetailCubit>(context).increment(movies.length);
                //context.read<DetailCubit>().increment(movies.length);
              }
              if (swipeDirection == 'right') {
                BlocProvider.of<DetailCubit>(context).decrement();
                //context.read<DetailCubit>().decrement();
              }
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(movies[state.counterValue].urlImage, fit: BoxFit.fitWidth, alignment: Alignment.topCenter),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: SizedBox(
                            height: 120,
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 50,
                                    child: Text(movies[state.counterValue].title, style: const TextStyle(fontSize: 22), textAlign: TextAlign.center,)
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.arrow_left_outlined, size: 32, color: Colors.blue,
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<DetailCubit>(context).decrement();
                                                //context.read<DetailCubit>().decrement();
                                              },
                                            )
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: TextButton(
                                                onPressed: () {
                                                  BlocProvider.of<DetailCubit>(context).changeOverview();
                                                  //context.read<DetailCubit>().changeOverview();
                                                },
                                                child: const Text("Overview")
                                            ),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.arrow_right_outlined, size: 32, color: Colors.blue,
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<DetailCubit>(context).increment(movies.length);
                                                //context.read<DetailCubit>().increment(movies.length);
                                              },
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedPositioned(
                    top: state.isOverview ? 50 : MediaQuery.of(context).size.height,
                    duration: Duration(milliseconds: state.isOverview ? 500 : 1000),
                    child: AnimatedOpacity(
                      opacity: state.isOverview ? 0.7 : 0,
                      duration: Duration(milliseconds: state.isOverview ? 1000 : 400),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                movies[state.counterValue].overview,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black
                                ),
                              ),
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          );
        },
      ),
    );
  }
}



// StatefulWidget che fa la stessa cosa
/*
class DetailPage extends StatefulWidget {
  DetailPage({required this.movies, required this.index});

  final List<MovieModel> movies;
  final int index;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  void initState() {
    super.initState();

    BlocProvider.of<DetailCubit>(context).onInit(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Movie'),
      ),
      body: BlocBuilder<DetailCubit, DetailState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Image.network(widget.movies[state.counterValue].urlImage, fit: BoxFit.fitHeight, alignment: Alignment.topCenter)
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  height: 120,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: Text(widget.movies[state.counterValue].title, style: TextStyle(fontSize: 22), textAlign: TextAlign.center,)
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_left_outlined, size: 32, color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<DetailCubit>(context).decrement();
                                    },
                                  )
                              ),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_right_outlined, size: 32, color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<DetailCubit>(context).increment(widget.movies.length);
                                      },
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}*/
