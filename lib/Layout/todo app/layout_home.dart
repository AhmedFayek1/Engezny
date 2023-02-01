/*
1-create database
2-create tables
3-open database
4-insert into database
5-get data from database
6 update database
delete from database
*/

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Modules/ToDo_App/Categories/Personal.dart';
import 'package:todo_app/Modules/ToDo_App/New_Tasks/new_tasks.dart';
import 'package:todo_app/Modules/ToDo_App/Task_Details/Task_Details.dart';
import 'package:todo_app/Shared/Components/components.dart';
import 'package:todo_app/Shared/Theme_Cubit/Theme_Cubit.dart';
import '../../Shared/cubit/cubit.dart';
import '../../Shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..Create_Database(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state) {
          print("LOL");

          //close the Text Fields menu
          if(state is AppInsertDatabaseState) Navigator.pop(context);
          if(AppCubit.get(context).flag)
          {
            print("LOL");
            //AppCubit.get(context).Get_Data_From_Database(AppCubit.get(context).database);
          }
        },
        builder: (BuildContext context,AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          ThemeCubit themeCubit = ThemeCubit.get(context);

          return Scaffold(
              key: scaffoldkey,
              appBar: AppBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                backgroundColor: Theme.of(context).primaryColor,
                title: Text(
                    "${cubit.Titles[cubit.currentIndex]} - ${AppCubit.get(context).category}"
                ),
                  actions: [
                    IconButton(
                        onPressed: () {
                            AppCubit.get(context).Get_Data_From_Database(AppCubit.get(context).database);
                          },
                        icon: Icon(Icons.refresh)
                    ),
                    IconButton(
                        onPressed: () {
                          ThemeCubit.get(context).ChangeMode();
                        },
                        icon: Icon(Icons.sunny)
                    ),
                          PopupMenuButton(
                            color: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onSelected: (value) {
                                AppCubit.get(context).showCategory(value, context);
                            },
                            itemBuilder: (BuildContext context) {
                              return {'All','Personal List','Work List','Studying List','Wish List','Shopping List','Others'}.map((String choice) {
                                return PopupMenuItem(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          )]
              ),
              body: ConditionalBuilder(
                condition: true,
                builder: (context) => cubit.Screens[cubit.currentIndex],
                fallback: (context) => Center(child: CircularProgressIndicator(),),
              ),

              floatingActionButton: FloatingActionButton(
                onPressed: () //work in the background while anonymous time
                    {
                      if (cubit.isbottomsheetshown) {
                    if (formkey.currentState!.validate()) {
                      cubit.Insert_Database(
                          title: titleController.text,
                          time: timeController.text,
                          date: dateController.text,
                          type: AppCubit.get(context).selectedItem
                      );
                    }
                      }
                      else {
                        scaffoldkey.currentState?.showBottomSheet(
                                (context) => Container(
                                  color: Colors.grey[300],
                                  padding: const EdgeInsets.all(20.00),

                                  child: Form(
                                    key: formkey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          controller: titleController,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Required";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            //hintText: "Email Address",
                                            labelText: "Task Title",
                                            prefixIcon: Icon(
                                                Icons.title_outlined),
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                                        TextFormField(
                                          controller: timeController,
                                          keyboardType: TextInputType.datetime,

                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Required";
                                            }
                                            return null;
                                          },
                                          onTap: () {
                                            showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now()
                                            ).then((value) {
                                              timeController.text =
                                                  value!.format(
                                                      context).toString();
                                            });
                                          },
                                          decoration: InputDecoration(
                                            //hintText: "Email Address",
                                            labelText: "Task Time",
                                            prefixIcon: Icon(
                                                Icons.watch_later_outlined),
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                                        TextFormField(
                                          controller: dateController,
                                          keyboardType: TextInputType.datetime,

                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Required";
                                            }
                                            return null;
                                          },
                                          onTap: () {
                                            showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    "2023-08-30")
                                            ).then((value) {
                                              dateController.text =
                                                  DateFormat.yMMMd().format(
                                                      value!);
                                            }
                                            );
                                          },
                                          decoration: InputDecoration(
                                            //hintText: "Email Address",
                                            labelText: "Task Date",
                                            prefixIcon: Icon(
                                                Icons.date_range_outlined),
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 10.00,),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20.00),
                                          child: Container(
                                            width: double.infinity,
                                            child: DropdownButton(
                                              dropdownColor: Colors.orange,
                                              borderRadius: BorderRadius.circular(20.00),
                                              value: AppCubit.get(context).selectedItem,
                                                items: AppCubit.get(context).Types.map((e) => DropdownMenuItem(value: e,child: Text(e))).toList(),
                                                onChanged: (value) {
                                                    AppCubit.get(context).changeDropDownItem(value);
                                                },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                        ).closed.then((value) {
                          cubit.ChangeState(isshow: false, icon: Icons.edit);
                          // setState(() {
                          //   fabicon = Icons.edit;
                          // });
                        });
                        cubit.ChangeState(isshow: true, icon: Icons.add);
                        // setState(() {
                        //   fabicon = Icons.add;
                        // });
                      };
                    },
                    child: Icon(cubit.fabicon)
               ),

              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  cubit.ChangeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: 'Done'),
                  BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archive'),
                ],

              ),
          );

        },
      ),
    );
  }

  void refresh(context)
  {
      refresh(context);
  }
}


