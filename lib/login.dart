import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/register.dart';
import 'package:firebaseproject/reset.dart';
import 'package:firebaseproject/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebaseproject/textdesign.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email, password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Login page'),
        centerTitle: true,
      ),
      key: _scaffoldKey,
      body: Builder(builder: (BuildContext context) {
        return withEmailPassword();
      }),
    );
  }

  Widget withEmailPassword() {
    return Form(
      key: _formKey,
      child: Wrap(
        children: [
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                //alignment: Alignment.center,
                height: 200,
                width: 250,
                child: Image.asset("images/comilla university logo.jpg"),
              ),
              SizedBox(
                height: 20,
              ),


              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.text,
                  decoration: buildInputDecoration(Icons.email, "Email"),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please a Enter';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return 'Please a valid Email';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    email = value;
                  },
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  decoration: buildInputDecoration(Icons.lock, "Password"),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please  Enter Password';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    password = value;
                  },
                ),
              ),


              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResetScreen()));
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                //color: Colors.purple,
                padding: const EdgeInsets.only(top: 8.0),
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _signInWithEmailAndPassword();
                    }
                  },
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Don\'t have an account?Create account',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {

    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return MainPage(
          user: user,
        );
      }));
    } catch (e) {

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Email & Password"),
      ));
    }

  }

  void signOut() async {
    await _auth.signOut();
  }
}
