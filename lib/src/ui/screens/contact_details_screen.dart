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
      body: SingleChildScrollView(
        child: Container(
          height: _deviceSize.height,
          width: _deviceSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: _buildHeader(_deviceSize, context),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  width: _deviceSize.width,
                  padding: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'OTHER DETAILS',
                        style: Theme.of(context)
                            .textTheme
                            .display2
                            .copyWith(color: Colors.grey[400]),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 20),
                      _buildPhoneDetails(context),
                      SizedBox(height: 20),
                      _buildEmailDetails(context),
                      SizedBox(height: 20),
                      _buildBirthDayDetails(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildBirthDayDetails(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.cake, color: Colors.grey[400]),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Birthday',
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(color: Colors.grey[400]),
              ),
              SizedBox(height: 5),
              Text(contact.birthDay,
                  style: Theme.of(context).textTheme.display1)
            ],
          ),
        )
      ],
    );
  }

  Row _buildEmailDetails(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.email, color: Colors.grey[400]),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Email Address',
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(color: Colors.grey[400]),
              ),
              SizedBox(height: 5),
              Text(contact.emailAddress,
                  style: Theme.of(context).textTheme.display1)
            ],
          ),
        )
      ],
    );
  }

  Row _buildPhoneDetails(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.phone, color: Colors.grey[400]),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Phone Number',
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(color: Colors.grey[400]),
              ),
              SizedBox(height: 5),
              Text(contact.phoneNumber,
                  style: Theme.of(context).textTheme.display1)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHeader(Size _deviceSize, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      width: _deviceSize.width,
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: contact.contactId,
            child: AvatarFadeImage(imageUrl: contact.avatar, imageSize: 120),
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
          Text(
            contact.phoneNumber,
            style: Theme.of(context)
                .textTheme
                .display2
                .copyWith(fontSize: 20, color: Colors.black26),
          )
        ],
      ),
    );
  }
}
