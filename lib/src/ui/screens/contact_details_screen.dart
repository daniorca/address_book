import 'package:code_challenge/src/models/contact_model.dart';
import 'package:code_challenge/src/ui/widgets/avatar_fade_image.dart';
import 'package:flutter/material.dart';

class ContactDetailsScreen extends StatelessWidget {
  final Contact contact;
  ContactDetailsScreen({this.contact});

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
        elevation: 0,
      ),
      body: Container(
        height: _deviceSize.height,
        width: _deviceSize.width,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              height: _deviceSize.height * .28,
              width: _deviceSize.width,
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: contact.contactId,
                    child: AvatarFadeImage(
                        imageUrl: contact.avatar, imageSize: 120),
                  ),
                  SizedBox(height: 15),
                  Text(
                    contact.contactName,
                    style: Theme.of(context)
                        .textTheme
                        .display2
                        .copyWith(fontSize: 24, color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Text(contact.phoneNumber,
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(fontSize: 20, color: Colors.black26),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
