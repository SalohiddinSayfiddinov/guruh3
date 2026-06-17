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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CounterCubit, CounterState>(
        builder: (context, state) {
          if (state is CounterInitial) {
            return Center(
              child: Text(
                state.count.toString(),
                style: TextStyle(fontSize: 40.0),
              ),
            );
          } else if (state is CounterLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is CounterError) {
            return Center(
              child: Text("Xatolik", style: TextStyle(fontSize: 40.0)),
            );
          } else if (state is CounterSuccess) {
            return Center(
              child: Text(
                state.count.toString(),
                style: TextStyle(fontSize: 40.0),
              ),
            );
          }
          return SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterCubit>().qosh();
        },
      ),
    );
  }
}
