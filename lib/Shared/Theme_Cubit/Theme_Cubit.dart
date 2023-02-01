import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Shared/Theme_Cubit/Theme_States.dart';
import 'package:todo_app/Shared/Network/local/Cache_Helper.dart';

class ThemeCubit extends Cubit<ThemeStates>
{
  ThemeCubit() : super(ThemeStatesInitialState());

  static ThemeCubit get(context) => BlocProvider.of(context);


  bool IsDark = false;

  void ChangeMode({bool? fromshared}) {
    if (fromshared != null) {
      IsDark = fromshared;
      emit(ChangeAppModeState());
    }
    else {
      IsDark = !IsDark;
      cache_helper.PutData(key: 'IsDark', value: IsDark).then((value) {
        emit(ChangeAppModeState());
      });
    }
  }

}