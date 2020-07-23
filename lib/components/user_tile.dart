import 'package:flutter/material.dart';
import 'package:flutter_crud/models/provider/user.dart';
import 'package:flutter_crud/models/provider/users.dart';
import 'package:flutter_crud/models/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatefulWidget {
  final User user;

  const UserTile(this.user);

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    final avatar = widget.user.avatarUrl == null ||
            widget.user.avatarUrl.isEmpty
        ? CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(backgroundImage: NetworkImage(widget.user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(widget.user.name),
      subtitle: Text(widget.user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                color: Colors.orange,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: widget.user,
                  );
                }),
            //finished ROW //

            IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: Colors.lightGreen,
                      title: Text('Excluir usuário'),
                      content: Text('Tem certeza ???'),
                      actions: <Widget>[
                        FlatButton(
                          textColor: Colors.red,
                          child: Text('Não'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        FlatButton(
                          child: Text('Sim'),
                          textColor: Colors.red,
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
                    ),
                  ).then((confimed) {
                    if (confimed) {
                      Provider.of<Users>(context, listen: false)
                          .remove(widget.user);
                    }
                  });
                }),
          ],
        ),
      ),
    );
  }
}
