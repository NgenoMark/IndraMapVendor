import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart'; 
// Import the package

class CustomerRegisterPage extends StatefulWidget {
  const CustomerRegisterPage({super.key});

  @override
  _CustomerRegisterPageState createState() => _CustomerRegisterPageState();
}

class _CustomerRegisterPageState extends State<CustomerRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for TextFormFields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // For phone number with country code
  String? _phoneNumber;

  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _goToNextPage() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_currentStep < 1) {
        setState(() {
          _currentStep++;
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 300), 
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _goToPreviousPage() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register as Onesait Customer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Step indicator
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  2, // Only two pages now
                  (index) => CircleAvatar(
                    backgroundColor: _currentStep == index ? Colors.green : Colors.grey,
                    radius: 12,
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    _buildPersonalInfoPage(),
                    _buildPasswordInfoPage(),
                  ],
                ),
              ),
            ),
            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep > 0)
                    ElevatedButton(
                      onPressed: _goToPreviousPage,
                      child: Text('Previous'),
                    ),
                  ElevatedButton(
                    onPressed: _goToNextPage,
                    child: Text(
                      _currentStep < 1 ? 'Next' : 'Finish',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Step 1: Personal Info
  Widget _buildPersonalInfoPage() {
    return Column(
      children: <Widget>[
        _buildTextFormField(_fullNameController, 'Full Name'),
        _buildTextFormField(_emailController, 'Email Address', emailValidator),
        _buildPhoneNumberField(),
      ],
    );
  }

  // Step 2: Password Info
  Widget _buildPasswordInfoPage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPasswordField(_passwordController, 'Password'),
          _buildPasswordField(_confirmPasswordController, 'Confirm Password'),
          SizedBox(height: 20), // Spacing before button

          // Ensure button stays visible
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: _handleRegistration,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full-width button
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text(
                'Register as Customer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String labelText,
      [String? Function(String?)? validator]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return '$labelText is required';
              }
              return null;
            },
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: IntlPhoneField(
        decoration: InputDecoration(
          labelText: 'Phone Number',
          border: OutlineInputBorder(),
        ),
        initialCountryCode: 'KE', // Default country code
        onChanged: (phone) {
          _phoneNumber = phone.completeNumber; // Store the complete phone number
        },
        validator: (phone) {
          if (phone == null || phone.number.isEmpty) {
            return 'Phone number is required';
          }
          // Ensure the phone number is at least 5 digits (excluding country code)
          RegExp regExp = RegExp(r'^\d{5,}$');
          if (!regExp.hasMatch(phone.number)) {
            return 'Enter a phone number with at least 5 digits';
          }
          return null; // Return null if the input is valid
        },
      ),
    );
  } 

  Widget _buildPasswordField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$labelText is required';
          }
          if (labelText == 'Password' && value.length < 4) {
            return 'Password must be at least 4 characters long';
          }
          if (labelText == 'Confirm Password' && value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // General email regex
    RegExp regExp = RegExp(r'^[a-zA-Z0-9._%+-]+@([a-zA-Z0-9.-]+)\.([a-zA-Z]{2,})$');

    if (!regExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    // Extract domain (e.g., gmail.com, yahoo.com)
    String domain = value.split('@').last.toLowerCase();

    // List of common valid email providers
    List<String> allowedDomains = [
      'gmail.com', 'yahoo.com', 'outlook.com', 'hotmail.com', 'icloud.com',
      'aol.com', 'zoho.com', 'protonmail.com', 'yandex.com', 'gmx.com', 'live.com',
      'msn.com', 'mail.com', 'fastmail.com'
    ];

    if (!allowedDomains.contains(domain)) {
      return 'Invalid email domain. Use a common provider like Gmail, Yahoo, Outlook, etc.';
    }

    return null;
  }

  void _handleRegistration() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful')),
      );
      print('Phone Number: $_phoneNumber');
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}