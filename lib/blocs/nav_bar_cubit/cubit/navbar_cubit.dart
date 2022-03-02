import 'package:android_dates/pages/NavBarPages/dates.dart';
import 'package:android_dates/pages/NavBarPages/done_screen.dart';
import 'package:android_dates/pages/NavBarPages/task_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'navbar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(NavbarInitial());

  static NavbarCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isDate = false;
  List<String> dates = [];
  void toggleIsDate(bool v) {
    isDate = v;
    emit(ChangeIsDateState());
  }

  List<Widget> pages = const [TasksScreen(), DoneScreen(), DatesScreen()];

  List<String> labels = ["Tasks Screen", "Done Screen", "Archive Screen"];

  void changeIndex(int index) {
    currentIndex = index;

    emit(NavBarChangeIndex());
  }

  bool isModalHistory = false;
  void changeIsModalHistory(bool isModal) {
    isModalHistory = isModal;
    emit(ChangeIsModalHistoryState());
  }
  // void emptyDates(BuildContext context) {
  //   isDate = false;
  //   Navigator.of(context).pop(context);
  //   emit(ChangeIsDateState());
  // }

  bool isOpenCubit = false;
  IconData iconDataCubit = Icons.add;
  void changeFABIcon(bool isOpen, IconData iconData) {
    isOpenCubit = isOpen;
    iconDataCubit = iconData;
    emit(ChangeFABIconState());
  }

  String? cubittime;
  DateTime? cubitdate;
  void changeDate(DateTime date) {
    cubitdate = date;
    emit(ChangeDateAndTimeState());
  }

  void changeTime(String time) {
    cubittime = time;
    emit(ChangeDateAndTimeState());
  }

  DateTime dateString() {
    emit(ChangeDateAndTimeState());
    return cubitdate!;
  }

  String timeString() {
    emit(ChangeDateAndTimeState());
    return cubittime!;
  }
}
