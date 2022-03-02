class Task {
  int id;
  String name;
  String time;
  String date;
  int isDone;
  int isArchive;
  int isHabit;
  Task(
      {required this.id,
      this.name = "",
      this.time = "",
      this.date = "",
      this.isDone = 0,
      this.isArchive = 0,
      this.isHabit = 0});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'date': date,
      'isDone': isDone,
      'isArchive': isArchive,
      'isHabit': isHabit
    };
  }

  void toggleIsDone(bool v) {
    if (v) {
      isDone = 1;
    } else {
      isDone = 0;
    }
  }

  void toggleIsHabit(bool v) {
    if (v) {
      isHabit = 1;
    } else {
      isHabit = 0;
    }
  }

  void toggleIsArchive(bool v) {
    if (v) {
      isArchive = 1;
    } else {
      isArchive = 0;
    }
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, isDone: $isDone}';
  }
}
