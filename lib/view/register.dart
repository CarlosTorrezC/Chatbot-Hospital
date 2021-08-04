//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatmed/service/loginservice.dart';
import 'package:chatmed/model/usermodel.dart';
import 'package:chatmed/provider/userprovider.dart';

class Register extends StatelessWidget {
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _passwordRepeatController = new TextEditingController();

  final _userModel = new UserModel();
  final _userProvider = new UserProvider();
  String _email;
  String _password;
  String _passwordRepeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                    height: kToolbarHeight,
                    width: double.infinity,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Bienvenido a',
                                style: GoogleFonts.getFont('Inter',
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            Text(' Med +',
                                style: GoogleFonts.getFont('Inter',
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                          ],
                        ))),
                SizedBox(height: 40),
                _TextFieldCustom(
                  label: 'Correo Electronico',
                  icon: Icons.email_outlined,
                  controller: _emailController,
                ),
                _TextFieldCustom(
                  label: 'Contraseña',
                  icon: Icons.lock_outline_rounded,
                  controller: _passwordController,
                ),
                _TextFieldCustom(
                    label: 'Repetir Contraseña',
                    icon: Icons.lock_outline_rounded,
                    controller: _passwordRepeatController),
                GestureDetector(
                  onTap: () async {
                    LoginService loginAuth = LoginService();
                    _email = _emailController.text.toString();
                    _password = _passwordController.text.toString();
                    _passwordRepeat = _passwordRepeatController.text.toString();
                    if (_password == _passwordRepeat) {
                      UserCredential userCredential =
                          await loginAuth.register(_email, _password, context);
                      if (userCredential != null) {
                        if (userCredential.user != null) {
                          _userModel.uid = userCredential.user.uid;
                          _userModel.email = _email;
                          _userModel.password = _password;

                          // ref.child("users").push().set({
                          //   "email": _userModel.email,
                          //   "password": _userModel.password,
                          //   "uid": _userModel.password
                          // }).asStream();

                          _userProvider.crearUsuario(_userModel).then((value) {
                            showToast(context, 'datos registrados...');
                            _emailController.clear();
                            _passwordRepeatController.clear();
                            _passwordController.clear();
                            Navigator.of(context).pushNamed('login');
                          });
                        } else {
                          showToast(context, 'usuario no encontrado');
                        }
                      } else {
                        showToast(context, 'no se pudo registrar datos');
                      }
                    } else {
                      showToast(context, 'Contraseñas no coinciden');
                    }
                  },
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xff2C75DC)),
                    child: Center(
                        child: Text('Registrar',
                            style: GoogleFonts.getFont('Inter',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500))),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ya tienes una cuenta?',
                            style: GoogleFonts.getFont('Inter',
                                fontSize: 17, color: Color(0xff757999))),
                        GestureDetector(
                            onTap: () =>
                                Navigator.of(context).pushNamed('login'),
                            child: Text(' Inicia Sesión',
                                style: GoogleFonts.getFont('Inter',
                                    fontSize: 17, fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class _TextFieldCustom extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;

  const _TextFieldCustom({this.label, this.icon, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: this.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xfff3f4f6),
          hintText: this.label,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(this.icon),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          floatingLabelBehavior: FloatingLabelBehavior.never,
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
