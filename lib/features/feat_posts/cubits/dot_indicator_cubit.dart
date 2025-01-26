import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dot_indicator_state.dart';

class DotIndicatorCubit extends Cubit<int> {
  DotIndicatorCubit() : super(0);

  void changeIndicator(int pos) {
    emit(pos);
  }
}
