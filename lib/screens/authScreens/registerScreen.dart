import 'package:flutter/material.dart';
import '../../consts/custombackbutton.dart';
import '../../consts/themes.dart';

class RegisterScreen extends StatefulWidget {
  final bool isEditMode;
  final String? initialFullName;
  final String? initialEmail;
  final String? initialPhone;
  final String? initialUserType;

  const RegisterScreen({
    Key? key,
    this.isEditMode = false,
    this.initialFullName,
    this.initialEmail,
    this.initialPhone,
    this.initialUserType,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String _userType;
  final List<String> _userTypes = ['Normal User', 'Doctor'];
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Initialize with passed data or defaults
    _userType = widget.initialUserType ?? 'Normal User';
    _fullNameController.text = widget.initialFullName ?? '';
    _emailController.text = widget.initialEmail ?? '';
    _phoneController.text = widget.initialPhone?.replaceAll('PK +92 ', '') ?? '';

    // Also check route arguments in case data comes that way
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _fullNameController.text = args['fullName'] ?? _fullNameController.text;
      _emailController.text = args['email'] ?? _emailController.text;
      _phoneController.text = args['phoneNumber']?.replaceAll('PK +92 ', '') ?? _phoneController.text;
      _userType = args['userType'] ?? _userType;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    if (!value.contains('@')) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    if (value.length < 10) {
      return 'Phone number too short';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.isEditMode ? 'Edit Profile' : 'Register'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  if (!widget.isEditMode) ...[
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
                  ],
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
                    validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter full name' : null,
                  ),
                  const SizedBox(height: 20),

                  // Email
                  _buildLabel('Email Address'),
                  TextFormField(
                    controller: _emailController,
                    decoration: _buildInputDecoration('Enter email address'),
                    validator: _validateEmail,
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
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: _buildInputDecoration('Enter phone number'),
                          validator: _validatePhone,
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Password - Only show for registration, not edit
                  if (!widget.isEditMode) ...[
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
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: widget.isEditMode
                          ? null
                          : (value) => value?.isEmpty ?? true
                          ? 'Please enter password'
                          : null,
                    ),
                    const SizedBox(height: 20),
                  ],

                  // User Type
                  _buildLabel('Are you?'),
                  _buildUserTypeDropdown(),
                  const SizedBox(height: 40),

                  // Continue/Save Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.pushReplacementNamed(
                            context,
                            '/dashboard',
                            arguments: {
                              'fullName': _fullNameController.text.trim(),
                              'email': _emailController.text.trim(),
                              'phoneNumber': 'PK +92 ${_phoneController.text.trim()}',
                              'userType': _userType,
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(200, 50),
                      ),
                      child: Text(
                        widget.isEditMode ? 'Save Changes' : 'Continue',
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