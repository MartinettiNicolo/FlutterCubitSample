import 'package:flutter_bloc/flutter_bloc.dart';
import 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(const DetailState(counterValue: 0, isOverview: false));

  void onInit (int startIndex) {
    emit(DetailState(counterValue: startIndex, isOverview: false));
  }

  void increment (int listLength) {
    if (state.counterValue == listLength - 1) {
      return;
    } else {
      emit(DetailState(counterValue: state.counterValue + 1, isOverview: false));
    }
  }

  void decrement () {
    if (state.counterValue == 0) {
      return;
    } else {
      emit(DetailState(counterValue: state.counterValue - 1, isOverview: false));
    }
  }

  void changeOverview () {
    emit(DetailState(counterValue: state.counterValue, isOverview: !state.isOverview));
  }
}
