import 'package:aqarat_raqamia/bloc/boarding_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardingCubit extends Cubit<BoardingState> {
  BoardingCubit() : super(InitialBoardingState());

  static BoardingCubit get(context) => BlocProvider.of(context);

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  changeSelectedIndex(int i) {
    _selectedIndex = i;
    emit(ChangeBoardingState());
    // update();
  }
}
