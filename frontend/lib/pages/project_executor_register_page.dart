import 'package:flutter/material.dart';

class ProjectExecutorRegisterPage extends StatefulWidget {
  @override
  _ProjectExecutorRegisterPageState createState() =>
      _ProjectExecutorRegisterPageState();
}

class _ProjectExecutorRegisterPageState
    extends State<ProjectExecutorRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for TextFormFields
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyAddressController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactPersonController =
      TextEditingController();
  final TextEditingController _contactPersonRoleController =
      TextEditingController();
  final TextEditingController _yearsOfExperienceController =
      TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _projectCategoriesController =
      TextEditingController();
  final TextEditingController _taxIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _goToNextPage() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_currentStep < 3) {
        setState(() {
          _currentStep++;
        });
        _pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    }
  }

  void _goToPreviousPage() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register as Project Executor')),
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
                  4,
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
            Expanded(
              child: Form(
                key: _formKey,
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(), // Disable swipe to navigate
                  children: <Widget>[
                    // Step 1: Company Info
                    _buildCompanyInfoPage(),
                    // Step 2: Contact Info
                    _buildContactInfoPage(),
                    // Step 3: Registration Info
                    _buildRegistrationInfoPage(),
                    // Step 4: Password Info
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
                      _currentStep < 3 ? 'Next' : 'Finish',
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

  // Company Info Step
  Widget _buildCompanyInfoPage() {
    return Column(
      children: <Widget>[
        _buildTextFormField(_companyNameController, 'Company Name'),
        _buildTextFormField(_companyAddressController, 'Company Address'),
        _buildTextFormField(_phoneNumberController, 'Phone Number'),
        _buildTextFormField(_emailController, 'Email Address', emailValidator),
      ],
    );
  }

  // Contact Info Step
  Widget _buildContactInfoPage() {
    return Column(
      children: <Widget>[
        _buildTextFormField(_contactPersonController, 'Contact Person'),
        _buildTextFormField(_contactPersonRoleController, 'Contact Person Role'),
        _buildTextFormField(
            _yearsOfExperienceController, 'Years of Experience'),
        _buildTextFormField(_specializationController, 'Specialization'),
      ],
    );
  }

  // Registration Info Step
  Widget _buildRegistrationInfoPage() {
    return Column(
      children: <Widget>[
        _buildTextFormField(_projectCategoriesController, 'Project Categories'),
        _buildTextFormField(_taxIdController, 'Tax ID'),
      ],
    );
  }

  // Password Info Step
  Widget _buildPasswordInfoPage() {
    return Column(
      children: <Widget>[
        _buildPasswordField(_passwordController, 'Password'),
        _buildPasswordField(_confirmPasswordController, 'Confirm Password'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _handleRegistration,
          child: Text('Register as Project Executor'),
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

  // TextFormField builder to reduce redundancy with optional custom validator
  Widget _buildTextFormField(
      TextEditingController controller, String labelText, [String? Function(String?)? validator]) {
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
          if (labelText == 'Password' && value.length < 8) {
            return 'Password must be at least 8 characters long';
          }
          if (labelText == 'Confirm Password' && value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  // Email validation function
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
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
  runApp(MaterialApp(home: ProjectExecutorRegisterPage()));
}
