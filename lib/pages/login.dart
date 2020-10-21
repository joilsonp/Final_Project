import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;

  bool validator() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {}
  }

  void login() async {
    if (validator()) {
      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        print('logado como: ${user.credential.providerId}');
      } catch (e) {
        print('erro: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Faça seu login',
            style: TextStyle(color: Colors.green, fontSize: 30),
          ),
          backgroundColor: Colors.black,
        ),
        body: Container(
            padding: EdgeInsets.only(top: 70, left: 40, right: 40),
            color: Colors.black,
            child: Form(
                key: formKey,
                child: ListView(
                  children: <Widget>[
                    Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('images/greenwall.jpg'),
                                fit: BoxFit.cover))),
                    SizedBox(height: 60),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 3.0)),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.green),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 3.0)),
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: (value) => value.isEmpty
                            ? 'O campo email não pode ficar vazio'
                            : null),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green, width: 3.0)),
                            labelText: 'Senha',
                            labelStyle: TextStyle(color: Colors.green),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green, width: 3.0))),
                        style: TextStyle(color: Colors.white),
                        validator: (value) => value.isEmpty
                            ? 'O campo senha não pode ficar vazio'
                            : null),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0.2, 1],
                                colors: [Colors.green[400], Colors.green[300]]),
                            borderRadius: BorderRadius.circular(15)),
                        child: SizedBox.expand(
                            child: FlatButton(
                                onPressed: () {
                                  validator();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'LOGIN',
                                      style: TextStyle(fontSize: 21),
                                    )
                                  ],
                                )))),
                  ],
                ))));
  }
}
