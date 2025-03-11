import 'package:flutter/material.dart';
import 'package:flutter_intern_template/widgets/custom_appbar.dart';
import 'package:flutter_intern_template/widgets/custom_button.dart';
import 'package:flutter_intern_template/widgets/custom_text_widget.dart';
import 'package:flutter_intern_template/widgets/custom_textfield.dart';

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({super.key});

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  final TextEditingController _accHolderNameController =
      TextEditingController();
  final TextEditingController _accNumberController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  String? _selectedBank;

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
                title: "Add Account",
                subtitle: "Add Your Bank Account Details to Recieve Donation",
              ),
              const SizedBox(height: 35),

              // Bank Account Details Input Field
              CustomTextField(
                  labelText: 'Account Holder Name',
                  controller: _accHolderNameController),

              const SizedBox(height: 30),

              CustomTextField(
                  labelText: 'Bank Account Number',
                  controller: _accNumberController),

              const SizedBox(height: 30),

              // IFSC Code and Select Bank Row
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      labelText: 'IFSC Code',
                      controller: _ifscCodeController,
                    ),
                  ),
                  const SizedBox(width: 16), // Space between fields
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      value: _selectedBank,
                      decoration: InputDecoration(
                        labelText: 'Select Bank',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      items: ['HDFC Bank', 'Kotak Bank', 'Axis Bank']
                          .map((bank) => DropdownMenuItem(
                                value: bank,
                                child: Text(bank),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedBank = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              CustomButton(labelText: "Submit", onPressed: () {}),
            ],
          ),
        ),
      )),
    );
  }
}
