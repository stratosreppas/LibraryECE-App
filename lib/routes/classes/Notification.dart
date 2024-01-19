class UserNotification {
  final int notificationID;
  final String title;
  final String date;
  final String content;
  final int read;

  UserNotification(
      {this.notificationID = 0,
      this.title = '',
      this.date = '',
      this.content = '',
      this.read = 0});
}
