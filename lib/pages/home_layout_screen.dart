import 'package:android_dates/app_router.dart';
import 'package:android_dates/blocs/nav_bar_cubit/cubit/navbar_cubit.dart';
import 'package:android_dates/blocs/tasks_cubit/cubit/tasks_cubit.dart';
import 'package:android_dates/main.dart';
import 'package:android_dates/widgets/my_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavbarCubit, NavbarState>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = NavbarCubit.get(context);
        return Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.teal,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => BlocProvider<NavbarCubit>.value(
                            value: navbarCubit,
                            child: BlocProvider<TasksCubit>.value(
                                value: tasksCubit, child: MyBottomSheet()),
                          ));
                },
                child: Icon(
                  bloc.iconDataCubit,
                  color: Colors.white,
                )),
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Text(bloc.labels[bloc.currentIndex]),
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.teal.shade200,
              currentIndex: bloc.currentIndex,
              onTap: (index) {
                bloc.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.list), label: "Tasks"),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.date_range), label: "Archive"),
              ],
            ),
            body: bloc.pages[bloc.currentIndex]);
      },
    );
  }

  // bool dateCalculator(DateTime dateTime) {
  //   date = dateTime;
  //   int dayString = int.parse(dateTime.toString().substring(8, 10)) + 1;
  //   DateTime finalDate = DateTime(dateTime.year, dateTime.month, dayString);
  //   print(finalDate);
  //   if (finalDate.difference(dateTime).inMinutes > 0) {
  //     return true;
  //   }
  //   return false;
  // }
}

/*
                  if (!bloc.isOpenCubit) {
                    scaffoldKey.currentState!
                        .showBottomSheet((context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                color: Colors.grey,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            label: Text("Task Title")),
                                        autofocus: true,
                                        controller: textcont,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.parse(
                                                        "2021-12-31"))
                                                .then((value) {
                                              date = value;
                                              dateString = date.toString();
                                              // dateCalculator(value!);
                                              // print(dateCalculator(value));
                                            });
                                          },
                                          child: Text(date != null
                                              ? dateString!
                                              : "date")),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            ).then((value) {
                                              time = value!
                                                  .format(context)
                                                  .toString();
                                            });
                                          },
                                          child: Text("${time ?? "time"}")),
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        })
                        .closed
                        .then((value) {
                          bloc.changeFABIcon(false, Icons.edit);
                        });
                    bloc.changeFABIcon(true, Icons.add);
                  } else {
                    if (date != null &&
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
                    }
                  }
                 */