import 'dart:math';

import 'package:code_challenge/src/models/contact_model.dart';

class AddressBook {
  List<Contact> _contacts = [];
  Map<String, List<Contact>> _groupedContacts;

  List<Contact> get contacts => this._contacts;
  Map<String, List<Contact>> get groupedContacts => this._groupedContacts;

  final _rawContacts = <String>[
    'Adi Shamir',
    'Alan Kay',
    'Barbara Liskov',
    'Kristen Nygaard',
    'Leonard Adleman',
    'Leslie Lamport',
    'Ole-Johan Dahl',
    'Peter Naur',
    'Robert E. Kahn',
    'Ronald L. Rivest',
    'Vinton G. Cerf',
    'Andrew Yao'
  ];

  void generateAddressBook() {

    //Sort Contacts
    this
        ._rawContacts
        .sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    this._rawContacts.forEach((c) {

      //Random number value
      int randomNumber = Random().nextInt(23);

      //Generates a List of Contacts
      this._contacts.add(
            new Contact(
                contactId: Random().nextInt(5000),
                contactName: c,
                contactGroup: c.substring(0, 1).toUpperCase(),
                phoneNumber: '(506) 8${randomNumber}3-${randomNumber}13',
                avatar: 'assets/images/$randomNumber.jpg',// 'https://i.pravatar.cc/300?img=$randomNumber',
                isOnline: Random().nextBool(),
                emailAddress: '${c.split(" ").join("")}@gmail.com',
                birthDay: '1981-09-17'),
                

          );
    });

    //Group Contacts by contactGroup field.
    this._groupedContacts =
        _groupBy(this._contacts, (contact) => contact.contactGroup);
  }

  Map<T, List<S>> _groupBy<S, T>(Iterable<S> values, T key(S element)) {
    var map = <T, List<S>>{};
    for (var element in values) {
      var list = map.putIfAbsent(key(element), () => []);
      list.add(element);
    }
    return map;
  }
}
