import 'package:code_challenge/src/models/contact_model.dart';
import 'package:code_challenge/src/ui/widgets/contact_list_tile.dart';
import 'package:flutter/material.dart';

class ContactSearch extends SearchDelegate<List<Contact>> {
  final List<Contact> contacts;

  ContactSearch(this.contacts);

  @override
  String get searchFieldLabel => 'Search Contacts';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _getResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _getResults();
  }

  Widget _getResults() {
    final results = contacts.where(
        (c) => c.contactName.toLowerCase().contains(query.toLowerCase()));

    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: results.length,
      itemBuilder: (BuildContext context, int index) {
        Contact contact = results.elementAt(index);
        return ContactListTile(contact: contact);
      },
    );
  }
}
