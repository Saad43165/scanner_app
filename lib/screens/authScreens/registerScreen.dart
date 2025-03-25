import 'package:flutter/material.dart';
import '../../consts/custombackbutton.dart';
import '../../consts/themes.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _userType = 'Normal User';
  final List<String> _userTypes = ['Normal User', 'Doctor'];

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Reusable Back Button (Passing Data Back)
                CustomBackButton(
                  iconColor: Colors.black,
                  backgroundColor: Colors.white,
                  iconSize: 28.0,
                  dataToPassBack: {
                    'userType': _userType,
                    'message': "Registration Cancelled"
                  },
                ),

                const SizedBox(height: 20),

                // App Logo
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.purple[100],
                    child: const Icon(Icons.qr_code_scanner,
                        size: 50, color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 40),

                // Full Name
                _buildLabel('Full Name'),
                _buildTextField(_fullNameController, 'Nabeel Tahir'),

                const SizedBox(height: 20),

                // Email Address
                _buildLabel('Email Address'),
                _buildTextField(_emailController, 'nabeeltahir@gmail.com'),

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
                          hintStyle: TextStyle(color: AppColors.navy, fontSize: 14),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        enabled: false,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(_phoneController, 'Enter Phone Number'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Password (We are not using it right now for Profile)
                _buildLabel('Password'),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter New Password',
                    hintStyle: TextStyle(color: AppColors.navy, fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 20),

                // User Type Dropdown
                _buildLabel('Are you?'),
                _buildUserTypeDropdown(),

                const SizedBox(height: 40),

                // Continue Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/dashboard', // ✅ Navigating to Dashboard
                        arguments: {
                          'fullName': _fullNameController.text,
                          'email': _emailController.text,
                          'phoneNumber': _phoneController.text,
                          'userType': _userType,
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 60.0),
                      child: Text(
                        'Continue',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
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

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.navy, fontSize: 14),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
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
          setState(() {
            _userType = newValue!;
          });
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
