import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_intern_template/helper/navigation_helper.dart';
import 'package:flutter_intern_template/screens/forgot_password_page.dart';
import 'package:flutter_intern_template/widgets/custom_appbar.dart';
import 'package:flutter_intern_template/widgets/custom_text_widget.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpPaswdPage extends StatefulWidget {
  final String phoneNumber;
  const OtpPaswdPage({super.key, required this.phoneNumber});

  @override
  State<OtpPaswdPage> createState() => _OtpPaswdPageState();
}

class _OtpPaswdPageState extends State<OtpPaswdPage> {
  int _counter = 50;
  late Timer _timer;
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _counter = 50;
    _isResendEnabled = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
        });
        _timer.cancel();
      }
    });
  }

  void _resendOtp() {
    // implement the OTP resend logic
    // For now, just restart the timer
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
                    title: "OTP Verification",
                    subtitle: "An Authentication code has been sent to"),
                Text(
                  "${widget.phoneNumber}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 30),

                // OTP Input Field
                OtpTextField(
                  numberOfFields: 5,
                  borderColor: Color(0xFF512DA8),
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    //handle validation or checks here
                  }, // end onSubmit
                ),

                const SizedBox(height: 35),

                // Submit Button
                Center(
                    child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      navigateToPage(context, ForgotPasswordPage());
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
                )),

                const SizedBox(height: 20),

                // Resend OTP
                // Resend OTP with Countdown Timer
                Center(
                  child: TextButton(
                    onPressed: _isResendEnabled ? _resendOtp : null,
                    child: Text(
                      _isResendEnabled
                          ? "Resend"
                          : "Code is send, Resend in $_counter sec",
                      style: TextStyle(
                        fontSize: 16,
                        color: _isResendEnabled ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
