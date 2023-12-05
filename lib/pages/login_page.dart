import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {


    final void Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


  final emailController = TextEditingController();
  final paswordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
    void sigIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailandPassword(
        emailController.text,
        paswordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 1,
              ),
              const Icon(
                Icons.comment,
                size: 80,
              ),
              const SizedBox(
                height: 1,
              ),
              const Text(
                "Hola mundo",
              ),
              MyTextField(
                controller: emailController,
                obscureText: false,
                hintText: 'Email',
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: paswordController,
                obscureText: false,
                hintText: 'Password',
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                text: "Sing In",
                onTap: sigIn,
              ),
              const SizedBox(
                height: 20,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a memeber?'),
                  SizedBox(
                    height: 4,
                  ),
                  GestureDetector(
                    onTap:widget.onTap,
                    child: Text(
                      '  Register',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
