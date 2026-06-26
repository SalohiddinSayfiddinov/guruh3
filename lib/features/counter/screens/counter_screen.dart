import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/counter/cubit/counter_cubit.dart';
import 'package:guruh3/features/counter/cubit/counter_state.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CounterCubit, TextChanged>(
          builder: (context, state) {
            return Text(
              '12341234'.split('').reversed.join(),
              style: TextStyle(color: state.color),
            );
          },
        ),
      ),
      body: Center(
        child: TextField(
          controller: controller,
          onChanged: (value) {
            print(value.length);
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 20.0,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().textniOzgartir(controller.text);
            },
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().changeColor(Colors.green);
            },
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().loadingniOzgartir();
            },
          ),
        ],
      ),
    );
  }
}
