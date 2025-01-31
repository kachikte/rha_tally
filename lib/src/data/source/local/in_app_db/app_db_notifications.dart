import 'package:sqflite/sqflite.dart';
import 'package:rha/src/data/data.dart';
import 'package:rha/src/domain/domain.dart';

class AppDBNotifications {
  InitDb initDb = InitDb();

  Future dropNotificationTable() async {
    print("deleting local notification === ");
    final Database db = await initDb.initializeDB();
    await db.delete('Notifications');
  }

  Future<int> createNotification(
      {required AppNotificationModel appNotificationModel}) async {
    print("creating local notification === ");
    final Database db = await initDb.initializeDB();
    int result = await db.insert('Notifications', appNotificationModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    print("created local notification === ");

    return result;
  }

  Future createMultipleNotifications(
      {required List<AppNotificationModel> appNotificationModels}) async {
    print("creating local notificationsss === ");
    final Database db = await initDb.initializeDB();

    db.transaction((txn) async {
      var batch = txn.batch();
      for (var notification in appNotificationModels) {
        batch.insert('Notifications', notification.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(continueOnError: true, noResult: true);
    });

    print("created local notificationssss === ");
  }

  Future<AppNotificationModel> getParticularNotification(
      {required String id}) async {
    final db = await initDb.initializeDB();
    final List<Map<String, Object?>> result = await db
        .query('Notifications', where: "notificationId = ?", whereArgs: [id]);
    // await db.query('Tickets', orderBy: TicketsColumn.createdAt);
    return AppNotificationModel.fromMap(result[0]);
  }

  Future<List<AppNotificationModel>> getNotifications() async {
    final db = await initDb.initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('Notifications', limit: 5);
    // await db.query('Tickets', orderBy: TicketsColumn.createdAt);
    return queryResult.map((e) => AppNotificationModel.fromMap(e)).toList();
  }

  Future<void> deleteNotifications(String id) async {
    final db = await initDb.initializeDB();
    try {
      await db.delete("Notifications",
          where: "notificationId = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }

  Future<int> updateNotification(
      AppNotificationModel appNotificationModel) async {
    final db = await initDb.initializeDB();

    var data = appNotificationModel.toMap();

    final result = await db.update('Notifications', data,
        where: "notificationId = ?", whereArgs: [appNotificationModel.id]);
    return result;
  }
}
