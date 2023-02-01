import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Shared/Components/components.dart';
import '../../../Shared/cubit/cubit.dart';
import '../../../Shared/cubit/states.dart';

//import 'dart:html'

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cat;

          if(AppCubit.get(context).category == 'Personal')
            cat = AppCubit.get(context).donePersonalTasks;
          else if(AppCubit.get(context).category == "Work")
            cat = AppCubit.get(context).doneWorkTasks;
          else if(AppCubit.get(context).category == "Studying")
            cat = AppCubit.get(context).doneStudyingTasks;
          else if(AppCubit.get(context).category == "Wish")
            cat = AppCubit.get(context).doneWishlist;
          else if(AppCubit.get(context).category == "Shopping")
            cat = AppCubit.get(context).doneShopping;
          else if(AppCubit.get(context).category == "Others")
            cat = AppCubit.get(context).doneOther;
          else if(AppCubit.get(context).category == "All")
            cat = AppCubit.get(context).Done_tasks;

          var tasks = cat;

          //var tasks = AppCubit.get(context).Done_tasks;

          return TaskBuilder(tasks : tasks);
        }
    );
  }
}
