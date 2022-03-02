import 'package:android_dates/blocs/nav_bar_cubit/cubit/navbar_cubit.dart';
import 'package:android_dates/blocs/tasks_cubit/cubit/tasks_cubit.dart';
import 'package:android_dates/constants/strings.dart';
import 'package:android_dates/widgets/task_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatesListView extends StatefulWidget {
  DatesListView({Key? key}) : super(key: key);

  @override
  State<DatesListView> createState() => _DatesListViewState();
}

class _DatesListViewState extends State<DatesListView> {
  String date = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavbarCubit, NavbarState>(
      listener: (context, state) {
        if (state is NavBarChangeIndex &&
            NavbarCubit.get(context).isModalHistory) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return BlocConsumer<TasksCubit, TasksState>(
          listener: (context, state) {},
          builder: (context, state) {
            var navBloc = NavbarCubit.get(context);
            var bloc = TasksCubit.get(context);
            var dates = navBloc.dates;
            dates = [];
            bloc.tasks.forEach((task) {
              if (task.isArchive == 1) {
                dates.add(task.date);
              }
            });
            dates = dates.toSet().toList();
            dates.sort((a, b) => a.compareTo(b));
            return !navBloc.isDate && dates.isNotEmpty
                ? Container(
                    padding: EdgeInsets.all(3),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              date = dates[index];
                              navBloc.toggleIsDate(true);
                            });
                            navBloc.changeIsModalHistory(true);
                            ModalRoute.of(context)?.addLocalHistoryEntry(
                                LocalHistoryEntry(onRemove: () {
                              setState(() {
                                navBloc.changeIsModalHistory(false);
                                navBloc.toggleIsDate(false);
                              });
                            }));
                          },
                          child: Card(
                            color: Colors.black12.withOpacity(0.1),
                            child: Container(
                              height: 80,
                              child: Center(
                                child: Text(
                                  dates[index],
                                  style: kTextStyleMain,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: dates.length,
                    ),
                  )
                : TasksListView(
                    date: date,
                  );
          },
        );
      },
    );
  }
}
