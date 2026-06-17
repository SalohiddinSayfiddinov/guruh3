import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/counter/cubit/counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  Future<void> qosh() async {
    emit(CounterLoading());
    await Future.delayed(Duration(seconds: 1));
    emit(CounterSuccess(1));
  }
}
