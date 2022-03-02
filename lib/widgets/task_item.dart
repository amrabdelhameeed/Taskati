import 'package:android_dates/app_router.dart';
import 'package:android_dates/blocs/nav_bar_cubit/cubit/navbar_cubit.dart';
import 'package:android_dates/constants/strings.dart';
import 'package:android_dates/models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskItem extends StatelessWidget {
  TaskItem(
      {Key? key,
      required this.task,
      required this.functionCheckBoxIsHabit,
      required this.fun,
      required this.functionCheckBox})
      : super(key: key);
  final Task task;
  final Function functionCheckBoxIsHabit;
  final VoidCallback fun;
  final Function functionCheckBox;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavbarCubit, NavbarState>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = NavbarCubit.get(context);
        return InkWell(
          onLongPress: () {
            NavbarCubit.get(context).currentIndex != 2 ? fun() : null;
          },
          child: Container(
            height: 130,
            child: Card(
              color: Colors.teal.shade700,
              child: Column(
                children: [
                  Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Text(
                                  task.name,
                                  style: kTextStyleMain,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      task.date,
                                      style: kTextStyleSmall,
                                    ),
                                    Text(
                                      task.time,
                                      style: kTextStyleSmall,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      )),
                  Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                  Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: navbarCubit.currentIndex != 2
                            ? MainAxisAlignment.spaceAround
                            : MainAxisAlignment.center,
                        children: [
                          NavbarCubit.get(context).currentIndex != 2
                              ? Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Habit",
                                        style: kTextStyleSmall,
                                      ),
                                      Theme(
                                        data: ThemeData(
                                            unselectedWidgetColor:
                                                Colors.white),
                                        child: Checkbox(
                                            activeColor: Colors.teal.shade800,
                                            splashRadius: 5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            checkColor: Colors.white,
                                            value: task.isHabit == 1,
                                            onChanged: (v) {
                                              NavbarCubit.get(context)
                                                          .currentIndex !=
                                                      2
                                                  ? functionCheckBoxIsHabit(v)
                                                  : null;
                                            }),
                                      )
                                    ],
                                  ),
                                )
                              : Text(""),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "Done",
                                  style: kTextStyleSmall,
                                ),
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor: Colors.white),
                                  child: Checkbox(
                                      activeColor: Colors.teal.shade800,
                                      splashRadius: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      value: task.isDone == 1,
                                      onChanged: (v) {
                                        NavbarCubit.get(context).currentIndex !=
                                                2
                                            ? functionCheckBox(v)
                                            : null;
                                      }),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
