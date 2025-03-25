import 'package:flutter/material.dart';
import '../../consts/themes.dart';
import '../../consts/custombackbutton.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form Key
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width(context) * 0.1),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  // Back Button (At the Start)
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomBackButton(
                      iconColor: Colors.black,
                      backgroundColor: Colors.white,
                      iconSize: 28.0,
                      dataToPassBack: "Data from LoginScreen",
                    ),
                  ),

                  const SizedBox(height: 30),

                  // App Title
                  Center(
                    child: Text(
                      'MediVision',
                      style: TextStyle(
                        fontFamily: 'AbrilFatface',
                        fontSize: Responsive.textSize(context, 28),
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Email Input
                  _buildLabel('Email Address'),
                  _buildTextField(_emailController, 'Enter your email'),

                  const SizedBox(height: 20),

                  // Password Input
                  _buildLabel('Password'),
                  _buildPasswordField(),

                  const SizedBox(height: 30),

                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/dashboard'); // Move to dashboard even if fields are empty
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: Responsive.textSize(context, 18),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Forgot Password
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/forgetpassword'),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: Responsive.textSize(context, 14),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Create Account
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New User? ',
                          style: TextStyle(
                            fontSize: Responsive.textSize(context, 14),
                            color: AppColors.textDark,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, '/register'),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontSize: Responsive.textSize(context, 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: Responsive.textSize(context, 14),
        color: Colors.blueGrey,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.navy, fontSize: 14),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        hintStyle: TextStyle(color: AppColors.navy, fontSize: 14),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }
}
