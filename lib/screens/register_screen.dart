import 'package:flutter/material.dart';
import 'package:flutter_intern_template/widgets/custom_button.dart';
import 'package:flutter_intern_template/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _termsAccepted = false;

  // Controllers
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'User Register',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48), // Balance the appbar
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Profile Picture
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Add image picker functionality here
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Add Profile Picture',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Form Fields
                  CustomTextField(
                      labelText: 'Full Name', controller: _nameController),
                  const SizedBox(height: 16),
                  CustomTextField(
                      labelText: 'Email Address', controller: _emailController),
                  const SizedBox(height: 16),
                  CustomTextField(
                    labelText: 'Date of Birth',
                    controller: _dateController,
                    isDateField: true,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                      labelText: 'Password',
                      controller: _passwordController,
                      obscure: true),
                  const SizedBox(height: 16),
                  CustomTextField(
                    labelText: 'Password',
                    controller: _confirmPasswordController,
                    obscure: true,
                  ),

                  const SizedBox(height: 24),

                  // Terms and Conditions
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _termsAccepted,
                          onChanged: (value) {
                            setState(() {
                              _termsAccepted = value ?? false;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                            children: [
                              const TextSpan(
                                  text:
                                      'By creating an account, you agree to our '),
                              TextSpan(
                                text: 'Term and Conditions',
                                style: TextStyle(
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.w500),
                                // Add GestureDetector for terms and conditions
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Continue Button
                  CustomButton(
                    labelText: "Continue",
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _termsAccepted) {
                        // Handle registration
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  // Login Link
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        children: [
                          const TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                                color: Colors.blue[400],
                                fontWeight: FontWeight.w500),
                            // Add GestureDetector for login
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
