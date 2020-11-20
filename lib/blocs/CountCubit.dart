import 'package:bloc/bloc.dart';

class CountCubit extends Cubit<int> {
    CountCubit(int init) : super(init);
    void increment() => emit(state+1);
}