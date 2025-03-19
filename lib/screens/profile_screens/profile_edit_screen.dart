import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/countryphone.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/custom_button.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/custom_dropdown_widget.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: "Madhuresh Chaudhary");
  final TextEditingController _emailController =
      TextEditingController(text: "madhuresh@gmail.com");
  final TextEditingController _phoneController =
      TextEditingController(text: "999 999 9990");
  final TextEditingController _addressController =
      TextEditingController(text: "907 Valley Drive, Allentown");
  final TextEditingController _zipController =
      TextEditingController(text: "18109");
  final TextEditingController _passwordController =
      TextEditingController(text: "••••••");

  String _selectedCountry = "United States";
  String _selectedState = "Pennsylvania";
  String _selectedCity = "";
  String _countryCode = "+91";
  bool _isPhoneVerified = true;
  bool _isLoadingState = false;

  @override
  void initState() {
    super.initState();

    // Add listener to ZIP code controller
    _zipController.addListener(_updateStateFromZip);
  }

  void _updateStateFromZip() async {
    final zipCode = _zipController.text.trim();

    // Don't attempt lookup if zip code is too short
    if (zipCode.length < 3) return;

    // Only proceed with lookup for supported countries
    if (_selectedCountry == "United States of America" && zipCode.length == 5) {
      _lookupUSZipCode(zipCode);
    } else if (_selectedCountry == "Canada" && zipCode.length >= 3) {
      _lookupCanadianPostalCode(zipCode);
    } else if (_selectedCountry == "India" && zipCode.length == 6) {
      _lookupIndianPinCode(zipCode);
    }
    // Add more country-specific handlers as needed
  }

  void _lookupUSZipCode(String zipCode) async {
    setState(() => _isLoadingState = true);

    try {
      // This is a placeholder for a real API call
      final response =
          await http.get(Uri.parse('https://api.zippopotam.us/us/$zipCode'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final state = data['places'][0]['state'];
        setState(() {
          _selectedState = state;
          _isLoadingState = false;
        });
      } else {
        setState(() => _isLoadingState = false);
      }
    } catch (e) {
      debugPrint('Error looking up US ZIP code: $e');
      setState(() => _isLoadingState = false);
    }
  }

  void _lookupCanadianPostalCode(String postalCode) async {
    setState(() => _isLoadingState = true);

    try {
      // This is a placeholder for a real API call
      final response = await http.get(Uri.parse(
          'https://api.zippopotam.us/ca/${postalCode.substring(0, 3)}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final province = data['places'][0]['state'];
        setState(() {
          _selectedState = province;
          _isLoadingState = false;
        });
      } else {
        setState(() => _isLoadingState = false);
      }
    } catch (e) {
      debugPrint('Error looking up Canadian postal code: $e');
      setState(() => _isLoadingState = false);
    }
  }

  void _lookupIndianPinCode(String pinCode) async {
    setState(() => _isLoadingState = true);

    try {
      // This is a placeholder for a real API call
      final response = await http
          .get(Uri.parse('https://api.postalpincode.in/pincode/$pinCode'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data[0]['Status'] == 'Success') {
          final state = data[0]['PostOffice'][0]['State'];
          setState(() {
            _selectedState = state;
            _isLoadingState = false;
          });
        } else {
          setState(() => _isLoadingState = false);
        }
      } else {
        setState(() => _isLoadingState = false);
      }
    } catch (e) {
      debugPrint('Error looking up Indian PIN code: $e');
      setState(() => _isLoadingState = false);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine ZIP/Postal code label based on country
    String zipLabel = 'ZIP Code';
    if (_selectedCountry == 'Canada') {
      zipLabel = 'Postal Code';
    } else if (_selectedCountry == 'India') {
      zipLabel = 'PIN Code';
    } else if (_selectedCountry == 'United Kingdom') {
      zipLabel = 'Postcode';
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
      ),
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
                        border: Border.all(
                            color: theme.colorScheme.primary, width: 3),
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
                              color: theme.colorScheme.outline,
                              child: Icon(Icons.person,
                                  size: 50, color: theme.colorScheme.outline),
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
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: theme.colorScheme.onSurface,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Form Fields
              CustomTextField(
                  labelText: 'Full Name', controller: _nameController),

              const SizedBox(height: 16),

              // Email Address Field
              CustomTextField(
                  labelText: 'Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress),

              const SizedBox(height: 16),

              // Phone Number Field
              CountryPhoneInput(phoneController: _phoneController),

              const SizedBox(height: 16),

              // Country, State, City Selection
              CSCPickerPlus(
                countryStateLanguage: CountryStateLanguage.englishOrNative,
                onCountryChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    _selectedState = value ?? '';
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    _selectedCity = value ?? '';
                  });
                },
                countryDropdownLabel: 'Country',
                stateDropdownLabel: 'State',
                cityDropdownLabel: 'City',
                dropdownDecoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    border: Border.all(
                        color: theme.colorScheme.outline.withAlpha(0x80)),
                    borderRadius: BorderRadius.circular(16)),
                disabledDropdownDecoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    border: Border.all(
                        color: theme.colorScheme.outline.withAlpha(0x80)),
                    borderRadius: BorderRadius.circular(16)),
                flagState: CountryFlag.ENABLE,
                searchBarRadius: 16.0,
                dropdownDialogRadius: 16.0,
                defaultCountry: CscCountry.India,
              ),

              const SizedBox(height: 16),

              // Address Field
              CustomTextField(
                  labelText: 'Current Address', controller: _addressController),

              const SizedBox(height: 16),

              // ZIP Code Field
              CustomTextField(
                labelText: zipLabel,
                controller: _zipController,
                keyboardType:
                    TextInputType.text, // Allow alphanumeric for postal codes
                inputFormatters: [
                  // For Canadian postal codes: A1A 1A1
                  // For UK postcodes: variable format
                  // For US: 5 digits
                  // For India: 6 digits
                  LengthLimitingTextInputFormatter(10),
                ],
              ),

              const SizedBox(height: 16),

              // Change Password
              CustomTextField(
                  labelText: 'Password',
                  controller: _passwordController,
                  obscure: true),

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
                  children: [
                    Text(
                      'Change Password',
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward,
                        size: 18, color: theme.colorScheme.onSurface),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              CustomButton(labelText: 'Save Changes', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
