import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../consts/themes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _userType = 'Normal User';
  final List<String> _userTypes = ['Normal User'];
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isEditMode = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkEditMode();
  }

  void _checkEditMode() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      if (args['editMode'] == true) {
        if (mounted) {
          setState(() {
            _isEditMode = true;
            _fullNameController.text = args['fullName']?.toString() ?? '';
            _emailController.text = args['email']?.toString() ?? '';
            _phoneController.text = args['phoneNumber']?.toString().replaceAll('PK +92 ', '') ?? '';
            _userType = args['userType']?.toString() ?? 'Normal User';
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<bool> _showExitConfirmation() async {
    if (!_isEditMode &&
        (_fullNameController.text.isNotEmpty ||
            _emailController.text.isNotEmpty ||
            _phoneController.text.isNotEmpty)) {
      return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Discard changes?'),
          content: const Text('You have unsaved changes. Are you sure you want to leave?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Discard'),
            ),
          ],
        ),
      ) ?? false;
    }
    return true;
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updatedData = {
      'fullName': _fullNameController.text.trim(),
      'email': _emailController.text.trim(),
      'phoneNumber': 'PK +92 ${_phoneController.text.trim()}',
      'userType': _userType,
    };

    if (!_isEditMode) {
      updatedData['password'] = _passwordController.text.trim();
    }

    if (_isEditMode) {
      Navigator.pop(context, updatedData);
    } else {
      Navigator.pushReplacementNamed(
        context,
        '/dashboard',
        arguments: updatedData,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _isEditMode ? 'Edit Profile' : 'Register',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () async {
            final shouldPop = await _showExitConfirmation();
            if (shouldPop) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Email
                  _buildLabel('Email Address'),
                  TextFormField(
                    controller: _emailController,
                    decoration: _buildInputDecoration('Enter email address'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
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
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: _buildInputDecoration('Enter phone number'),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (value.length < 10) {
                              return 'Phone number must be 10 digits';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Password (only show in registration mode)
                  if (!_isEditMode) ...[
                    _buildLabel('Password'),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
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
                  ],

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
                      child: Text(
                        _isEditMode ? 'Save Changes' : 'Continue',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
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
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
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
            child: Text(type, style: const TextStyle(color: Colors.black)),
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
        style: const TextStyle(color: Colors.black, fontSize: 14),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        dropdownColor: Colors.white,
      ),
    );
  }
}