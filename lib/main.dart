
import 'package:cron/cron.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Modules/ToDo_App/New_Tasks/new_tasks.dart';
import 'package:todo_app/Shared/Components/components.dart';
import 'package:todo_app/Shared/Theme_Cubit/Theme_Cubit.dart';
import 'package:todo_app/Shared/Theme_Cubit/Theme_States.dart';
import 'package:todo_app/Shared/cubit/cubit.dart';

import 'Layout/todo app/layout_home.dart';
import 'Shared/Styles/themes.dart';
import 'Shared/bloc_observer.dart';

import 'Shared/Network/local/Cache_Helper.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await cache_helper.init();

  final cron = Cron();
  cron.schedule(Schedule.parse('*/1 * * * *'), () async {
  ShowToast(message: "This code runs at 12am everyday", state: ToastStates.SUCCESS);
    print("This code runs at 12am everyday");
  });
  bool? IsDark = cache_helper.GetData(key: 'IsDark');

  runApp(MyApp(IsDark));
}

class MyApp extends StatelessWidget {

  final bool? IsDark;
  MyApp(this.IsDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ThemeCubit()..ChangeMode(fromshared: IsDark)), 
        BlocProvider(create: (BuildContext context) => AppCubit()..Create_Database())
      ],
      child: BlocConsumer<ThemeCubit,ThemeStates>(
        listener: (context,state) {},
        builder: (context,state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LighteMode,
            darkTheme: DarkMode,
            themeMode: ThemeCubit.get(context).IsDark ? ThemeMode.dark :  ThemeMode.light,
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}
