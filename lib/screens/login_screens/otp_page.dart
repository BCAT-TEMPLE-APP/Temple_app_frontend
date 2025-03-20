import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_button.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_text_widget.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  const OtpPage({super.key, required this.phoneNumber});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CustomTextWidget(
                    title: "OTP Verification",
                    subtitle: "An Authentication code has been sent to"),
                Text(
                  "${widget.phoneNumber}",
                  style: TextStyle(
                    fontSize: 18,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 30),

                // OTP Input Field
                OtpTextField(
                  numberOfFields: 5,
                  borderColor: theme.colorScheme.primary,
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
                CustomButton(labelText: "Continue", onPressed: () {}),

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
                        color: _isResendEnabled
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outline,
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
