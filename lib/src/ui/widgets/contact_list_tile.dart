import 'package:code_challenge/src/models/contact_model.dart';
import 'package:code_challenge/src/ui/screens/contact_details_screen.dart';
import 'package:flutter/material.dart';

class ContactListTile extends StatelessWidget {
  const ContactListTile({
    Key key,
    @required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: contact.contactId,
        child: CircleAvatar(
          radius: 24.0,
          backgroundImage: AssetImage(contact.avatar),
        ),
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
  }
}
