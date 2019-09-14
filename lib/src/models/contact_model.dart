import 'package:flutter/material.dart';

class Contact {
  int contactId;
  String contactName;
  String contactGroup;
  String phoneNumber;
  String avatar;
  bool isOnline = false;

  Contact(
      {@required this.contactId,
      @required this.contactName,
      @required this.contactGroup,
      @required this.phoneNumber,
      @required this.avatar,
      this.isOnline});
}
