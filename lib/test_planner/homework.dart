class Homework {
  final String title;
  final DateTime dueTime;
  bool isDone = false;

  Homework({this.title, this.dueTime});
}

List<Homework> recentHomeworks = [
  Homework(
    title: "Boundary Value Exercises",
    dueTime: DateTime.parse("2020-06-08 10:30:00"),
  ),
  Homework(
    title: "Use Case Exercises",
    dueTime: DateTime.parse("2020-06-09 14:30:00"),
  ),
  Homework(
    title: "Visicosity Exercises",
    dueTime: DateTime.parse("2020-06-15 15:30:00"),
  ),
  Homework(
    title: "Thermodynamics Exercises",
    dueTime: DateTime.parse("2020-06-19 06:15:00"),
  ),
  Homework(
    title: "Python Programs",
    dueTime: DateTime.parse("2020-06-20 09:45:00"),
  ),
];
