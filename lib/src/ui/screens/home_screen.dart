import 'package:code_challenge/src/models/contact_model.dart';
import 'package:code_challenge/src/services/address_book_service.dart';
import 'package:code_challenge/src/ui/screens/contact_details_screen.dart';
import 'package:code_challenge/src/ui/widgets/avatar_fade_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, List<Contact>> groupedContacts;

  @override
  void initState() {
    super.initState();
    final addressBook = AddressBook()..generateAddressBook();
    groupedContacts = addressBook.groupedContacts;
  }

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts', style: Theme.of(context).textTheme.display3),
        elevation: 0,
        centerTitle: false,
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
              //Spacer(),
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
        return ListTile(
          leading: Hero(
            tag: contact.contactId,
            child: AvatarFadeImage(imageUrl: contact.avatar, imageSize: 50),
          ),
          title: Text(
            contact.contactName,
            style: Theme.of(context).textTheme.display1,
          ),
          subtitle: Text(
            contact.phoneNumber,
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: Colors.grey[400]),
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ContactDetailsScreen(contact: contact))),
        );
      },
    );
  }
}
