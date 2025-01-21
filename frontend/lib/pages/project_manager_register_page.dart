import 'package:flutter/material.dart';

class ProjectManagerRegisterPage extends StatefulWidget {
  @override
  _ProjectManagerRegisterPageState createState() =>
      _ProjectManagerRegisterPageState();
}

class _ProjectManagerRegisterPageState
    extends State<ProjectManagerRegisterPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _goToNextPage() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
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
      appBar: AppBar(
        title: Text('Register as Project Manager'),
      ),
      body: Column(
        children: [
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
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                // Slide 1: Validate
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'First Name '),
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Last Name'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: ''),
                      ),
                    ],
                  ),
                ),
                // Slide 2: Contact
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email Address'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Phone Number'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Role'),
                      ),
                    ],
                  ),
                ),
                // Slide 3: Password
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Password', hintText: 'Enter your password'),
                        obscureText: true,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Re-enter your password',
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                // Slide 4: Complete
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Registration Complete!',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle final submission
                        },
                        child: Text('Finish'),
                      ),
                    ],
                  ),
                ),
              ],
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
    );
  }
}

void main() {
  runApp(MaterialApp(home: ProjectManagerRegisterPage()));
}
