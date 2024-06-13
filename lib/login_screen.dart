import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/api_calls_login.dart';
import 'package:flutter_app/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              child: Center(
                child: TextField(
                  controller: usernameController,
                  decoration:
                      const InputDecoration.collapsed(hintText: 'username'),
                ),
              ),
            ),
            SizedBox(
              width: 400,
              child: Center(
                child: TextField(
                  controller: passwordController,
                  decoration:
                      const InputDecoration.collapsed(hintText: 'password'),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            (isLoading)
                ? CircularProgressIndicator()
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      bool verified = await login(
                          usernameController.text, passwordController.text);

                      print(verified);

                      if (verified) {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }));
                      }

                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      color: Colors.redAccent,
                      child: const Center(child: Text('Log in ')),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
