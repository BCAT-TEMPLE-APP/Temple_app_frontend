import 'package:flutter/material.dart';
import 'package:flutter_user_app/core/helper/navigation_helper.dart';
import 'package:flutter_user_app/features/auth/register/presentation/screens/otp_register_page.dart';
import 'package:flutter_user_app/widgets/custom_widgets/countryphone.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_button.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_text_widget.dart';

class MobileNum extends StatefulWidget {
  const MobileNum({super.key});

  @override
  State<MobileNum> createState() => _MobileNumState();
}

class _MobileNumState extends State<MobileNum> {
  // Phone Number Controller
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomAppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
                title: "Welcome",
                subtitle: "Enter Your Mobile Number for\nOTP Verification"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  // Phone Number Input Field
                  CountryPhoneInput(
                    phoneController: phoneController,
                  ),

                  const SizedBox(height: 30),

                  // Privacy Policy
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Privacy and agreements",
                        style: TextStyle(
                          fontSize: 18,
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),
                  CustomButton(
                      labelText: "Continue",
                      onPressed: () => navigateToPage(
                          context, OtpPage(phoneNumber: phoneController.text))),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
