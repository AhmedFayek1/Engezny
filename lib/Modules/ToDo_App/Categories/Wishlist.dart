import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Shared/Components/components.dart';
import '../../../Shared/cubit/cubit.dart';
import '../../../Shared/cubit/states.dart';

class WishListTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).wishlist;
          return Scaffold(
            appBar: AppBar(
              title: Text("WishList Tasks"),
            ),
            body: TaskBuilder(tasks : tasks),
          );
        }
    );
  }
}
