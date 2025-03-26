import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddMaterialPage extends StatefulWidget {
  final String applicationNumber;
  final String mapNumber;
  final String vendorId;

  const AddMaterialPage({
    Key? key,
    required this.applicationNumber,
    required this.mapNumber,
    required this.vendorId,
  }) : super(key: key);

  @override
  _AddMaterialPageState createState() => _AddMaterialPageState();
}

class _AddMaterialPageState extends State<AddMaterialPage> {
  final _formKey = GlobalKey<FormState>();
  final _materialController = TextEditingController();

  @override
  void dispose() {
    _materialController.dispose();
    super.dispose();
  }

Future<void> _saveMaterial() async {
  if (!_formKey.currentState!.validate()) return;

  final materialData = {
    "applicationNumber": widget.applicationNumber,
    "mapNumber": widget.mapNumber,
    "vendorId": widget.vendorId,
    "material": _materialController.text,
  };

  try {
    final response = await http.post(
      Uri.parse('http://localhost:8081/survey-material/saveSurveyMaterial'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(materialData),
    );

    // Handle all successful status codes (200-299)
    if (response.statusCode >= 200 && response.statusCode < 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Material saved successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context, true);
    } 
    // Handle specific error cases
    else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid data: ${response.body}'),
          duration: Duration(seconds: 3),
        ),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Server error: ${response.statusCode}'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Network error: $e'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Material')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _materialController,
                decoration: InputDecoration(
                  labelText: 'Material Details',
                  hintText: 'e.g., 3 TRANS, 4 POLES',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter material details';
                  }
                  return null;
                },
                maxLines: 3,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveMaterial,
                  child: Text('Save Material'),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Application Number: ${widget.applicationNumber}'),
                      Text('Map Number: ${widget.mapNumber}'),
                      Text('Vendor ID: ${widget.vendorId}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}