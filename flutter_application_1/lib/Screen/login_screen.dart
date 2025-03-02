import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController unameController = TextEditingController();

  TextEditingController pwdController = TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            // Text('username'),
            TextField(
              decoration: InputDecoration(
                hintText: 'Username',
                labelText: 'Username',
              ),
              controller: unameController,
            ),
            //Text('password'),
            TextField(
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    // to chnage the visibility of password
                    isObscure = !isObscure;
                    print(isObscure);
                    setState(() {});
                  },
                  icon:
                      Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                ),
              ),
              controller: pwdController,
              obscureText: isObscure,
            ),
            ElevatedButton(
                onPressed: () async {
                  print(
                      'Button pressed ${unameController.text} ${pwdController.text} ');
                  if (unameController.text == pwdController.text) {
                    print('valide user');
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('action', unameController.text);

                    //neviget to dashboard
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()),
                    );
                  } else {
                    print('invalide cradential');
                  }
                },
                child: Text('Login'))
          ],
        ),
      ),
    );
  }
}
