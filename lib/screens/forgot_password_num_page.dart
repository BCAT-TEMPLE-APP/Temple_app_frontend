import 'package:flutter/material.dart';
import 'package:flutter_intern_template/helper/navigation_helper.dart';
import 'package:flutter_intern_template/screens/otp_paswd_page.dart';
import 'package:flutter_intern_template/widgets/countryphone.dart';
import 'package:flutter_intern_template/widgets/custom_appbar.dart';
import 'package:flutter_intern_template/widgets/custom_text_widget.dart';
import 'package:flutter_intern_template/widgets/custom_textfield.dart';

class ForgotPasswordNumPage extends StatefulWidget {
  const ForgotPasswordNumPage({super.key});

  @override
  State<ForgotPasswordNumPage> createState() => _ForgotPasswordNumPageState();
}

class _ForgotPasswordNumPageState extends State<ForgotPasswordNumPage> {
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                CustomTextWidget(
                    title: "Forgot Password",
                    subtitle: "Enter Your Mobile Number to reset the password"),
                const SizedBox(height: 30),

                // Phone Number Input Field
                CountryPhoneInput(phoneController: phoneController),

                const SizedBox(height: 30),
                // Submit Button
                Center(
                    child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      navigateToPage(context,
                          OtpPaswdPage(phoneNumber: phoneController.text));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
