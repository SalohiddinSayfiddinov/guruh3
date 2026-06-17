abstract class CounterState {}

class CounterInitial extends CounterState {
  final int count = 0;
}

class CounterLoading extends CounterState {}

class CounterError extends CounterState {}

class CounterSuccess extends CounterState {
  final int count;

  CounterSuccess(this.count);
}
