class Alert {
  final String title;
  final String subject;
  final DateTime time;

  Alert({this.title, this.subject, this.time});
}

List<Alert> recentAlerts = [
  Alert(
    title: "Math Test",
    subject: "Trigonometry",
    time: DateTime.parse("2020-06-06 12:30:00"),
  ),
  Alert(
    title: "Physics Test",
    subject: "Gravitation",
    time: DateTime.parse("2020-06-06 14:30:00"),
  ),
  Alert(
    title: "Computer Test",
    subject: "Python",
    time: DateTime.parse("2020-06-14 06:30:00"),
  ),
  Alert(
    title: "History Test",
    subject: "Gravitation",
    time: DateTime.parse("2020-06-20 22:45:00"),
  ),
];
