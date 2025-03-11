import 'package:flutter/material.dart';

class CountryPhoneInput extends StatefulWidget {
  final TextEditingController phoneController;
  const CountryPhoneInput({Key? key, required this.phoneController})
      : super(key: key);

  @override
  _CountryPhoneInputState createState() => _CountryPhoneInputState();
}

class _CountryPhoneInputState extends State<CountryPhoneInput> {
  String selectedCountry = "India (+91)";
  String countryFlag = "🇮🇳";

  // This would typically be a more comprehensive list
  final List<Map<String, String>> countries = [
    {"name": "United States (+1)", "flag": "🇺🇸", "code": "+1"},
    {"name": "India (+91)", "flag": "🇮🇳", "code": "+91"},
    {"name": "United Kingdom (+44)", "flag": "🇬🇧", "code": "+44"},
    {"name": "Canada (+1)", "flag": "🇨🇦", "code": "+1"},
    {"name": "Australia (+61)", "flag": "🇦🇺", "code": "+61"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          // Country Selector Button
          InkWell(
            onTap: _showCountryPicker,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Row(
                children: [
                  Text(countryFlag, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Text(
                    selectedCountry,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),

          // Phone Number Input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: widget.phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Phone number',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(
                  countries[index]["flag"]!,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(countries[index]["name"]!),
                onTap: () {
                  setState(() {
                    selectedCountry = countries[index]["name"]!;
                    countryFlag = countries[index]["flag"]!;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}
