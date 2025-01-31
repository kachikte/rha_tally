class AppNotificationModel {
  String id = "";
  String username = "";
  String notificationBody = "";
  String notificationTitle = "";
  bool isRead = false;
  bool isArchived = false;
  dynamic dateAdded;
  dynamic updatedAt;

  AppNotificationModel(
      {required this.id,
        required this.username,
        required this.notificationBody,
        required this.notificationTitle,
        required this.isRead,
        required this.isArchived,
        required this.updatedAt,
        required this.dateAdded});

  toMap() {
    var data = {
      'notificationId': id,
      'username': username,
      'notificationBody': notificationBody,
      'notificationTitle': notificationTitle,
      'isRead': isRead.toString(),
      'isArchived': isArchived.toString(),
      'dateAdded': dateAdded.toString(),
      'updatedAt': updatedAt.toString()
    };
    return data;
  }

  AppNotificationModel.fromMap(map) {
    id = map['notificationId'];
    username = map['username'];
    notificationBody = map['notificationBody'];
    notificationTitle = map['notificationTitle'];
    isRead = map['isRead'].toString().toLowerCase() == "true" ? true : false;
    isArchived = map['isArchived'].toString().toLowerCase() == "true" ? true : false;
    dateAdded = map['dateAdded'] as dynamic;
    updatedAt = map['updatedAt'] as dynamic;
  }

}
