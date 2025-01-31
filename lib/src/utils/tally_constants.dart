enum ChatButton { ACCOUNT, INTERNET, RELOCATION, LEGEND, USER }

class TallyConstants {
  static const title = "My Legend";

  static const internet = "internet";
  static const account = "account";
  static const relocation = "relocation";
}

class TallyNotificationConstants {
  static chatNotificationTitle(
      {required String name, required String username}) {
    return "User $username, $name has sent you a chat.";
  }

  static chatNotificationBody({required String message}) {
    return "${message.length < 20 ? message : message.substring(0, 20)} ";
  }

  static const ticketCreated =
      "You have successfully created a new ticket. You can check for updates on MyTickets.";

  static messageRequest({required String username, required String name}) {
    return "$name has sent you a chat request";
  }

  static messageRequestReply(
      {required String username, required String reply}) {
    return "User $username has ${reply.toUpperCase()}ED your request";
  }
}
