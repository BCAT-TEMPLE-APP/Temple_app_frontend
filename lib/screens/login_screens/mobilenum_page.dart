import 'package:flutter/material.dart';
import 'package:flutter_user_app/helper/navigation_helper.dart';
import 'package:flutter_user_app/screens/login_screens/otp_page.dart';
import 'package:flutter_user_app/widgets/custom_widgets/countryphone.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_appbar.dart';
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
                  title: "Welcome",
                  subtitle: "Enter Your Mobile Number for\nOTP Verification"),

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
                  child: const Text(
                    "Privacy and agreements",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),
              Center(
                  child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    navigateToPage(
                        context,
                        OtpPage(
                          phoneNumber: phoneController.text,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      )),
    );
  }
}
