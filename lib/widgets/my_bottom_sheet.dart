import 'package:android_dates/app_router.dart';
import 'package:android_dates/blocs/nav_bar_cubit/cubit/navbar_cubit.dart';
import 'package:android_dates/blocs/tasks_cubit/cubit/tasks_cubit.dart';
import 'package:android_dates/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({Key? key}) : super(key: key);

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  var textcont = TextEditingController();
  DateTime? date;
  String? dateString;
  String? time;
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavbarCubit, NavbarState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<TasksCubit, TasksState>(
          listener: (context, state) {
            if (state is TaskAdded) {
              Navigator.pop(context);
              NavbarCubit.get(context).changeIndex(0);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.teal.shade200,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: "Task Label",
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              hoverColor: Colors.white,
                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal),
                              ),
                              enabledBorder: OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: BorderSide(color: Colors.teal),
                              ),
                              focusedBorder: OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                            autofocus: false,
                            controller: textcont,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.teal.shade800),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse("2023-12-31"))
                                    .then((value) {
                                  setState(() {
                                    date = value;
                                    dateString =
                                        date.toString().substring(0, 10);
                                  });
                                  // dateCalculator(value!);
                                  // print(dateCalculator(value));
                                });
                              },
                              child: Text(
                                date != null ? dateString! : "Date",
                                style: kTextStyleMain,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.teal.shade800),
                              onPressed: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  setState(() {
                                    time = value!.format(context).toString();
                                  });
                                });
                              },
                              child: Text(
                                time ?? "Time",
                                style: kTextStyleMain,
                              )),
                        ),
                        BlocProvider<NavbarCubit>.value(
                          value: navbarCubit,
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: BlocConsumer<NavbarCubit, NavbarState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.teal.shade800),
                                    onPressed: () {
                                      if (date != null &&
                                          time != null &&
                                          dateString != "Date" &&
                                          time != "Dime" &&
                                          textcont.text.isNotEmpty) {
                                        TasksCubit.get(context)
                                            .insertDB(
                                                name: textcont.text,
                                                time: time.toString(),
                                                date: date!)
                                            .then((value) {
                                          textcont.text = "";
                                          dateString = "Date";
                                          time = "Time";
                                          //Navigator.pop(context);
                                          //  print(TasksCubit.get(context).tasks);
                                        });
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    Colors.teal.shade400,
                                                content: Text(
                                                  "Please add task label,date and time :)",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              );
                                            });
                                      }
                                    },
                                    child: Text(
                                      "Add",
                                      style: kTextStyleMain,
                                    ),
                                  );
                                },
                              )),
                        ),
                      ]),
                )
              ],
            );
          },
        );
      },
    );
  }
}
/*if (date != null &&
                        time != null &&
                        dateString != "date" &&
                        time != "time" &&
                        textcont.text.isNotEmpty) {
                      TasksCubit.get(context)
                          .insertDB(textcont.text, time.toString(), date!)
                          .then((value) {
                        textcont.text = "";
                        dateString = "date";
                        time = "time";
                        print(TasksCubit.get(context).tasks);
                      });
                      bloc.changeFABIcon(false, Icons.edit);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Enter valid values !")));
                    } */