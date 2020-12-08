import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/Register_Page.dart';
import 'package:firebaseproject/RestPassword_Page.dart';
import 'package:firebaseproject/Home_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}
class _SignInState extends State<SignIn> {

  bool vissible=true;

  TextEditingController _email=new TextEditingController();
  TextEditingController _password=new TextEditingController();
  GlobalKey<FormState>_globalKey=GlobalKey<FormState>();
  GlobalKey<ScaffoldState>sangbar=GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: sangbar,
      resizeToAvoidBottomPadding: false,


      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                //alignment: Alignment.center,
                height: 200,
                width: 200,
                child: Image.asset("images/comilla university logo.jpg"),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                validator: (val){
                  if(val.isEmpty){
                    return 'Please your email';
                  }return null;
                },
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  hintText: "Enter Email",
                  filled: true,
                  fillColor: Colors.grey,
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white)),
                  enabledBorder:OutlineInputBorder(borderSide: BorderSide(color:Colors.white)),
                ),
              ),
              SizedBox(height: 20,),

              TextFormField (
                controller: _password,
                keyboardType: TextInputType.visiblePassword,
                validator: (val){
                  if(val.isEmpty){
                    return "Please your password";
                  }return null;
                },
                obscureText: vissible,
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.red),
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        vissible=!vissible;
                      });
                    },
                    icon: vissible?Icon(Icons.visibility,color: Colors.blueAccent,):Icon(Icons.visibility_off,color: Colors.red,),
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  hintText: "Enter Password",
                  filled: true,
                  fillColor: Colors.grey,
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white)),
                  enabledBorder:OutlineInputBorder(borderSide: BorderSide(color:Colors.white)),
                ),
              ),
              SizedBox(height: 15,),
              Row(mainAxisAlignment:MainAxisAlignment.end,children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                  },
                  child: Text("Forget Password",
                    style: TextStyle(color: Colors.purple,decoration: TextDecoration.underline),),
                )],),
              SizedBox(height: 40,),

              Container(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  child: Text("Sign In",style: TextStyle(fontSize: 17,color: Colors.white),),
                  elevation: 0,
                  color: Colors.purple,
                  onPressed: (){
                    //to do
                    validation();

                  },),
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New account create?",style: TextStyle(color: Colors.purple),),
                  SizedBox(width: 5),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>Register_Page()));
                      },
                      child: Text("Sign Up",style: TextStyle(color: Colors.purple, decoration: TextDecoration.underline),)),
                ],),
              SizedBox(height: 30,),
            ],
          ),
        ),
      )
    );}


  //validation
  validation()async {
    if (_globalKey.currentState.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text, password:_password.text,);
        User user=userCredential.user;
        assert(user.uid!=null);
        if(!user.emailVerified){
          await user.sendEmailVerification();}
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_Page(user: user,)));
      } on FirebaseAuthException catch (e) {
        sangbar.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.deepOrange,
            content: Text(e.message)));
      }

    }
  }
}
