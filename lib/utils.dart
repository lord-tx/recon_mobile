import 'dart:convert';

import 'package:recon_mobile/chat_bubble.dart';
import 'package:recon_mobile/chat_model.dart';
import 'package:recon_mobile/enums.dart';

ChatModel? parseMessage(dynamic jsonModel){
  ChatModel? model;

  if (jsonModel == null || jsonModel.toLowerCase() == "null"){
    print("Dont parse this JSON");
  } else {
     model = ChatModel.fromJson(json.decode(jsonModel));
  }

  return model;
}

ChatBubble createBubble(ChatModel? model,  int thisUserId){
  return ChatBubble(
      item: model?.message ?? "",
      /// For now, only text
      itemType: ChatItemType.text,
      type: model?.senderId != null ? (model?.senderId == thisUserId ? ChatType.sent : ChatType.received) : ChatType.received
  );
}

ChatModel createMessage({
  required int roomId,
  required int senderId,
  required int receiverId,
  required String message,
  required String messageType,
  required String messageId,
}){
  return ChatModel(
    roomId: roomId,
    senderId: senderId,
    receiverId: receiverId,
    message: message,
    messageType: messageType,
    messageId: messageId,
  );
}