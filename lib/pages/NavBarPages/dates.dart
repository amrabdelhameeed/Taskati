import 'package:android_dates/widgets/dates_list_view.dart';
import 'package:android_dates/widgets/task_list_view.dart';
import 'package:flutter/material.dart';

class DatesScreen extends StatelessWidget {
  const DatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DatesListView(),
    );
  }
}
