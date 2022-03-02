import 'dart:async';

import 'package:android_dates/blocs/nav_bar_cubit/cubit/navbar_cubit.dart';
import 'package:android_dates/blocs/tasks_cubit/cubit/tasks_cubit.dart';
import 'package:android_dates/constants/strings.dart';
import 'package:android_dates/models/task.dart';
import 'package:android_dates/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksListView extends StatelessWidget {
  TasksListView({Key? key, required this.date}) : super(key: key);
  final String date;
  List<Task> localTasks = [];
  int? curindex;

  @override
  Widget build(BuildContext context) {
    var bloc = TasksCubit.get(context);

    return BlocConsumer<NavbarCubit, NavbarState>(
      listener: (context, state) {
        if (state is ChangeDateAndTimeState &&
            !NavbarCubit.get(context).isDate) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        curindex = NavbarCubit.get(context).currentIndex;

        return BlocConsumer<TasksCubit, TasksState>(
          listener: (context, state) {
            if (state is LoadingState) {
              bloc.changeState();
            }
          },
          builder: (context, state) {
            if (curindex == 0) {
              localTasks = [];
              for (var task in bloc.tasks) {
                if (task.isDone == 0 && task.isArchive == 0) {
                  localTasks.add(task);
                }
              }
            }
            if (curindex == 1) {
              localTasks = [];
              for (var task in bloc.tasks) {
                if (task.isDone == 1 && task.isArchive == 0) {
                  localTasks.add(task);
                }
              }
            }
            if (curindex == 2) {
              print("d5l hena");
              localTasks = [];
              for (var task in bloc.tasks) {
                print("d5l hena bardo");
                if (task.date == date) {
                  if (task.isArchive == 1) {
                    print("heeeeeeh");
                    localTasks.add(task);
                  }
                }
              }
            }
            return localTasks.isNotEmpty && state is! LoadingState
                ? Container(
                    padding: const EdgeInsets.all(4),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          var tasks = bloc.tasks[index];
                          return Dismissible(
                            background: Container(
                              child: Center(
                                child: Text(
                                  "Delete",
                                  style: kTextStyleMain,
                                ),
                              ),
                              color: Colors.red,
                            ),
                            key: UniqueKey(),
                            onDismissed: (direc) {
                              bloc.deleteDog(localTasks[index]);
                            },
                            child: TaskItem(
                              functionCheckBoxIsHabit: (bool v) {
                                bloc.toggleIsHabitCubit(
                                    dog: localTasks[index], isHabit: v);
                              },
                              functionCheckBox: (bool v) {
                                bloc.toggleIsDoneCubit(
                                    dog: localTasks[index], isDone: v);
                              },
                              fun: () {
                                bloc.toggleIsArchiveCubit(
                                  dog: localTasks[index],
                                );
                              },
                              task: localTasks[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 5,
                          );
                        },
                        itemCount: localTasks.length),
                  )
                : Center(
                    child: Text(
                      "There is no Tasks here",
                      style: kTextStyleMain,
                    ),
                  );
          },
        );
      },
    );
  }
}
