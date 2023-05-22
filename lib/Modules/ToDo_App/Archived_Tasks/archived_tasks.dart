import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Shared/Components/components.dart';
import '../../../Shared/cubit/cubit.dart';
import '../../../Shared/cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cat;

          if(AppCubit.get(context).category == 'Personal')
            cat = AppCubit.get(context).archivedPersonalTasks;
          else if(AppCubit.get(context).category == "Work")
            cat = AppCubit.get(context).archivedWorkTasks;
          else if(AppCubit.get(context).category == "Studying")
            cat = AppCubit.get(context).archivedStudyingTasks;
          else if(AppCubit.get(context).category == "Wish")
            cat = AppCubit.get(context).archivedWishlist;
          else if(AppCubit.get(context).category == "Shopping")
            cat = AppCubit.get(context).archivedShopping;
          else if(AppCubit.get(context).category == "Others")
            cat = AppCubit.get(context).archivedOther;
          else if(AppCubit.get(context).category == "All")
            cat = AppCubit.get(context).archivedTasks;

          var tasks = cat;

          //var tasks = AppCubit.get(context).Archived_tasks;
          return TaskBuilder(tasks : tasks);
        }
    );
  }
}
