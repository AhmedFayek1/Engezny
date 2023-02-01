import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Shared/Components/components.dart';
import 'package:todo_app/Shared/cubit/states.dart';
import '../../Modules/ToDo_App/Archived_Tasks/archived_tasks.dart';
import '../../Modules/ToDo_App/Done_Tasks/done_tasks.dart';
import '../../Modules/ToDo_App/New_Tasks/new_tasks.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> Screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> Titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBar());
  }

  Database? database;
  List<Map> New_tasks = [];
  List<Map> Done_tasks = [];
  List<Map> Archived_tasks = [];
  List<Map> personalTasks = [];
  List<Map> workTasks = [];
  List<Map> studyingTasks = [];
  List<Map> wishlist = [];
  List<Map> shopping = [];
  List<Map> other = [];

  List<Map> donePersonalTasks = [];
  List<Map> doneWorkTasks = [];
  List<Map> doneStudyingTasks = [];
  List<Map> doneWishlist = [];
  List<Map> doneShopping = [];
  List<Map> doneOther = [];

  List<Map> archivedPersonalTasks = [];
  List<Map> archivedWorkTasks = [];
  List<Map> archivedStudyingTasks = [];
  List<Map> archivedWishlist = [];
  List<Map> archivedShopping = [];
  List<Map> archivedOther = [];







  void Create_Database() {
    openDatabase(
      'todo',
      version: 1,
      onCreate: (database, version) {
        print("database created");
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,time TEXT,date TEXT,status TEXT,type TEXT)')
            .then((value) {
          print("table created");
        }).catchError((error) {
          print("error ${error.toString()}");
        });
      },
      onOpen: (database) {
        Get_Data_From_Database(database);
        print("database opened");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  Insert_Database({
    required String title,
    required String time,
    required String date,
    required type
  }) async {
    await database?.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title,time,date,status,type) VALUES ("${title}","${time}","${date}","new","${type}")')
          .then((value) {
        print("Inserted Succesfully");
        emit(AppInsertDatabaseState());

        Get_Data_From_Database(database);
      }).catchError((error) {
        print("error inserting ${error.toString()}");
      });
      return null;
    });
  }

  void Get_Data_From_Database(database) {
    //All Tasks
    New_tasks = [];
    Done_tasks = [];
    Archived_tasks = [];

    //All Categories in new Tasks
    personalTasks = [];
    workTasks = [];
    studyingTasks = [];
    wishlist = [];
    shopping = [];
    other = [];

    //All Categories in done Tasks
    donePersonalTasks = [];
    doneWorkTasks = [];
    doneStudyingTasks = [];
    doneWishlist = [];
    doneShopping = [];
    doneOther = [];

    //All Categories in archived Tasks
    archivedPersonalTasks = [];
    archivedWorkTasks = [];
    archivedStudyingTasks = [];
    archivedWishlist = [];
    archivedShopping = [];
    archivedOther = [];





    database?.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        //Fill All Tasks
        if (element['status'] == 'new')
          New_tasks.add(element);
        else if (element['status'] == 'done')
          Done_tasks.add(element);
        else if (element['status'] == 'Archived')
          Archived_tasks.add(element);

        //Fill All Categories in New Tasks
        if(element['type'] == 'Personal' && element['status'] == 'new')
          personalTasks.add(element);
        //print(personalTasks);
        if(element['type'] == 'Work' && element['status'] == 'new')
          workTasks.add(element);
        if(element['type'] == 'Studying' && element['status'] == 'new')
          studyingTasks.add(element);
        if(element['type'] == 'WishList' && element['status'] == 'new')
          wishlist.add(element);
        if(element['type'] == 'Shopping' && element['status'] == 'new')
          shopping.add(element);
        if(element['type'] == 'Other' && element['status'] == 'new')
          other.add(element);

        //Fill All Categories in Done Tasks
        if(element['type'] == 'Personal' && element['status'] == 'done')
          donePersonalTasks.add(element);
        //print(personalTasks);
        if(element['type'] == 'Work' && element['status'] == 'done')
          doneWorkTasks.add(element);
        if(element['type'] == 'Studying' && element['status'] == 'done')
          doneStudyingTasks.add(element);
        if(element['type'] == 'WishList' && element['status'] == 'done')
          doneWorkTasks.add(element);
        if(element['type'] == 'Shopping' && element['status'] == 'done')
          doneShopping.add(element);
        if(element['type'] == 'Other' && element['status'] == 'done')
          doneOther.add(element);

        //Fill All Categories in Archived Tasks
        if(element['type'] == 'Personal' && element['status'] == 'Archived')
          archivedPersonalTasks.add(element);
        //print(personalTasks);
        if(element['type'] == 'Work' && element['status'] == 'Archived')
          archivedWorkTasks.add(element);
        if(element['type'] == 'Studying' && element['status'] == 'Archived')
          archivedStudyingTasks.add(element);
        if(element['type'] == 'WishList' && element['status'] == 'Archived')
          archivedWishlist.add(element);
        if(element['type'] == 'Shopping' && element['status'] == 'Archived')
          archivedShopping.add(element);
        if(element['type'] == 'Other' && element['status'] == 'Archived')
          archivedOther.add(element);

      });
      emit(AppGetDatabaseState());
    });
    //print(tasks);
  }

  bool isbottomsheetshown = false;

  IconData fabicon = Icons.edit;

  void ChangeState({
    required bool isshow,
    required IconData icon,
  }) {
    isbottomsheetshown = isshow;
    fabicon = icon;

    emit(AppChangeBottomCheetState());
  }

  void UpdateDatabase({required String status, required int id}) {
    database
        ?.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [status, id]);
    Get_Data_From_Database(database);
    emit(AppUpdateDatabaseState());
  }

  void UpdateTaskDatabase({required int id,required String title, required String time,required String date,required String type,context}) {
    database?.rawUpdate('UPDATE tasks SET title = ? WHERE id = ?', [title, id]);
    database?.rawUpdate('UPDATE tasks SET time = ? WHERE id = ?', [time, id]);
    database?.rawUpdate('UPDATE tasks SET date = ? WHERE id = ?', [date, id]);
    database?.rawUpdate('UPDATE tasks SET type = ? WHERE id = ?', [type, id]);

    Get_Data_From_Database(database);
    //Navigator.of(context).push(new MaterialPageRoute(builder: (context) => NewTasksScreen()));
    emit(AppUpdateDatabaseState());
  }

  void ArchiveDatabase({required String status, required int id}) {
    database
        ?.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [status, id]);
    Get_Data_From_Database(database);
    emit(AppArchivedDatabaseState());
  }

  void DeleteDatabase({required int id}) {
    database?.rawUpdate('DELETE FROM tasks WHERE id = ?', [id]);
    Get_Data_From_Database(database);
    emit(AppDeleteDatabaseState());
  }

  // bool IsDark = false;
  //
  // void ChangeMode({bool? fromshared}) {
  //   if (fromshared != null) {
  //     IsDark = fromshared;
  //     emit(ChangeAppModeState());
  //   }
  //   else {
  //     IsDark = !IsDark;
  //     cache_helper.PutData(key: 'IsDark', value: IsDark).then((value) {
  //       emit(ChangeAppModeState());
  //     });
  //   }
  //         }

  List<String> Types = ["Personal","Work","Studying","WishList","Shopping","Other"];

  var selectedItem = 'Personal';
  //Function(String) get changeDropDownItem => selectedItem.sink.add;
  void changeDropDownItem(value)
  {
    selectedItem = value;
    //print(selectedItem);
    emit(SelectedItemCategory());
  }

  String? category = "All";
  void showCategory(value,context)
  {
    if(value == 'All') {
      category = "All";
      emit(DisplayCategory());
    }
    else if(value == 'Personal List') {
      category = "Personal";
      emit(DisplayCategory());
    }
    else if(value == "Work List") {
      category = "Work";
      emit(DisplayCategory());
    }
    else if(value == "Studying List") {
      category = "Studying";
      emit(DisplayCategory());
    }
    else if(value == "Wish List") {
      category = "Wish";
      emit(DisplayCategory());
    }
    else if(value == "Shopping List") {
      category = "Shopping";
      emit(DisplayCategory());
    }
    else if(value == "Others") {
      category = "Others";
      emit(DisplayCategory());
    }

  }

    var cat;

  void isCategory(context)
  {
    //var cat;

    if(AppCubit.get(context).category == 'Personal')
      cat = personalTasks;
    else if(AppCubit.get(context).category == "Work")
      cat = workTasks;
    else if(AppCubit.get(context).category == "Studying")
      cat = studyingTasks;
    else if(AppCubit.get(context).category == "Wish")
      cat = wishlist;
    else if(AppCubit.get(context).category == "Shopping")
      cat = shopping;
    else if(AppCubit.get(context).category == "Others")
      cat = other;
    else if(AppCubit.get(context).category == "All")
      cat = New_tasks;

    emit(ChooseCategory());
  }

  Map<String,dynamic> mp = {
    'Personal': Colors.blue,
    'Work': Colors.green,
    'Studying': Colors.deepOrange,
    'WishList': Colors.amber,
    'Shopping': Colors.black,
    'Other': Colors.pink,
  };








  bool flag = false;
  void refresh()
  {
      Get_Data_From_Database(database);
      emit(AppRefreshState());
  }

}


