import 'package:crud_app/functions/auth_function.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formkey = GlobalKey<FormState>();
  bool isLogin = false;
  String userName = "";
  String emailId = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              !isLogin
                  ? TextFormField(
                      keyboardType: TextInputType.text,
                      key: const ValueKey("userName"),
                      validator: (value) {
                        if (value.toString().length < 3) {
                          return "User Name is too short";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(hintText: 'User Name'),
                      onSaved: (value) {
                        setState(() {
                          userName = value!;
                        });
                      },
                    )
                  : Container(),
              const SizedBox(height: 20),
              TextFormField(
                key: const ValueKey("emailId"),
                validator: (value) {
                  if (!(value.toString().contains('@'))) {
                    return "Invalid Email";
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: 'Email'),
                onSaved: (value) {
                  setState(() {
                    emailId = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                key: const ValueKey('password'),
                decoration: const InputDecoration(hintText: "Password"),
                validator: (value) {
                  if (value.toString().length < 6) {
                    return "Password is so week";
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    isLogin
                        ? signIn(emailId, password)
                        : signUp(emailId, password);
                  }
                },
                child: isLogin
                    ? const Text(
                        "Login",
                        style: TextStyle(color: Colors.black),
                      )
                    : const Text(
                        "Sign In",
                        style: TextStyle(color: Colors.black),
                      ),
              ),
              const SizedBox(height: 25),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: isLogin
                    ? const Text(
                        "Dont have an account? Click",
                        style: TextStyle(color: Colors.blue),
                      )
                    : const Text(
                        "Already had an account? Click",
                        style: TextStyle(color: Colors.blue),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
