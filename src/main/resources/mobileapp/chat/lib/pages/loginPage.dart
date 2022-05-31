import 'dart:convert';
import 'dart:html';

import 'package:chat/pages/homePage.dart';
import 'package:chat/pages/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _wrongPassOrLoginMessage = '';
  var rememberValue = false;

  Future<void> loginUser(String login, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/v1/auth/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'login': login,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final storage = LocalStorage("chat");
      final encodedResp = jsonDecode(response.body);
      await storage.setItem('jwt', encodedResp['token']);
      await storage.setItem('login', encodedResp['login']);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      setState(() {
        _wrongPassOrLoginMessage = '';
      });
    } else {
      setState(() {
        _wrongPassOrLoginMessage = 'Incorrect login or password!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sign in',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              _wrongPassOrLoginMessage,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _loginController,
                    validator: (value) =>
                        value != null ? null : "Please enter a valid login",
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter your login',
                      prefixIcon: const Icon(Icons.login),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  // CheckboxListTile(
                  //   title: const Text("Remember me"),
                  //   contentPadding: EdgeInsets.zero,
                  //   value: rememberValue,
                  //   activeColor: Theme.of(context).colorScheme.primary,
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       rememberValue = newValue!;
                  //     });
                  //   },
                  //   controlAffinity: ListTileControlAffinity.leading,
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginUser(
                            _loginController.text, _passwordController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not registered yet?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterPage(title: 'Register UI'),
                            ),
                          );
                        },
                        child: const Text('Create an account'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
