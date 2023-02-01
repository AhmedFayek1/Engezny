import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Shared/Components/components.dart';
import '../../../Shared/cubit/cubit.dart';
import '../../../Shared/cubit/states.dart';

class ShoppingTasks extends StatelessWidget {
  const ShoppingTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).shopping;
          return Scaffold(
            appBar: AppBar(
              title: Text("Shopping Tasks"),
            ),
            body: TaskBuilder(tasks : tasks),
          );
        }
    );
  }
}
