import 'package:flutter/material.dart';
import 'package:flutter_crud/models/provider/users.dart';
import 'package:flutter_crud/models/views/user_form.dart';
import 'package:provider/provider.dart';
import 'models/routes/app_routes.dart';
import 'models/views/user_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // multiprovider)
          create: (ctx) => Users(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.HOME: (_) => UserList(),
          AppRoutes.USER_FORM: (_) => Userform(),
        },
      ),
    );
  }
}
