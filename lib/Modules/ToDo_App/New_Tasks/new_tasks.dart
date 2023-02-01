import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Shared/Components/components.dart';
import '../../../Shared/cubit/cubit.dart';
import '../../../Shared/cubit/states.dart';
import '../Categories/Personal.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {

          //AppCubit.get(context).isCategory(context);
          var cat;

          if(AppCubit.get(context).category == 'Personal')
            cat = AppCubit.get(context).personalTasks;
          else if(AppCubit.get(context).category == "Work")
            cat = AppCubit.get(context).workTasks;
          else if(AppCubit.get(context).category == "Studying")
            cat = AppCubit.get(context).studyingTasks;
          else if(AppCubit.get(context).category == "Wish")
            cat = AppCubit.get(context).wishlist;
          else if(AppCubit.get(context).category == "Shopping")
            cat = AppCubit.get(context).shopping;
          else if(AppCubit.get(context).category == "Others")
            cat = AppCubit.get(context).other;
          else if(AppCubit.get(context).category == "All")
            cat = AppCubit.get(context).New_tasks;

          var tasks = cat;

          //var tasks = AppCubit.get(context).cat;
          return TaskBuilder(tasks : tasks);
        }
    );
  }
}
