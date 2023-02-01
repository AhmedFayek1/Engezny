import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Shared/Components/components.dart';
import '../../../Shared/cubit/cubit.dart';
import '../../../Shared/cubit/states.dart';

class OtherTasks extends StatelessWidget {
  const OtherTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).other;
          return Scaffold(
            appBar: AppBar(
              title: Text("Other Tasks"),
            ),
            body: TaskBuilder(tasks : tasks),
          );
        }
    );
  }
}
