import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'),),
      body: Container(
//        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(child:Text('Signin to store your data in the cloud',style: TextStyle(fontSize: 30.0),textAlign: TextAlign.center,), margin: EdgeInsets.all(10.0),),
              SizedBox(height: 15.0,),
              FacebookSignInButton(onPressed: (){

              },),
              SizedBox(height: 15.0,),
              GoogleSignInButton(onPressed: (){

              },),
              SizedBox(height: 15.0,),
              TwitterSignInButton(onPressed: (){

              },)
            ],
          ),
//        )
      ),
    );
  }
}
