import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
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

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBar());
  }

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
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







  void createDatabase() {
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
        getData(database);
        print("database opened");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertData({
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

        getData(database);
      }).catchError((error) {
        print("error inserting ${error.toString()}");
      });
      return null;
    });
  }

  void getData(database) {
    //All Tasks
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

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
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else if (element['status'] == 'Archived')
          archivedTasks.add(element);

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

  void changeState({
    required bool isshow,
    required IconData icon,
  }) {
    isbottomsheetshown = isshow;
    fabicon = icon;

    emit(AppChangeBottomCheetState());
  }

  void updateData({required String status, required int id}) {
    database
        ?.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [status, id]);
    getData(database);
    emit(AppUpdateDatabaseState());
  }

  void updateTask({required int id,required String title, required String time,required String date,required String type,context}) {
    database?.rawUpdate('UPDATE tasks SET title = ? WHERE id = ?', [title, id]);
    database?.rawUpdate('UPDATE tasks SET time = ? WHERE id = ?', [time, id]);
    database?.rawUpdate('UPDATE tasks SET date = ? WHERE id = ?', [date, id]);
    database?.rawUpdate('UPDATE tasks SET type = ? WHERE id = ?', [type, id]);

    getData(database);
    //Navigator.of(context).push(new MaterialPageRoute(builder: (context) => NewTasksScreen()));
    emit(AppUpdateDatabaseState());
  }

  void archiveData({required String status, required int id}) {
    database
        ?.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [status, id]);
    getData(database);
    emit(AppArchivedDatabaseState());
  }

  void deleteTask({required int id}) {
    database?.rawUpdate('DELETE FROM tasks WHERE id = ?', [id]);
    getData(database);
    emit(AppDeleteDatabaseState());
  }

  List<String> types = ["Personal","Work","Studying","WishList","Shopping","Other"];

  var selectedItem = 'Personal';
  //Function(String) get changeDropDownItem => selectedItem.sink.add;
  void changeDropDownItem(value)
  {
    cat = value;
    selectedItem = value;
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
      cat = newTasks;

    emit(ChooseCategory());
  }

  bool flag = false;
  void refresh()
  {
      getData(database);
      emit(AppRefreshState());
  }

}


