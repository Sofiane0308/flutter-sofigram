import 'package:flutter/material.dart';
import 'package:sofigram/screens/signup_screen.dart';
import 'package:sofigram/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //Logging in user w/ firebase
      AuthService.logIn(context,_email, _password);
      print('sucess');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Sofigram',
                style: TextStyle(fontFamily: 'Billabong', fontSize: 50)),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (input) => !input.contains('@')
                            ? 'Please entrer a valid email'
                            : null,
                        onSaved: (input) => _email = input,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (input) => input.length < 6
                            ? 'Must be at least 6 characters'
                            : null,
                        onSaved: (input) => _password = input,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 250,
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                          onPressed: _submit,
                          color: Colors.blue,
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 250,
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, SignupScreen.id),
                          color: Colors.blue,
                          child: Text(
                            'Go to Signup',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    )
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
