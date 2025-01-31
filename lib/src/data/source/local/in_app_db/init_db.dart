import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class InitDb {

   var dbPath = "";

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    dbPath = join(path, "myy_legend.db");

    print("This is the in-app DB path === $dbPath");

    return openDatabase(dbPath,
        onCreate: (database, version) {
          database.execute(
            "CREATE TABLE Notifications (id INTEGER PRIMARY KEY AUTOINCREMENT, notificationId TEXT NOT NULL, username TEXT NOT NULL, notificationBody TEXT NOT NULL, notificationTitle TEXT NOT NULL, isRead TEXT NOT NULL, isArchived TEXT NOT NULL, dateAdded TIMESTAMP NOT NULL, updatedAt TIMESTAMP NOT NULL)",
          );
          database.execute(
            "CREATE TABLE Tickets (id INTEGER PRIMARY KEY AUTOINCREMENT, ticketId TEXT NOT NULL, username TEXT NOT NULL, splitterName TEXT NULL, ticketNumber TEXT NULL, description TEXT NULL, status TEXT NULL, alternateNumber TEXT NULL, alternateEmail TEXT NULL, networkFaultType TEXT NULL, assignedBy TEXT NULL, assignedDepartment TEXT NULL, assignedTo TEXT NULL, compDate TEXT NULL, priority TEXT NULL, phase TEXT NULL, ownerId TEXT NULL, ownerType TEXT NULL,  createdAt TIMESTAMP NULL, updatedAt TIMESTAMP NULL)",
          );
        }, version: 2);
  }

  Future deleteDB() async {
    await deleteDatabase(dbPath);
  }


   Future closeDB() async {
     var db = await initializeDB();
     await db.close();
   }

}