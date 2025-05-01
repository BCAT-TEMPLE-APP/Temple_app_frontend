import 'package:flutter/material.dart';
import 'package:flutter_user_app/core/helper/navigation_helper.dart';
import 'package:flutter_user_app/features/auth/login/presentation/screens/otp_forgot_paswd_page.dart';
import 'package:flutter_user_app/widgets/custom_widgets/countryphone.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_button.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_text_widget.dart';

class ForgotPasswordNumPage extends StatefulWidget {
  const ForgotPasswordNumPage({super.key});

  @override
  State<ForgotPasswordNumPage> createState() => _ForgotPasswordNumPageState();
}

class _ForgotPasswordNumPageState extends State<ForgotPasswordNumPage> {
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
                  title: "Forgot Password",
                  subtitle: "Enter Your Mobile Number to reset the password"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),

                    // Phone Number Input Field
                    CountryPhoneInput(phoneController: phoneController),

                    const SizedBox(height: 30),
                    // Submit Button
                    CustomButton(
                        labelText: 'Reset Password',
                        onPressed: () {
                          navigateToPage(context,
                              OtpPaswdPage(phoneNumber: phoneController.text));
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
