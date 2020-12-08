import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  TextEditingController _email=new TextEditingController();
  GlobalKey<ScaffoldState>sangbar=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sangbar,
      backgroundColor: Colors.white70,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Text("Forget Passwords",style: TextStyle(fontSize: 20),),),

      body: Padding(
        padding: EdgeInsets.only(top: 20,right: 20,left: 20),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                hintText: "Enter Email",
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white)),
                enabledBorder:OutlineInputBorder(borderSide: BorderSide(color:Colors.white)),
              ),
            ),

            SizedBox(height: 40,),
            Container(
              height: 50,
              width: double.infinity,
              child: RaisedButton(
                child: Text("Send Code",style: TextStyle(fontSize: 17,color: Colors.white),),
                elevation: 0,
                color: Colors.deepPurple[900],
                onPressed: (){
                  //to do
                  forgetPassword();
                },),
            ),
          ],
        ),
      ),
    );
  }

  forgetPassword()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email:_email.text).then((value){
        _email.clear();
        Navigator.pop(context);
      });
    }on FirebaseAuthException catch(e){
      sangbar.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.deepOrange,
          content: Text(e.message)));
      print(e.message);
    }
  }
}
