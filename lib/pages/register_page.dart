import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  final emailController = TextEditingController();
  final paswordController = TextEditingController();
  final confirmpaswordController = TextEditingController();

  void sigUp() async {
    if (paswordController.text != confirmpaswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password don ot match"),
        ),
      );
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);
    try {
        await authService.signUpWithEmailandPassword(
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
                "Crea una cuenta",
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
                height: 10,
              ),
              MyTextField(
                controller: confirmpaswordController,
                obscureText: false,
                hintText: ' confirmPassword',
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                text: "Sing Up",
                onTap: sigUp,
              
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Alredy a memeber?'),
                  SizedBox(
                    height: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      '  Login',
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
