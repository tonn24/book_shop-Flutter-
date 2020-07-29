import 'package:flutter/material.dart';
import '../screens/edit_book_screen.dart';

class UserBookItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;


  UserBookItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100.0,
        child: Row(children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(EditBookScreen.routeName, arguments: id );
            },
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
              color: Theme.of(context).errorColor,
          )
        ],),
      ),
    );
  }
}
