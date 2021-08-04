import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat.dart';
import 'package:chatmed/service/loginservice.dart';
//import 'package:

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  String _email = "";
  String _password = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: login(context));
  }

  Widget login(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text('Med +',
                  style: GoogleFonts.getFont('Inter',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
              SizedBox(height: 10),
              Text('', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 30),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xfff3f4f6),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Correo Electronico',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.email_outlined),
                    floatingLabelBehavior: FloatingLabelBehavior.never),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                //obscureText: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xfff3f4f6),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Contraseña',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    floatingLabelBehavior: FloatingLabelBehavior.never),
              ),
              SizedBox(height: 15),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text('',
                      style: GoogleFonts.getFont('Inter',
                          color: Color(0xff757999)))),
              SizedBox(height: 20),
              loading
                  ? Center(child: CircularProgressIndicator(color: Colors.blue))
                  : GestureDetector(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });

                        LoginService loginAuth = LoginService();
                        _email = emailController.text.toString();
                        _password = passwordController.text.toString();

                        User user =
                            await (loginAuth.login(_email, _password, context));
                        if (user != null) {
                          final SharedPreferences prefs = await _prefs;
                          prefs
                              .setString("correo", _email)
                              .then((bool success) {
                            return _email;
                          });
                          showToast(context, "Bienvenido");
                          emailController.clear();
                          passwordController.clear();

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Chat();
                          }));
                        } else {
                          showToast(context, "Credenciales Incorrectos");
                          emailController.clear();
                          passwordController.clear();
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xff2C75DC)),
                        child: Center(
                            child: Text('Ingresar',
                                style: GoogleFonts.getFont('Inter',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500))),
                      ),
                    ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: Text(''),
              ),
              SizedBox(height: 30),
              SizedBox(height: 15),
              SizedBox(height: 50),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('No tienes una cuenta?',
                    style: GoogleFonts.getFont('Inter',
                        fontSize: 17, color: Color(0xff757999))),
                SizedBox(width: 5),
                GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, 'register'),
                    child: Text('Registrate',
                        style: GoogleFonts.getFont('Inter',
                            fontSize: 17, fontWeight: FontWeight.bold))),
              ])
            ],
          ),
        ),
      ),
    );
  }
}

void showToast(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(mensaje),
    duration: Duration(seconds: 2),
  ));
}
