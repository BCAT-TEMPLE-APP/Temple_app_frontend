import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nameController = TextEditingController(text: "Madhuresh Chaudhary");
  final TextEditingController _emailController = TextEditingController(text: "madhuresh@gmail.com");
  final TextEditingController _phoneController = TextEditingController(text: "999 999 9990");
  final TextEditingController _addressController = TextEditingController(text: "907 Valley Drive, Allentown");
  final TextEditingController _zipController = TextEditingController(text: "18109");
  final TextEditingController _passwordController = TextEditingController(text: "••••••");
  
  String _selectedState = "Pennsylvania";
  String _countryCode = "+91";
  bool _isPhoneVerified = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _zipController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildFormField({
    required String label,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      labelText: 'Label',
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF29B6F6), width: 2),
      ),
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture section
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF29B6F6), width: 3),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          'https://randomuser.me/api/portraits/men/35.jpg',
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.person, size: 50, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF29B6F6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Form Fields
              TextField(
                controller: _nameController,
                decoration: inputDecoration.copyWith(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _emailController,
                decoration: inputDecoration.copyWith(
                  labelText: 'Email Address',
                  hintText: 'Enter your email address',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Phone Number Field
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            setState(() {
                              _countryCode = '+${country.phoneCode}';
                            });
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        child: Row(
                          children: [
                            const Text('🇮🇳', style: TextStyle(fontSize: 24)),
                            const SizedBox(width: 8),
                            Text(_countryCode),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone number',
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    if (_isPhoneVerified)
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.check_circle, color: Colors.green),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _addressController,
                decoration: inputDecoration.copyWith(
                  labelText: 'Current Address',
                  hintText: 'Enter your address',
                ),
              ),
              const SizedBox(height: 16),

              // ZIP Code and State in a row
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: _zipController,
                      decoration: inputDecoration.copyWith(
                        labelText: 'ZIP Code',
                        hintText: 'Enter ZIP code',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 6,
                    child: DropdownButtonFormField<String>(
                      value: _selectedState,
                      decoration: inputDecoration.copyWith(
                        labelText: 'State',
                      ),
                      items: ['Pennsylvania', 'New York', 'California', 'Texas']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() => _selectedState = newValue);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _passwordController,
                decoration: inputDecoration.copyWith(
                  labelText: 'Password',
                  hintText: 'Enter password',
                  
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),

              // Buttons
              OutlinedButton(
                onPressed: () {
                  // Handle change password
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 18, color: Colors.black),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  // Handle save changes
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1DCAFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: const Center(
                  child: Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
