import 'package:ai_customer_service_stock_management_system/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _isLoading = false;

  // ✅ وحطّ دي بدلها
  void _login() async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك ادخل الإيميل وكلمة المرور')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );

      if (response.user != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Main()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ الإيميل أو كلمة المرور غلط!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 50.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.blue[900],
                  radius: 45.0,
                  child: Icon(Icons.person, color: Colors.white, size: 70.0),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Alasala",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                "ADMIN PORTAL",
                style: TextStyle(fontSize: 15, color: Colors.amber[700]),
              ),
              SizedBox(height: 50.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('البريد الإلكتروني'),
              ),
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  hintText: 'admin@alasala.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('كلمة المرور'),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '........',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("TERMS OF SERVICE", style: TextStyle(fontSize: 12)),
                  SizedBox(width: 16),
                  Text("PRIVACY POLICY", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
