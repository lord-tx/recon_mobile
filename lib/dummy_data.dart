import 'package:recon_mobile/user_model.dart';

import 'chat_bubble.dart';
import 'enums.dart';

/// Dummy Data
List<User> users = [
  User(
    2,
    "Catalina",
    true,
    "http://giving.jjay.cuny.edu/wp-content/uploads/2019/05/cruz-e1561038448348.jpg"
  )
];

List<ChatBubble> dummyChats = const [
  ChatBubble(
    item: "The meeting should begin.",
    itemType: ChatItemType.text,
    type: ChatType.received,
  ),
  ChatBubble(
    item: "The meeting should begin.The meeting should begin.The meeting should begin.The meeting should begin.The meeting should begin.",
    itemType: ChatItemType.text,
    type: ChatType.sent,
  ),
  ChatBubble(
    item: "The meeting should begin.",
    itemType: ChatItemType.text,
    type: ChatType.received,
  ),
  ChatBubble(
    item: "https://s3-alpha-sig.figma.com/img/63f1/ce3c/207901c55474f4be1c61e2bf2cd1a1f2?Expires=1670198400&Signature=XTTigzQpuGxcdmAIHWIhoWQTd0fVyPFvMlD3bIForTJbune6haajoAL77ti3yz7nP~s2YEO9VVC45e5qBoElg3jjEWjh4f-mJmaCpi4LOG7Rhn3PQFMvt5wehKTDXRiwNdziHgSaONnBtVq--A~5IXi6qSuKCXdbUGIjZcYOlZuroRAUeuN7qqhuDkCUHFB0rB~BjiImV8P6yh7k4vWLprjOEWbI3XrrgoFrKlISoxGD1rHDnI4imF3Li12y8oAPclOeD6F5habf8namjI6vSdSz4AplCxyOkn0CaLakZrJLj2dfpLhL4uGJzzyfMtRlXN1cxZFSfqOWEbJZyzbiTA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",
    itemType: ChatItemType.image,
    type: ChatType.received,
    caption: "Your Doppel Ganger",
  ),
];