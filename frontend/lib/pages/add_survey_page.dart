import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddSurveyPage extends StatefulWidget {
  final String applicationNumber;
  final String mapNumber;
  final String vendorId;

  const AddSurveyPage({
    Key? key,
    required this.applicationNumber,
    required this.mapNumber,
    required this.vendorId,
  }) : super(key: key);

  @override
  _AddSurveyPageState createState() => _AddSurveyPageState();
}

class _AddSurveyPageState extends State<AddSurveyPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedMeterPhase;
  bool _isLoading = false;

  final Map<String, String> _meterPhaseOptions = {
    '1 Phase': 'FA001',
    '3 Phase': 'FA002',
    '3 Phase CT': 'FA003',
    '3 Phase/4 Wire': 'FA004',
  };

  Future<void> _submitSurvey() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedMeterPhase == null) return;

    setState(() => _isLoading = true);

    final surveyData = {
      "applicationNumber": widget.applicationNumber,
      "mapNumber": widget.mapNumber,
      "vendorId": widget.vendorId,
      "meterPhase": _meterPhaseOptions[_selectedMeterPhase],
    };

try {
  final response = await http.post(
    Uri.parse('http://localhost:8081/survey-detail/saveSurveyDetail'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(surveyData),
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

if (response.statusCode >= 200 && response.statusCode < 300) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Survey saved successfully!'),
      duration: Duration(seconds: 2),
    ),
  );
  Navigator.pop(context, true); // Pass true as a result
} else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Server responded with: ${response.statusCode}\n${response.body}'),
        duration: const Duration(seconds: 5),
      ),
    );
  }
} catch (e) {
  // ... existing error handling

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Survey')),
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
              const SizedBox(height: 16),
              _buildInfoRow('Application Number', widget.applicationNumber),
              _buildInfoRow('Map Number', widget.mapNumber),
              _buildInfoRow('Vendor ID', widget.vendorId),
              const Divider(height: 32),
              
              // Meter Phase Selection
              const Text(
                'Meter Phase',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ..._meterPhaseOptions.keys.map((option) => RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _selectedMeterPhase,
                onChanged: (value) {
                  setState(() => _selectedMeterPhase = value);
                },
              )).toList(),
              const SizedBox(height: 32),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitSurvey,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue.shade700,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Save Survey',
                          style: TextStyle(fontSize: 16, color: Colors.white),
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