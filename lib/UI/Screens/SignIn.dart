import 'package:deaf/UI/Screens/Welocomescreen.dart';
import 'package:deaf/UI/Widgets/Textfields.dart';
import 'package:deaf/UI/Widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscuretext = true;
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithSupabase() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields."),
        ),
      );
      return;
    }

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const Welocomescreen();
        }));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error?.message ?? 'Unknown error occurred'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
        ),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 90, bottom: 70),
            child: Center(
              child: RichText(
                text: const TextSpan(
                  text: 'Sign In to listen ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(
                      text: 'db',
                      style: TextStyle(
                        color: Color(0xFF0054B5),
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Email",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Textfield(
                  controller: _emailController,
                  obscureText: false,
                  hint: "Example@Gmail.com",
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Textfield(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  obscureText: obscuretext,
                  hint: "Passowrd",
                  obscuringchar: "*",
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          obscuretext = !obscuretext;
                        });
                      },
                      icon: obscuretext
                          ? const Icon(
                              Icons.visibility_off,
                            )
                          : const Icon(
                              Icons.visibility,
                            )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          button(
            title: "Sign In",
            onpressed: () {
              print("$_emailController");
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
                _signInWithSupabase();
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Center(child: Image.asset("assets/images/Frame 56.png"))
        ],
      ),
    );
  }
}

extension on AuthResponse {
  get error => null;
}
