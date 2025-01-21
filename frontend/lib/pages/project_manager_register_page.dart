import 'package:flutter/material.dart';

class ProjectManagerRegisterPage extends StatefulWidget {
  @override
  _ProjectManagerRegisterPageState createState() =>
      _ProjectManagerRegisterPageState();
}

class _ProjectManagerRegisterPageState
    extends State<ProjectManagerRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentStep = 0; // Track current step

  // Controllers for form fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register as Project Manager'),
      ),
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
                  5,
                  (index) => CircleAvatar(
                    backgroundColor:
                        _currentStep == index ? Colors.green : Colors.grey,
                    radius: 12,
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            // Form
            Expanded(
              child: Form(
                key: _formKey,
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    // Step 1: Personal Info
                    _buildPersonalInfoPage(),
                    // Step 2: Contact Info
                    _buildContactInfoPage(),
                    // Step 3: Project Info
                    _buildProjectInfoPage(),
                    // Step 4: Password Info
                    _buildPasswordInfoPage(),
                    // Step 5: Complete Registration
                    _buildCompletePage(),
                  ],
                ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextFormField(_fullNameController, 'Full Name'),
        _buildTextFormField(_roleController, 'Role'),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              setState(() {
                _currentStep++;
              });
              _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            }
          },
          child: Text('Next'),
        ),
      ],
    );
  }

  // Step 2: Contact Info
  Widget _buildContactInfoPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextFormField(_emailController, 'Email Address', isEmail: true),
        _buildTextFormField(_phoneController, 'Phone Number'),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              setState(() {
                _currentStep++;
              });
              _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            }
          },
          child: Text('Next'),
        ),
      ],
    );
  }

  // Step 3: Project Info
  Widget _buildProjectInfoPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextFormField(_companyNameController, 'Project Executor Company Name'),
        _buildTextFormField(_experienceController, 'Years of Experience'),
        _buildTextFormField(_educationController, 'Highest Education Level'),
        _buildTextFormField(_skillsController, 'Skills'),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              setState(() {
                _currentStep++;
              });
              _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            }
          },
          child: Text('Next'),
        ),
      ],
    );
  }

  // Step 4: Password Info
  Widget _buildPasswordInfoPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPasswordField(_passwordController, 'Password'),
        _buildPasswordField(_confirmPasswordController, 'Confirm Password'),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              setState(() {
                _currentStep++;
              });
              _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            }
          },
          child: Text('Next'),
        ),
      ],
    );
  }

  // Step 5: Complete Registration
  Widget _buildCompletePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Registration Complete!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _handleRegistration,
          child: Text('Finish'),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            backgroundColor: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 15),
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  // TextFormField builder to reduce redundancy
  Widget _buildTextFormField(
      TextEditingController controller, String labelText,
      {bool isEmail = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$labelText is required';
          }
          if (isEmail && !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
              .hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
      ),
    );
  }

  // Password field builder
  Widget _buildPasswordField(
      TextEditingController controller, String labelText) {
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
          if (value.length < 8) {
            return 'Password must be at least 8 characters long';
          }
          if (labelText == 'Confirm Password' &&
              value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  // Handle registration logic here
  void _handleRegistration() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle the registration logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful')),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(home: ProjectManagerRegisterPage()));
}
