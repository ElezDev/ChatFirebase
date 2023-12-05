import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrEgister extends StatefulWidget {
  const LoginOrEgister({super.key});

  @override
  State<LoginOrEgister> createState() => _LoginOrEgisterState();
}

class _LoginOrEgisterState extends State<LoginOrEgister> {

  bool showLoginPage = true;  
  void togglesPages(){
   setState(() {
      showLoginPage = !showLoginPage; 
   });
  }
  @override
  Widget build(BuildContext context) {
   if (showLoginPage) {
    return LoginPage(onTap: togglesPages,);
     
   }else{
    return RegisterPage(onTap: togglesPages,);
   }
  }
}