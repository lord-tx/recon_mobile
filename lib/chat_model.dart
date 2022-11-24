class ChatModel {
  ChatModel({
      this.roomId, 
      this.messageId, 
      this.senderId, 
      this.message, 
      this.messageType, 
      this.receiverId, 
      this.timeStamp, 
      this.reply, 
      this.replyId,});

  ChatModel.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    messageId = json['messageId'];
    senderId = json['senderId'];
    message = json['message'];
    messageType = json['messageType'];
    receiverId = json['receiverId'];
    timeStamp = json['timeStamp'];
    reply = json['reply'];
    replyId = json['replyId'];
  }

  dynamic roomId;
  dynamic messageId;
  dynamic senderId;
  dynamic message;
  dynamic messageType;
  dynamic receiverId;
  dynamic timeStamp;
  dynamic reply;
  dynamic replyId;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['roomId'] = roomId;
    map['messageId'] = messageId;
    map['senderId'] = senderId;
    map['message'] = message;
    map['messageType'] = messageType;
    map['receiverId'] = receiverId;
    map['timeStamp'] = timeStamp;
    map['reply'] = reply;
    map['replyId'] = replyId;
    return map;
  }

}