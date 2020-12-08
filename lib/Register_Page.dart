import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/LogIn_Page.dart';
import 'package:firebaseproject/Home_Page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebaseproject/textdesign.dart';

class Register_Page extends StatefulWidget {
  @override
  _Register_PageState createState() => _Register_PageState();
}

class _Register_PageState extends State<Register_Page> {
  String email;

  GlobalKey<ScaffoldState>sangbar=GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

  bool _isSuccess;
  String _userEmail;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sangbar,
      appBar: AppBar(
        title: Text('Welcome Register page'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 250,
                      child: Image.asset("images/comilla university logo.jpg"),
                    ),
                    SizedBox(
                      height: 5,
                    ),


                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      child: TextFormField(
                        //obscureText: true,
                        controller: _displayName,
                        keyboardType: TextInputType.text,
                        decoration:
                            buildInputDecoration(Icons.person, "Full Name"),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please  Enter full name';
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(Icons.email, "Email"),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please a Enter Email';
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



                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        decoration:
                            buildInputDecoration(Icons.lock, "Password"),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please a Enter Password';
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      child: TextFormField(
                        controller: confirmpassword,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(
                            Icons.lock, "Confirm Password"),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please re-enter password';
                          }
                          print(_passwordController.text);

                          print(confirmpassword.text);

                          if (_passwordController.text !=
                              confirmpassword.text) {
                            return "Password does not match";
                          }

                          return null;
                        },
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(0.0),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "register",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _registerAccount();
                          }
                        },
                      ),
                    ),

                    //SizedBox(height: .0,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Text(
                              'Already have an account?Click here',
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  void _registerAccount() async {

    if (_formKey.currentState.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password:_passwordController.text,);
        User user=userCredential.user;
        assert(user.uid!=null);
        if(!user.emailVerified){
          await user.sendEmailVerification();}
        user.updateProfile(displayName: _displayName.text);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
      } on FirebaseAuthException catch (e) {
        sangbar.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.deepOrange,
            content: Text(e.message)));
      }

    }

  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('_isSuccess', _isSuccess));
    properties.add(StringProperty('_userEmail', _userEmail));
  }
}
