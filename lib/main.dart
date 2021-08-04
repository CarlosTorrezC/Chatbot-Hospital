import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/login.dart';
import 'view/chat.dart';
import 'view/register.dart';
//import 'package:chatmed/service/loginservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  //final LoginService loginAuth = LoginService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: 'login',
      routes: {
        'login': (_) => LoginPage(),
        'register': (_) => Register(),
        'chat': (_) => Chat(),
      },
      debugShowCheckedModeBanner: false,
      //home: MyHomePage(title: 'Med Chat +'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: LoginPage()));
  }
}
