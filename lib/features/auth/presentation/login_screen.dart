import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Method to validate email format
  bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailOrPhoneController,
              decoration: InputDecoration(labelText: 'Email or Phone'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final emailOrPhone = emailOrPhoneController.text;
                final password = passwordController.text;

                // Validate inputs
                if (emailOrPhone.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Email or Phone cannot be empty')),
                  );
                  return;
                }

                if (password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password cannot be empty')),
                  );
                  return;
                }

                if (!isValidEmail(emailOrPhone)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Please enter a valid email address')),
                  );
                  return;
                }

                // Proceed with login
                final authCubit = context.read<AuthCubit>();
                authCubit.login(emailOrPhone, password).then((_) {
                  if (authCubit.state.accessToken.isNotEmpty) {
                    Navigator.pushNamed(context, '/home');
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Login failed')));
                  }
                });
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
