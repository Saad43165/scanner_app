import 'package:flutter/material.dart';
import '../../consts/themes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _userType = 'Normal User';
  final List<String> _userTypes = ['Normal User', 'Doctor'];
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final updatedData = {
      'fullName': _fullNameController.text.trim(),
      'email': _emailController.text.trim(),
      'phoneNumber': 'PK +92 ${_phoneController.text.trim()}',
      'userType': _userType,
    };

    Navigator.pushReplacementNamed(
      context,
      '/dashboard',
      arguments: updatedData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.purple[100],
                    child: Icon(Icons.qr_code_scanner,
                        size: 50, color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 40),

                // Full Name
                _buildLabel('Full Name'),
                TextFormField(
                  controller: _fullNameController,
                  decoration: _buildInputDecoration('Enter full name'),
                ),
                const SizedBox(height: 20),

                // Email
                _buildLabel('Email Address'),
                TextFormField(
                  controller: _emailController,
                  decoration: _buildInputDecoration('Enter email address'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // Phone Number
                _buildLabel('Phone Number'),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'PK +92',
                          enabled: false,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: _buildInputDecoration('Enter phone number'),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Password
                _buildLabel('Password'),
                TextFormField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter password',
                    hintStyle: const TextStyle(color: AppColors.navy, fontSize: 14),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // User Type
                _buildLabel('Are you?'),
                _buildUserTypeDropdown(),
                const SizedBox(height: 40),

                // Continue Button
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: AppColors.navy, fontSize: 14),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildUserTypeDropdown() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: _userType,
        items: _userTypes.map((String type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text(type),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _userType = newValue;
            });
          }
        },
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.only(bottom: 8),
        ),
        style: const TextStyle(color: AppColors.navy, fontSize: 14),
        icon: const Icon(Icons.arrow_drop_down, color: AppColors.navy),
        dropdownColor: Colors.white,
      ),
    );
  }
}
