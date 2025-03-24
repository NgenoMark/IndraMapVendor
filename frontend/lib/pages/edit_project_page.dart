import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProjectPage extends StatefulWidget {
  final dynamic projectData;

  const EditProjectPage({Key? key, required this.projectData}) : super(key: key);

  @override
  _EditProjectPageState createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zoneController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  String? _completionStatus;
  String? _surveyStatus;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _customerNameController.text = widget.projectData['customerName'] ?? '';
    _addressController.text = widget.projectData['customerAddress'] ?? '';
    _phoneNumberController.text = widget.projectData['customerTelephone'] ?? '';
    _cityController.text = widget.projectData['city'] ?? '';
    _zoneController.text = widget.projectData['zone'] ?? '';
    _districtController.text = widget.projectData['district'] ?? '';
    _completionStatus = widget.projectData['completionStatus'];
    _surveyStatus = widget.projectData['surveyStatus'];
  }

  Future<void> _updateProject() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    final url = Uri.parse('http://localhost:8081/project-data/update');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'mapNo': widget.projectData['mapNo'],  // Include mapNo in the body
        'customerName': _customerNameController.text,
        'customerAddress': _addressController.text,
        'customerTelephone': _phoneNumberController.text,
        'city': _cityController.text,
        'zone': _zoneController.text,
        'district': _districtController.text,
        'completionStatus': _completionStatus,
        'surveyStatus': _surveyStatus,
      }),
    );

    setState(() => _isSubmitting = false);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update successful!')));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update failed! Try again.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Project')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Customer Name', _customerNameController),
              _buildTextField('Address', _addressController),
              _buildTextField('Phone Number', _phoneNumberController, keyboardType: TextInputType.phone),
              _buildTextField('City', _cityController),
              _buildTextField('Zone', _zoneController),
              _buildTextField('District', _districtController),
              _buildDropdown('Completion Status', _completionStatus, ['Pending', 'Cancelled', 'Completed'], (value) => setState(() => _completionStatus = value)),
              _buildDropdown('Survey Status', _surveyStatus, ['Pending', 'Completed'], (value) => setState(() => _surveyStatus = value)),
              SizedBox(height: 32),
              _isSubmitting
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _updateProject,
                      child: Text('Submit Changes'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        items: items.map((status) => DropdownMenuItem(value: status, child: Text(status))).toList(),
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        validator: (value) => value == null ? 'Select a status' : null,
      ),
    );
  }
}
