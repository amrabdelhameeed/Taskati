import 'package:android_dates/app_router.dart';
import 'package:android_dates/blocs/obsever.dart';
import 'package:android_dates/blocs/tasks_cubit/cubit/tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
  // await AndroidAlarmManager.periodic(
  //     const Duration(minutes: 1), helloAlarmID, printHello);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      color: Colors.teal,
      theme: ThemeData(
        cardColor: Colors.teal,
        backgroundColor: Colors.teal,
        splashColor: Colors.teal,
        colorScheme: ColorScheme.light(
            surface: Colors.white, primary: Colors.teal.shade900),
        timePickerTheme: TimePickerThemeData(
          helpTextStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.teal,
          entryModeIconColor: Colors.white,
          hourMinuteTextColor: Colors.white,
          dayPeriodTextColor: Colors.white,
          dialHandColor: Colors.black,
          dialTextColor: Colors.white,
        ),
        canvasColor: Colors.teal,
        fontFamily: 'cairo',
        primaryColor: Colors.teal,
      ),
      title: 'Taskati',
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

/*

this is your function
          DateTime curDay = DateTime.now();
          print(curDay);
          String now = DateTime.now().toString().substring(8, 10);
          int day = int.parse(now) + 1;
          //print(day);
          DateTime expectedTime = DateTime(curDay.year, curDay.month, day,
              curDay.hour, curDay.minute, curDay.microsecond);
          print(expectedTime.toString());
          int i = curDay.difference(expectedTime).inMinutes;

          //  print(int.parse(i.toString()));
          print(i); */