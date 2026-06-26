import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/counter/cubit/counter_state.dart';

class CounterCubit extends Cubit<TextChanged> {
  CounterCubit() : super(TextChanged(text: "data", color: Colors.black));

  void textniOzgartir(String text) {
    emit(TextChanged(text: text, color: state.color));
  }

  void changeColor(Color color) {
    emit(TextChanged(text: state.text, color: color));
  }

  void loadingniOzgartir() {
    emit(
      TextChanged(
        text: state.text,
        color: state.color,
        loading: !state.loading,
      ),
    );
  }
}
