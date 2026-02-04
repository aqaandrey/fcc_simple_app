import 'main.dart';
import 'header_view.dart';
import 'footer_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _login;
  late final TextEditingController _pass;

  String? _loginError;
  String? _passError;

  bool _isPasswordVisible = false;

  @override
  void initState() {
    _login = TextEditingController();
    _pass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _login.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderView(title: 'Login'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: _login,
              decoration: InputDecoration(
                labelText: 'Login',
                hintText: 'Enter your login here',
                helperText: ' ',
                errorText: _loginError,
              ),
              onTap: () => setState(() => _loginError = null),
            ),
            // const SizedBox(height: 5),
            TextFormField(
              controller: _pass,
              obscureText: !_isPasswordVisible,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your email password',
                helperText: ' ',
                errorText: _passError,
                suffixIcon: GestureDetector(
                  onTapDown: (_) => setState(() => _isPasswordVisible = true),
                  onTapUp: (_) => setState(() => _isPasswordVisible = false),
                  onTapCancel: () => setState(() => _isPasswordVisible = false),
                  child: Icon(Icons.visibility),
                ),
              ),
              onTap: () => setState(() => _passError = null),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                minimumSize: const Size(100, 25),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              ),
              onPressed: () async {
                final login = _login.text.trim().lower;
                final password = _pass.text.trim();
                _loginError = null;
                _passError = null;

                // empty login validation
                if (login.isEmpty) {
                  _loginError = 'Please fill in the login field';
                }

                // empty pass validation
                if (password.isEmpty) {
                  _passError = 'Please fill in the password field';
                } else if (password.length <= 2) {
                  _passError = 'Must contains more then 2 characters';
                }

                // check errors
                if (_loginError != null || _passError != null) {
                  setState(() {}); // refresh UI
                  return;
                }

                final prefs = await SharedPreferences.getInstance();
                final storedPassword = prefs.getString(login);

                // checking if the user exist
                try {
                  if (storedPassword == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User not found')),
                    );
                    return;
                  }
                } catch (e) {
                  print('Error while checking user: $e');
                }

                if (storedPassword != password) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Wrong password')),
                  );
                  return;
                }

                // successful login
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login successful')),
                );

                // save current user's login
                await prefs.setString('currentUser', login);

                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/menu/', (route) => false);
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.inversePrimary,
                    minimumSize: const Size(100, 25),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  child: const Text('Back'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterView(),
    );
  }
}
