import 'dart:math';

import 'package:code_challenge/src/models/contact_model.dart';
import 'package:code_challenge/src/services/address_book_service.dart';
import 'package:code_challenge/src/services/contact_search_service.dart';
import 'package:code_challenge/src/ui/screens/contact_details_screen.dart';
import 'package:code_challenge/src/ui/widgets/contact_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:code_challenge/src/ui/widgets/popup_menu.dart' as mypopup;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, List<Contact>> groupedContacts;
  List<Contact> contacts;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    final addressBook = AddressBook()..generateAddressBook();

    groupedContacts = addressBook.groupedContacts;
    contacts = addressBook.contacts;
  }

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts', style: Theme.of(context).textTheme.display3),
        elevation: 0,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: ContactSearch(contacts));
              }),
          mypopup.PopupMenuButton(
            onSelected: (selectedValue) {},
            icon: Icon(Icons.more_vert),
            itemBuilder: _buildPopupMenu,
          )
        ],
      ),
      body: Container(
          width: _deviceSize.width,
          height: _deviceSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildOnLineContacts(_deviceSize, context),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: groupedContacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    String headerGroup = groupedContacts.keys.elementAt(index);
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 5, top: 4),
                        child: Column(
                          children: <Widget>[
                            _buildGroupHeader(headerGroup),
                            _buildContactItem(headerGroup),
                          ],
                        ));
                  },
                ),
              ),
            ],
          )),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: Theme.of(context).primaryColor,
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 20),
          title: Text('Home', style: Theme.of(context).textTheme.display1),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment, size: 20),
          title: Text('Todo\'s', style: Theme.of(context).textTheme.display1),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 20),
          title: Text('Account', style: Theme.of(context).textTheme.display1),
        )
      ],
    );
  }

  List<mypopup.PopupMenuEntry> _buildPopupMenu(BuildContext ctx) {
    List<mypopup.PopupMenuEntry> menu = [];
    groupedContacts.keys.forEach((g) {
      menu.add(mypopup.PopupMenuItem(
          child: Text(
            g,
            style: Theme.of(context).textTheme.display1.copyWith(fontSize: 12),
          ),
          value: g));
    });
    return menu;
  }

  Widget _buildGroupHeader(String headerGroup) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromRGBO(245, 244, 247, 1),
      ),
      height: 20,
      width: MediaQuery.of(context).size.width * 0.98,
      padding: const EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          headerGroup,
          style: Theme.of(context).textTheme.display2,
        ),
      ),
    );
  }

  Widget _buildContactItem(String headerGroup) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: groupedContacts[headerGroup].length,
      itemBuilder: (BuildContext context, int index) {
        Contact contact = groupedContacts[headerGroup][index];
        return ContactListTile(contact: contact);
      },
    );
  }

  Widget _buildOnLineContacts(Size deviceSize, BuildContext context) {
    return Material(
      elevation: 2,
      child: Container(
        height: deviceSize.height * .08,
        width: deviceSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 0, 4),
              child: Text('Online',
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontSize: 12, color: Colors.grey[400])),
            ),
            Expanded(
                child: ListView(
              scrollDirection: Axis.horizontal,
              children: contacts
                  .where((contact) => contact.isOnline)
                  .map(
                    (contact) => Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: GestureDetector(
                        child: Container(
                          width: 44,
                          child: Column(
                            children: <Widget>[
                              Hero(
                                tag: Random(DateTime.now().millisecondsSinceEpoch),
                                child: CircleAvatar(
                                  radius: 14.0,
                                  backgroundImage: AssetImage(contact.avatar),
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(contact.contactName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                          fontSize: 9, color: Colors.grey[400]),
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  ContactDetailsScreen(contact: contact)),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ))
          ],
        ),
      ),
    );
  }
}
