import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Layout/todo%20app/layout_home.dart';
import 'package:todo_app/Shared/Components/components.dart';
import 'package:todo_app/Shared/cubit/cubit.dart';
import 'package:todo_app/Shared/cubit/states.dart';

class TaskDetails extends StatelessWidget {

  var model;
  TaskDetails(this.model);

  var titleTaskController = TextEditingController();
  var timeTaskController = TextEditingController();
  var dateTaskController = TextEditingController();
  var typeTaskController = TextEditingController();
  var formkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>
      (
        listener: (context,state) {
          if(state is AppRefreshState)
            {
              AppCubit.get(context).Get_Data_From_Database(AppCubit.get(context).database);
            }
        },
        builder: (context,state) {
          titleTaskController.text = model['title'];
          // timeTaskController.text = model['time'];
          // dateTaskController.text = model['date'];
          typeTaskController.text = model['type'];

          return Scaffold(
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              backgroundColor: Colors.lightBlueAccent,
              title: Text("Task Details"),
            ),
            backgroundColor: Colors.white,
            body:  SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.00),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Task Details",style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),
                      SizedBox(height: 20.00,),
                      TextFormField(
                        controller: titleTaskController,
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
                        controller: timeTaskController,
                        keyboardType: TextInputType.datetime,

                        validator: (value) {
                          if (value!.isEmpty) {
                            timeTaskController.text = model["time"];
                          }
                        },
                        onTap: () {
                          showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now()
                          ).then((value) {
                            timeTaskController.text =
                                value!.format(
                                    context).toString();
                            print(timeTaskController.text);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: model["time"],
                          //labelText: "Task Time",
                          prefixIcon: Icon(
                              Icons.watch_later_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: dateTaskController,
                        keyboardType: TextInputType.datetime,

                        validator: (value) {
                          if (value!.isEmpty) {
                            dateTaskController.text = model["date"];
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
                            dateTaskController.text =
                                DateFormat.yMMMd().format(value!);
                          }
                          );
                        },
                        decoration: InputDecoration(
                          hintText: model["date"],
                          //labelText: "Task Date",
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
                          child: DropdownButton<String>(
                            dropdownColor: Colors.orange,
                            borderRadius: BorderRadius.circular(20.00),
                            value: model["type"],
                            items: AppCubit.get(context).Types.map((e) => DropdownMenuItem<String>(value: e,child: Text(e))).toList(),
                            onChanged: (value) {
                              typeTaskController.text = value!;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20.00,),
                      Container( 
                        width: double.infinity, 
                        height: 45.00, 
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.00)
                        ),
                        child: TextButton(
                            onPressed: () {
                              if(formkey.currentState!.validate()) {
                                print("${timeTaskController.text} + ${dateTaskController.text}");
                                AppCubit.get(context).UpdateTaskDatabase(
                                    id: model['id'],
                                    title: titleTaskController.text,
                                    time: timeTaskController.text,
                                    date: dateTaskController.text,
                                    type: typeTaskController.text,
                                    context: context
                                );
                                 Navigator.pop(context);
                                 AppCubit.get(context).Get_Data_From_Database(AppCubit.get(context).database);

                              }
                            },
                            child: Text("UPDATE")
                        ),
                      ),
                      SizedBox(height: 10.00,),
                      Container(
                        width: double.infinity,
                        height: 45.00,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.00)
                        ),
                        child: TextButton(
                            onPressed: () {
                              AppCubit.get(context).DeleteDatabase(id: model['id']);
                              Navigator.pop(context);
                            },
                            child: Text("DELETE")
                        ),
                      ),
                      SizedBox(height: 10.00,),
                      if(model["status"] == "done" || model["status"] == "Archived")
                        Container(
                        width: double.infinity,
                        height: 45.00,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.00)
                        ),
                        child: TextButton(
                            onPressed: () {
                              if(formkey.currentState!.validate()) {
                                AppCubit.get(context).DeleteDatabase(id: model["id"]);
                                AppCubit.get(context).Insert_Database(
                                    title: titleTaskController.text,
                                    time: timeTaskController.text,
                                    date: dateTaskController.text,
                                    type: typeTaskController.text
                                );
                                Navigator.pop(context);
                              }
                            },
                            child: Text("ADD TO NEW LIST")
                        ),
                      ),
                      SizedBox(height: 10.00,),
                      Row(
                        children: [
                          if(model["status"] == 'new')
                            Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 45.00,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10.00)
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    AppCubit.get(context).UpdateDatabase(
                                      status: 'done',
                                      id: model['id'],
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Text("DONE")
                              ),
                            ),
                          ),
                          if(model["status"] == 'new')
                            SizedBox(width: 10.00,),
                          if(model["status"] == 'new')
                            Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 45.00,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10.00)
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    AppCubit.get(context).ArchiveDatabase(
                                        status: 'Archived',
                                        id: model['id']);
                                    Navigator.pop(context);
                                  },
                                  child: Text("ARCHIVE")
                              ),
                            ),
                          ),
                          if(model["status"] == 'done')
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 45.00,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10.00)
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      AppCubit.get(context).ArchiveDatabase(
                                          status: 'Archived',
                                          id: model['id']);
                                      Navigator.pop(context);
                                    },
                                    child: Text("ARCHIVE")
                                ),
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
    },
    );
  }
}
