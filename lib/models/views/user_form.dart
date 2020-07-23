import 'package:flutter/material.dart';
import 'package:flutter_crud/models/provider/user.dart';
import 'package:flutter_crud/models/provider/users.dart';
import 'package:provider/provider.dart';

class Userform extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

    _loadFormData(user);
    Border(bottom: BorderSide(color: Theme.of(context).dividerColor));
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de usuário'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isvalid = _form.currentState.validate();

              if (isvalid) {
                _form.currentState.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    name: _formData['name'],
                    email: _formData['email'],
                    avatarUrl: _formData['avatarUrl'],
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData['Name'],
                  decoration: InputDecoration(labelText: 'Nome completo'),
                  textAlign: TextAlign.center,
                  cursorColor: Colors.amber,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ' obrigatório';
                    }

                    if (value.trim().length < 2) {
                      return 'Nome muito curto, no minimo 3 letras';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value,
                ),
                TextFormField(
                  initialValue: _formData['E-mail'],
                  decoration: InputDecoration(labelText: 'E-mail'),
                  cursorColor: Colors.amber,
                  textAlign: TextAlign.center,
                  onSaved: (value) => _formData['email'] = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'E-mail obrigatório';
                    }

                    if (value.trim().length < 3) {
                      return 'Somente < >  . _ ! & @  ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: InputDecoration(labelText: 'Url do avatar'),
                  cursorColor: Colors.amber,
                  textAlign: TextAlign.center,
                  onSaved: (value) => _formData['avatarUrl'] = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '';
                    }
                    return null;
                  },
                ),
              ],
            )),
      ),
    );
  }
}
