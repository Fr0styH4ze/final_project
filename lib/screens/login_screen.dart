import 'package:final_project/extensions/nav.dart';
import 'package:final_project/extensions/screen_size.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/screens/signup_screen.dart';
import 'package:final_project/services/data_base.dart';
import 'package:final_project/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _authService = DataBase();

  bool _isLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.login(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );

      if (!mounted) return;
      context.pushAndDelete(const HomeScreen());
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            height: context.screenHeight * 0.5,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldWidget(
                  controller: _email,
                  hint: 'Enter Your Email',
                  icon: const Icon(Icons.email),
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  controller: _password,
                  hint: 'Enter Your Password',
                  icon: const Icon(Icons.password),
                  isObscure: true,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Login"),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    context.pushAndDelete(const SignupScreen());
                  },
                  child: const Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
