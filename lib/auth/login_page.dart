import 'package:flutter/material.dart';
import 'signin.dart';
import 'package:projek_gaji/first_screen.dart';
import 'package:projek_gaji/email_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

@override
class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = _isHidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(size: 150),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Email',
                      filled: true,
                      focusColor: Colors.blue,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: _isHidePassword,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(30)),
                      contentPadding: EdgeInsets.all(15),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _togglePasswordVisibility();
                        },
                        child: Icon(
                          _isHidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: _isHidePassword ? Colors.white : Colors.white,
                        ),
                      ),
                      filled: true,
                      focusColor: Colors.blue,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Password';
                      } else if (value.length < 6) {
                        return 'Password must be atleast 6 characters!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            child: Text(
                              'SignUp',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () async {
                              signUp(emailController.text,
                                      passwordController.text)
                                  .then(
                                (result) {
                                  if (result != null) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return EmailScreen();
                                        },
                                      ),
                                    );
                                  }
                                },
                              );
                            })),
                    Expanded(
                        child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            child: Text(
                              'SignIn',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () async {
                              signIn(emailController.text,
                                      passwordController.text)
                                  .then(
                                (result) {
                                  if (result != null) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return EmailScreen();
                                        },
                                      ),
                                    );
                                  }
                                },
                              );
                            }))
                  ]),
                ),
                Text('OR'),
                SizedBox(height: 30),
                _signInButton(),
              ]),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen();
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              //image: AssetImage("assets/google_logo.png"),
              'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png',
              height: 35.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}