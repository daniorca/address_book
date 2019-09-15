import 'package:code_challenge/src/models/contact_model.dart';
import 'package:code_challenge/src/services/address_book_service.dart';
import 'package:code_challenge/src/services/contact_search_service.dart';
import 'package:code_challenge/src/ui/widgets/contact_list_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, List<Contact>> groupedContacts;
  List<Contact> contacts;

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
            onPressed: () => setState(() async {
              await showSearch(context: context, delegate: ContactSearch(contacts));
            }),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
          width: _deviceSize.width,
          height: _deviceSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: _deviceSize.height * .07,
                color: Colors.grey[200],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: groupedContacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    String headerGroup = groupedContacts.keys.elementAt(index);
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          children: <Widget>[
                            _buildGroupHeader(headerGroup),
                            _buildContactItem(headerGroup),
                          ],
                        ));
                  },
                ),
              ),
              Container(
                height: _deviceSize.height * .1,
                color: Colors.grey[200],
              )
            ],
          )),
    );
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
}



