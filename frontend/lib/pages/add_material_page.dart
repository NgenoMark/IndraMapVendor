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
  final _transformerController = TextEditingController();
  final _polesController = TextEditingController();

  @override
  void dispose() {
    _transformerController.dispose();
    _polesController.dispose();
    super.dispose();
  }

  Future<void> _saveMaterial() async {
  if (!_formKey.currentState!.validate()) return;

  bool allSuccess = true;
  String errorMessage = '';
  int successfulSaves = 0;

  // Save transformers if entered
  if (_transformerController.text.isNotEmpty && 
      int.tryParse(_transformerController.text) != null && 
      int.parse(_transformerController.text) > 0) {
    final materialData = {
      "applicationNumber": widget.applicationNumber,
      "mapNumber": widget.mapNumber,
      "vendorId": widget.vendorId,
      "material": "${_transformerController.text} TRANSFORMERS", // Format as "X TRANSFORMERS"
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8081/survey-material/saveSurveyMaterial'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(materialData),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        successfulSaves++;
      } else {
        allSuccess = false;
        errorMessage = 'Failed to save transformers: ${response.body}';
      }
    } catch (e) {
      allSuccess = false;
      errorMessage = 'Network error saving transformers: $e';
    }
  }

  // Save poles if entered (only proceed if transformers were successful)
  if (allSuccess && _polesController.text.isNotEmpty && 
      int.tryParse(_polesController.text) != null && 
      int.parse(_polesController.text) > 0) {
    final materialData = {
      "applicationNumber": widget.applicationNumber,
      "mapNumber": widget.mapNumber,
      "vendorId": widget.vendorId,
      "material": "${_polesController.text} POLES", // Format as "X POLES"
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8081/survey-material/saveSurveyMaterial'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(materialData),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        successfulSaves++;
      } else {
        allSuccess = false;
        errorMessage = 'Failed to save poles: ${response.body}';
      }
    } catch (e) {
      allSuccess = false;
      errorMessage = 'Network error saving poles: $e';
    }
  }

  // Show appropriate message
  if (successfulSaves == 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter at least one material quantity'),
        duration: Duration(seconds: 2),
      ),
    );
  } else if (allSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(successfulSaves == 2 
            ? 'Both materials saved successfully!' 
            : 'Material saved successfully!'),
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.pop(context, true);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Material')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Information Section
              const Text(
                'Project Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildInfoRow('Application Number', widget.applicationNumber),
              _buildInfoRow('Map Number', widget.mapNumber),
              _buildInfoRow('Vendor ID', widget.vendorId),
              const Divider(height: 32),
              
              // Material Input Section
              const Text(
                'Material Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              // Transformers Input
              TextFormField(
                controller: _transformerController,
                decoration: const InputDecoration(
                  labelText: 'Transformers Quantity',
                  hintText: 'e.g., 3',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.electrical_services),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final num = int.tryParse(value);
                    if (num == null || num < 0) {
                      return 'Please enter a valid number';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Poles Input
              TextFormField(
                controller: _polesController,
                decoration: const InputDecoration(
                  labelText: 'Poles Quantity',
                  hintText: 'e.g., 4',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final num = int.tryParse(value);
                    if (num == null || num < 0) {
                      return 'Please enter a valid number';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveMaterial,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Save Materials',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}