
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_app/Modules/ToDo_App/Categories/Personal.dart';
import 'package:todo_app/Modules/ToDo_App/New_Tasks/new_tasks.dart';
import 'package:todo_app/Modules/ToDo_App/Task_Details/Task_Details.dart';
import 'package:todo_app/Shared/Theme_Cubit/Theme_Cubit.dart';

import '../cubit/cubit.dart';


var titleTaskController = TextEditingController();
var timeTaskController = TextEditingController();
var dateTaskController = TextEditingController();
var typeTaskController = TextEditingController();
var formkey = GlobalKey<FormState>();


Widget BuildItemShow(Map model, context) {
  return GestureDetector(
    onTap: () {},
    child: InkWell(
      onTap: () {
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       titleTaskController.text = model['title'];
        //       // timeTaskController.text = model['time'];
        //       // dateTaskController.text = model['date'];
        //       typeTaskController.text = model['type'];
        //
        //       return AlertDialog(
        //         content: Container(
        //           child: Form(
        //             key: formkey,
        //             child: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 Text("Task Details",style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),
        //                 SizedBox(height: 20.00,),
        //                 TextFormField(
        //                   controller: titleTaskController,
        //                   validator: (value) {
        //                     if (value!.isEmpty) {
        //                       return "Required";
        //                     }
        //                     return null;
        //                   },
        //                   decoration: InputDecoration(
        //                     //hintText: "Email Address",
        //                     labelText: "Task Title",
        //                     prefixIcon: Icon(
        //                         Icons.title_outlined),
        //                     border: OutlineInputBorder(),
        //                   ),
        //                 ),
        //                 SizedBox(height: 15,),
        //                 TextFormField(
        //                   controller: timeTaskController,
        //                   keyboardType: TextInputType.datetime,
        //
        //                   validator: (value) {
        //                     if (value!.isEmpty) {
        //                       timeTaskController.text = model["time"];
        //                     }
        //                   },
        //                   onTap: () {
        //                     showTimePicker(
        //                         context: context,
        //                         initialTime: TimeOfDay.now()
        //                     ).then((value) {
        //                       timeTaskController.text =
        //                           value!.format(
        //                               context).toString();
        //                       print(timeTaskController.text);
        //                     });
        //                   },
        //                   decoration: InputDecoration(
        //                     hintText: model["time"],
        //                     //labelText: "Task Time",
        //                     prefixIcon: Icon(
        //                         Icons.watch_later_outlined),
        //                     border: OutlineInputBorder(),
        //                   ),
        //                 ),
        //                 SizedBox(height: 15,),
        //                 TextFormField(
        //                   controller: dateTaskController,
        //                   keyboardType: TextInputType.datetime,
        //
        //                   validator: (value) {
        //                     if (value!.isEmpty) {
        //                       dateTaskController.text = model["date"];
        //                     }
        //                     return null;
        //                   },
        //                   onTap: () {
        //                     showDatePicker(
        //                         context: context,
        //                         initialDate: DateTime.now(),
        //                         firstDate: DateTime.now(),
        //                         lastDate: DateTime.parse(
        //                             "2023-08-30")
        //                     ).then((value) {
        //                       dateTaskController.text =
        //                           DateFormat.yMMMd().format(value!);
        //                     }
        //                     );
        //                   },
        //                   decoration: InputDecoration(
        //                     hintText: model["date"],
        //                     //labelText: "Task Date",
        //                     prefixIcon: Icon(
        //                         Icons.date_range_outlined),
        //                     border: OutlineInputBorder(),
        //                   ),
        //                 ),
        //                 SizedBox(height: 10.00,),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 20.00),
        //                   child: Container(
        //                     width: double.infinity,
        //                     child: DropdownButton<String>(
        //                       dropdownColor: Colors.orange,
        //                       borderRadius: BorderRadius.circular(20.00),
        //                       value: model["type"],
        //                       items: AppCubit.get(context).Types.map((e) => DropdownMenuItem<String>(value: e,child: Text(e))).toList(),
        //                       onChanged: (value) {
        //                         typeTaskController.text = value!;
        //                       },
        //                     ),
        //                   ),
        //                 ),
        //                 TextButton(
        //                     onPressed: () {
        //                       if(formkey.currentState!.validate()) {
        //                         print("${timeTaskController.text} + ${dateTaskController.text}");
        //                       AppCubit.get(context).UpdateTaskDatabase(
        //                             id: model['id'],
        //                             title: titleTaskController.text,
        //                             time: timeTaskController.text,
        //                             date: dateTaskController.text,
        //                             type: typeTaskController.text,
        //                             context: context
        //                         );
        //                         Navigator.pop(context);
        //                         AppCubit.get(context).refresh();
        //                       }
        //                     },
        //                     child: Text("UPDATE")
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //     }
        // );
        Navigateto(context, TaskDetails(model));
      },
      child: Dismissible(
        key: Key(model['id'].toString()),
        child: Padding(
          padding: const EdgeInsets.all(15.00),
          child: Container(
            height: 70.00,
            decoration: BoxDecoration(
              color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(20.00)),
            ),
            //padding: EdgeInsets.all(20.00),
            child: Row(
              children: [
                // CircleAvatar(
                //   radius: 20.00,
                //   child: Text(model["time"]),
                // ),
                Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                    width: 70.00,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      //color: AppCubit.get(context).mp[model["type"]],
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.00),bottomLeft: Radius.circular(20.00)),
                    ),
                    child: Text(model["time"],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20.00),)
                ),
                SizedBox(width: 20.00,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(model["title"], style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.00,height: 1),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      SizedBox(height: 5.00,),

                      Text(model["date"]),
                      //SizedBox(height: 10.00,),
                      //Text(model["type"]),

                    ],
                  ),
                ),
                SizedBox(width: 20.00,),
                IconButton(
                    onPressed: () {
                      Share.share(model["title"]);
                    },
                    icon: Icon(Icons.share),
                ),
                if(model['status'] == 'new')
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).UpdateDatabase(
                      status: 'done',
                      id: model['id'],
                    );
                  },
                  icon: Icon(Icons.check_box, color: Theme.of(context).primaryColor,size: 30.00,),
                ),
                if(model['status'] == 'new')
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).ArchiveDatabase(
                        status: 'Archived',
                        id: model['id']);
                  },
                  icon: Icon(Icons.archive, color: Colors.black54,size: 30.00,),
                ),
                if(model['status'] == 'done')
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).ArchiveDatabase(
                        status: 'Archived',
                        id: model['id']);
                  },
                  icon: Icon(Icons.archive, color: Colors.black54,size: 30.00,),

                )
              ],
            ),
          ),
        ),
        onDismissed: (direction) {
          AppCubit.get(context).DeleteDatabase(id: model['id']);
        },
      ),
    ),
  );
}

Widget TaskBuilder({required List<Map> tasks}) {
  return ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) =>
        ListView.separated(
            itemBuilder: (context, index) =>
                BuildItemShow(tasks[index], context),
            separatorBuilder: (context, index) =>
                Container(
                  width: double.infinity,
                  height: 1.00,
                  color: Colors.grey[300],
                ),
            itemCount: tasks.length
        ),
    fallback: (context) =>
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.menu, color: ThemeCubit.get(context).IsDark? Colors.white : Colors.black, size: 100,),
              Text("No Tasks Yet, Please Add New Tasks", style: Theme.of(context).textTheme.bodyText1,)
            ],
          ),
        ),
  );
}



Widget Separator()
{
  return  Container(
    width: double.infinity,
    height: 1.00,
    color: Colors.grey[300],
  );
}


void Navigateto(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget)
);

void NavigatetoFinish(context,widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic>route) => false,
);

void ShowToast({
  required String message,
  required ToastStates state
}) =>  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: ShowColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS,ERROR,WARNING}

Color? color;

Color ShowColor(ToastStates state)
{
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color!;
}
