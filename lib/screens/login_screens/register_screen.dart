import 'package:flutter/material.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/custom_button.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/custom_dropdown_widget.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _termsAccepted = false;
  String _selectedRegisterType = 'User Register';
  final List<String> _registerTypes = [
    'User Register',
    'Temple Register',
    'Creator Register'
  ];

  // State dropdown value
  String? _selectedState;
  final List<String> _states = [
    'MP',
    'MH',
    'UP',
    'RJ',
    'GJ',
  ];

  // Controllers
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _currentAddressController =
      TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  // Method to handle location icon press
  void _handleLocationPress() {
    // TODO: Implement location functionality
    print('Location icon pressed - implement location services here');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar with Dropdown
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back,
                              color: theme.colorScheme.onSurface),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: Center(
                            child: DropdownButton<String>(
                              value: _selectedRegisterType,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              elevation: 16,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.onSurface,
                              ),
                              underline: Container(
                                height: 0,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedRegisterType = value!;
                                });
                              },
                              items: _registerTypes
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
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
                              color: theme.colorScheme.outline,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: theme.colorScheme.surface,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add Profile Picture',
                          style: TextStyle(
                            color: theme.colorScheme.outline,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Upload Photo Button (only for Temple/Creator)
                  if (_selectedRegisterType != 'User Register')
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Add photo upload functionality
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Upload 5 Photo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onSurface,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Form Fields
                  // Name field (different label based on type)
                  CustomTextField(
                    labelText: _selectedRegisterType == 'Temple Register'
                        ? 'Temple Name'
                        : _selectedRegisterType == 'Creator Register'
                            ? 'Creator Name'
                            : 'Full Name',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    labelText: 'Email Address',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),

                  // Current Address (only for Temple/Creator)
                  if (_selectedRegisterType != 'User Register')
                    Column(
                      children: [
                        CustomTextField(
                          labelText: 'Current Address',
                          controller: _currentAddressController,
                          suffixIcon: Icon(Icons.location_on,
                              color: theme.colorScheme.primary),
                          onSuffixIconPressed: _handleLocationPress,
                        ),
                        const SizedBox(height: 16),

                        // Zip Code and State with updated design
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                labelText: 'Zip Code',
                                controller: _zipCodeController,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomDropdown(
                                title: 'State',
                                items: _states,
                                value: _selectedState,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedState = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),

                  // Date field (different label based on type)
                  CustomTextField(
                    labelText: _selectedRegisterType == 'Temple Register'
                        ? 'Establishment Date'
                        : 'Date of Birth',
                    controller: _dateController,
                    isDateField: true,
                  ),
                  const SizedBox(height: 16),

                  // User ID field (for Temple/Creator)
                  if (_selectedRegisterType != 'User Register')
                    Column(
                      children: [
                        CustomTextField(
                          labelText: 'User ID',
                          controller: _userIdController,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),

                  // Website field (only for Temple)
                  if (_selectedRegisterType == 'Temple Register')
                    Column(
                      children: [
                        CustomTextField(
                          labelText: 'Website (Optional)',
                          controller: _websiteController,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),

                  CustomTextField(
                    labelText: 'Password',
                    controller: _passwordController,
                    obscure: true,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    labelText: 'Confirm Password',
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
                          side: BorderSide(color: theme.colorScheme.outline),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: theme.colorScheme.outline, fontSize: 14),
                            children: [
                              const TextSpan(
                                  text:
                                      'By creating an account, you agree to our '),
                              TextSpan(
                                text: 'Term and Conditions',
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
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
                        style: TextStyle(
                            color: theme.colorScheme.onSurface, fontSize: 14),
                        children: [
                          const TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
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
