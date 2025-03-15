import 'package:flutter/material.dart';
import 'package:flutter_intern_template/helper/navigation_helper.dart';
import 'package:flutter_intern_template/screens/login_page.dart';
import 'package:flutter_intern_template/widgets/custom_appbar.dart';
import 'package:flutter_intern_template/widgets/custom_button.dart';
import 'package:flutter_intern_template/widgets/custom_text_widget.dart';
import 'package:flutter_intern_template/widgets/custom_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Password check
  void confirmPassword() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Implement password change logic
      navigateToPage(context, LoginPage());
    }
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
                const SizedBox(height: 8),
                CustomTextWidget(
                  title: "Set new password",
                  subtitle: "Create strong and secured\nnew password.",
                ),
                const SizedBox(height: 35),

                // Password Input Field
                CustomTextField(
                    labelText: 'New Password',
                    controller: _passwordController,
                    obscure: true),

                const SizedBox(height: 20),

                CustomTextField(
                    labelText: 'Confirm Password',
                    controller: _confirmPasswordController,
                    obscure: true),

                const SizedBox(height: 30),

                // Submit Button
                CustomButton(
                    labelText: 'Save Password', onPressed: confirmPassword)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
