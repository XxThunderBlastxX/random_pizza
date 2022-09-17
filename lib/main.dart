import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_pizza/bloc/pizza_bloc.dart';
import 'package:random_pizza/models/pizza_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PizzaBloc()..add(LoadPizzaCounter())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<PizzaBloc, PizzaState>(
          builder: (context, state) {
            if (state is PizzaInitial) {
              const CircularProgressIndicator(
                color: Colors.teal,
              );
            } else if (state is PizzaLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${state.pizzas?.length}',
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        for (int i = 0; i < state.pizzas.length; i++)
                          Positioned(
                            left: Random().nextInt(250).toDouble(),
                            top: Random().nextInt(250).toDouble(),
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: state.pizzas[i]?.image,
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Text('Opps!! Something Went Wrong');
            }
            return const Text('Something Went Wrong');
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: () => context.read<PizzaBloc>().add(
                  AddPizza(Pizza.pizza[0]),
                ),
            child: const Icon(Icons.local_pizza),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: () => context.read<PizzaBloc>().add(
                  RemovePizza(Pizza.pizza[0]),
                ),
            child: const Icon(Icons.remove_circle),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: () => context.read<PizzaBloc>().add(
                  AddPizza(Pizza.pizza[1]),
                ),
            child: const Icon(Icons.local_pizza_outlined),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: () => context.read<PizzaBloc>().add(
                  RemovePizza(Pizza.pizza[1]),
                ),
            child: const Icon(Icons.remove_circle_outline),
          ),
        ],
      ),
    );
  }
}
