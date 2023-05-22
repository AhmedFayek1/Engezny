
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
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
        Navigateto(context, TaskDetails(model));
      },
      child: Dismissible(
        key: Key(model['id'].toString()),
        child: Padding(
          padding: const EdgeInsets.all(15.00),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(20.00)),
            ),
            //padding: EdgeInsets.all(20.00),
            child: Row(
              children: [
                Expanded(
                  child: Container( 
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(model["title"], style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.00,height: 1),maxLines: 2,overflow: TextOverflow.ellipsis,),
                        SizedBox(height: 5.00,),

                        Text(model["date"]),
                        Text(model["time"]),
                        //SizedBox(height: 10.00,),
                        //Text(model["type"]),
                        Text(model["type"]),
                      ],
                    ),
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
                    AppCubit.get(context).updateData(
                      status: 'done',
                      id: model['id'],
                    );
                  },
                  icon: Icon(Icons.check_box, color: Theme.of(context).primaryColor,size: 30.00,),
                ),
                if(model['status'] == 'new')
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).archiveData(
                        status: 'Archived',
                        id: model['id']);
                  },
                  icon: Icon(Icons.archive, color: Colors.black54,size: 30.00,),
                ),
                if(model['status'] == 'done')
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).archiveData(
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
          AppCubit.get(context).deleteTask(id: model['id']);
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

// Widget drobMenu({context,required Function(String) fun,required List<String> list,var text})
// {
//   //BlogAppCubit.get(context).first = list[0];
//
//   return DropdownButton(
//
//     // Initial Value
//     value: AppCubit.get(context).selectedItem,
//
//     // Down Arrow Icon
//     icon: const Icon(Icons.keyboard_arrow_down),
//     // Array list of items
//     items: list.map<DropdownMenuItem<String>>((String item) {
//       return DropdownMenuItem(
//         value: item,
//         child: Text(item),
//       );
//     }).toList(),
//     // After selecting the desired option,it will
//     // change button value to selected value
//     onChanged: (String ? val) => fun(val!),
//   );
// }
