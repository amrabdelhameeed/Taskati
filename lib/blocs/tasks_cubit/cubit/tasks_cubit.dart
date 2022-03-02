import 'package:android_dates/models/task.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());
  static TasksCubit get(context) => BlocProvider.of(context);

  List<Task> tasks = [];

  Database? database;
  Future createDBa() async {
    database = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'dba.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, name TEXT,time TEXT,date TEXT,isDone INTEGER,isArchive INTEGER,isHabit INTEGER)',
        );
      },
      onOpen: (database) {
        allNotes(database).then((value) {
          tasks = value;
          tasks.forEach((element) {
            var date =
                DateTime.parse(element.date).add(const Duration(days: 1));
            if (DateTime.now().difference(date).inSeconds > 0) {
              toggleIsArchiveCubit(dog: element);
            }
          });
          //getallNotes();
          emit(CreateDb());
        });
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    emit(CreateDb());
  }

  void any() {
    emit(LoadingState());
    createDBa().then((value) {
      tasks.forEach((element) {
        var date = DateTime.parse(element.date).add(const Duration(days: 1));
        if (DateTime.now().difference(date).inSeconds > 0) {
          if (element.isArchive == 1 && element.isHabit == 1) {
            toggleIsHabitCubit(dog: element, isHabit: false).then((value) {
              insertDB(
                      isHabit: 1,
                      name: element.name,
                      date: date,
                      time: element.time,
                      id: tasks.length + plusOneWhenDeletetion++)
                  .then((value) {
                emit(LoadingState());
              });
            }).then((value) {
              emit(LoadingState());
            });
          }
        }
      });
      emit(LoadingState());
    }).then((value) {
      emit(OpenAppState());
    });
  }

  void changeState() {
    emit(OpenAppState());
  }

  void createDB() {
    createDBa().then((value) {
      emit(CreateDb());
    });
  }

  // void datahavgotten() {
  //   emit(LoadFromPrefState());
  // }

  late int plusOneWhenDeletetion;

  Future insertDB(
      {String? name,
      String? time,
      DateTime? date,
      int? isHabit,
      int? id}) async {
    final db = database;
    Task task;
    //int day = int.parse(date.toString().substring(8, 10)) + 1;
    task = Task(
        id: id ?? tasks.length + plusOneWhenDeletetion,
        name: name!,
        time: time!,
        isHabit: isHabit ?? 0,
        date: date.toString().substring(0, 10),
        isArchive: 0,
        isDone: 0);
    await db!
        .insert('tasks', task.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      allNotes(database).then((value) {
        tasks = value;
        getallNotes();
        print("added yasta");
        emit(TaskAdded());
      });
    });
  }

  Future<List<Task>> allNotes(database) async {
    final List<Map<String, dynamic>> maps = await database!.query('tasks');
    return List.generate(maps.length, (i) {
      return Task(
          isHabit: maps[i]['isHabit'],
          isArchive: maps[i]['isArchive'],
          id: maps[i]['id'],
          isDone: maps[i]['isDone'],
          name: maps[i]['name'],
          date: maps[i]['date'],
          time: maps[i]['time']);
    });
  }

  void getallNotes() {
    allNotes(database).then((value) {
      tasks = value;
    });
    emit(GetDataFromDB());
  }

  Future deleteDog(Task note) async {
    plusOneWhenDeletetion++;
    _prefs.setInt("a", plusOneWhenDeletetion);
    final db = database;
    await db!.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [note.id],
    ).then((value) {
      allNotes(database).then((value) {
        tasks = value;
        getallNotes();
        emit(DeleteDataFromDB());
      });
    });
  }

  void toggleIsDoneCubit({Task? dog, bool? isDone}) async {
    Task dogi = Task(
        id: dog!.id,
        isDone: isDone! ? 1 : 0,
        date: dog.date,
        name: dog.name,
        time: dog.time,
        isHabit: dog.isHabit,
        isArchive: dog.isArchive);
    await updateDog(dogi);
  }

  Future toggleIsHabitCubit({Task? dog, bool? isHabit}) async {
    Task dogi = Task(
        id: dog!.id,
        isDone: dog.isDone,
        date: dog.date,
        name: dog.name,
        time: dog.time,
        isHabit: isHabit! ? 1 : 0,
        isArchive: dog.isArchive);
    await updateDog(dogi);
  }

  Future toggleIsArchiveCubit({Task? dog}) async {
    //await deleteDog(dog!);
    Task task = Task(
        id: dog!.id,
        date: dog.date,
        isArchive: 1,
        isDone: dog.isDone,
        isHabit: dog.isHabit,
        name: dog.name,
        time: dog.time);
    await updateDog(task);
  }

  Future<void> updateDog(Task dog) async {
    emit(TaskUpdated());
    // Get a reference to the database.
    final db = database;

    Task dogi = Task(
        isHabit: dog.isHabit,
        id: dog.id,
        isDone: dog.isDone,
        date: dog.date,
        name: dog.name,
        time: dog.time,
        isArchive: dog.isArchive);
    // Update the given Dog.
    await db!.update(
      'tasks',
      dogi.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dogi.id],
    ).then((value) {
      allNotes(database).then((value) {
        tasks = value;
        getallNotes();
        emit(UpdateDataDb());
      });
    });
  }

  late SharedPreferences _prefs;

  saveToPrefTheme() async {
    await callGetInstanceSharedPref();
//    _prefs.setBool(themeKey, isDark!);
    _prefs.setInt("a", plusOneWhenDeletetion);
    emit(SaveToDB());
  }

  initializingSharedPrefrenceStuff() {
    getFromSp();
    //  reInsertAllNotes();
    emit(OpenAppState());
    //indexsOfColors = [];
    //titles = [];
    //isDark = false;
    plusOneWhenDeletetion = 0;
  }

  getFromSp() async {
    await callGetInstanceSharedPref();
    //titles = _prefs.getStringList(textkey)!;
    //indexsOfColors = _prefs.getStringList(colorkey)!;
    plusOneWhenDeletetion = _prefs.getInt("a") ?? 0;
    // isDark = _prefs.getBool(themeKey) ?? true;
    emit(LoadFromPrefState());
  }

  callGetInstanceSharedPref() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
