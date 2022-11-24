// TODO: Add Date below ChatBubble
import 'package:flutter/material.dart';

import 'enums.dart';

class ChatBubble extends StatelessWidget {
  final ChatItemType itemType;
  final dynamic item;
  final ChatType type;
  final String? caption;
  const ChatBubble({Key? key, required this.item, required this.itemType, required this.type, this.caption}) : super(key: key);

  /// These functions would be grouped as a setBubble function
  /// That sets all the values of a bubble in its inception
  /// can also be set during construction of object
  Alignment getAlignment(ChatType type){
    switch (type){
      case ChatType.received:
        return Alignment.centerLeft;
      case ChatType.sent:
        return Alignment.centerRight;
    }
  }

  Color getColor(ChatType type, context){
    switch (type){
      case ChatType.received:
        return Theme.of(context).primaryColor;
      case ChatType.sent:
        return Theme.of(context).cardColor;
    }
  }

  BorderRadius getBorderRadius(ChatType type){
    switch (type){
      case ChatType.received:
        return const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        );
      case ChatType.sent:
        return const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (itemType == ChatItemType.text){
      return Align(
        alignment: getAlignment(type),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            /// This would be based on preset themes
              color: getColor(type, context),
              /// This should be alignment dependent
              borderRadius: getBorderRadius(type)
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: item != null ? Text(item.toString()) : Text(""),
        ),
      );
    } else if (itemType == ChatItemType.image){
      return Align(
        alignment: getAlignment(type),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            /// This would be based on preset themes
              color: getColor(type, context),
              /// This should be alignment dependent
              borderRadius: getBorderRadius(type)
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                    maxHeight: MediaQuery.of(context).size.height * 0.2,
                  ),
                  child: Image.network(item)
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(caption ?? ""),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}