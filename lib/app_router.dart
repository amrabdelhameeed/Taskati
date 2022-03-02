import 'package:android_dates/blocs/nav_bar_cubit/cubit/navbar_cubit.dart';
import 'package:android_dates/blocs/tasks_cubit/cubit/tasks_cubit.dart';
import 'package:android_dates/constants/strings.dart';
import 'package:android_dates/main.dart';
import 'package:android_dates/pages/home_layout_screen.dart';
import 'package:android_dates/pages/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

TasksCubit tasksCubit = TasksCubit();
NavbarCubit navbarCubit = NavbarCubit();

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeLayout:
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<NavbarCubit>.value(
                value: navbarCubit,
                child: HomeLayout(),
              ),
              BlocProvider<TasksCubit>.value(
                value: tasksCubit..any(),
                child: HomeLayout(),
              ),
            ],
            child: HomeLayout(),
          );
        });
      case "/":
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<TasksCubit>.value(
            value: tasksCubit
              ..initializingSharedPrefrenceStuff()
              ..createDB(),
            child: SplashScreen(),
          );
        });
    }
  }
}
