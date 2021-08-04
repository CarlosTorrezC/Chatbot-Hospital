import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));
String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  String date_time;
  String dir;
  String message;
  String user;

  ChatModel({this.date_time, this.dir, this.message, this.user});

  factory ChatModel.fromJson(Map<String, dynamic> json) => new ChatModel(
        date_time: json["date_time"],
        dir: json["dir"],
        message: json["message"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "date_time": date_time,
        "dir": dir,
        "message": message,
        "user": user,
      };
}
