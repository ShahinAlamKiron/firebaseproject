import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/LogIn_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Home_Page extends StatefulWidget {

  final user;
  const Home_Page({Key key, this.user});

  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40,right: 10,left: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 40,bottom: 30),
                child: CircleAvatar(
                  radius: 55,
                  child: Text(widget.user.displayName[0].toString(),style: TextStyle(fontSize: 30),),),
              ),
              SizedBox(height: 6,),

              Card(
                elevation: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    children: [

                      //User Email
                      Row(mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Flexible(child: Text(widget.user.displayName.toString(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
                        ],),
                      SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 6,),

              Card(
                elevation: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    children: [

                      //User Email
                      Row(mainAxisAlignment:MainAxisAlignment.start,
                        children: [
                          Text("E-mail Address:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                          SizedBox(width: 10,),
                          Flexible(child: Text(widget.user.email.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),)),
                        ],),
                      SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),

              SizedBox(height: 6,),

              //account create date
              Card(
                elevation: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    children: [
                      Row(mainAxisAlignment:MainAxisAlignment.start,
                        children: [
                          Text("Create Account:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                          SizedBox(width: 10,),
                          Text(widget.user.metadata.creationTime.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
                        ],),

                    ],
                  ),
                ),
              ),
              Card(
                elevation: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    children: [
                      Row(mainAxisAlignment:MainAxisAlignment.start,
                        children: [
                          Text("Last SignIn Time:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                          SizedBox(width: 10,),
                          Text(widget.user.metadata.lastSignInTime.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
                        ],),

                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),

              InkWell(
                onTap: (){
                  //To Do
                  try{
                    FirebaseAuth.instance.signOut().whenComplete((){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
                    });
                  }catch(e){
                    Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.deepOrange,
                        content: Text(e.message)));
                  }
                },
                child: Card(
                  elevation: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                    child: Row(mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Text("Log Out",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                        SizedBox(width: 10,),
                      ],),
                  ),
                ),
              ),
              SizedBox(height: 10,),


            ],
          ),
        ),
      ),
    );
  }
}
