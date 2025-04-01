import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Data Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProjectDataForm(),
    );
  }
}

class ProjectDataForm extends StatefulWidget {
  @override
  _ProjectDataFormState createState() => _ProjectDataFormState();
}

class _ProjectDataFormState extends State<ProjectDataForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController applicationNoController = TextEditingController();
  final TextEditingController mapVendorIdController = TextEditingController();
  final TextEditingController mapNoController = TextEditingController();
  final TextEditingController programaController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerAddressController = TextEditingController();
  final TextEditingController customerTelephoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController zoneController = TextEditingController();
  final TextEditingController usuarioController = TextEditingController();

  Future<void> saveProjectData() async {
    final url = Uri.parse('http://localhost:8081/sendProjectData');

    final Map<String, dynamic> requestBody = {
      "applicationNo": applicationNoController.text,
      "mapVendorId": mapVendorIdController.text,
      "mapNo": mapNoController.text,
      "programa": programaController.text,
      "customerName": customerNameController.text,
      "customerAddress": customerAddressController.text,
      "customerTelephone": customerTelephoneController.text,
      "city": cityController.text,
      "district": districtController.text,
      "zone": zoneController.text,
      "fActual": DateTime.now().toIso8601String(),
      "usuario": usuarioController.text
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Project Data saved successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save project data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Save Project Data')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: applicationNoController, decoration: InputDecoration(labelText: 'Application No')),
              TextFormField(controller: mapVendorIdController, decoration: InputDecoration(labelText: 'Map Vendor ID')),
              TextFormField(controller: mapNoController, decoration: InputDecoration(labelText: 'Map No')),
              TextFormField(controller: programaController, decoration: InputDecoration(labelText: 'Programa')),
              TextFormField(controller: customerNameController, decoration: InputDecoration(labelText: 'Customer Name')),
              TextFormField(controller: customerAddressController, decoration: InputDecoration(labelText: 'Customer Address')),
              TextFormField(controller: customerTelephoneController, decoration: InputDecoration(labelText: 'Customer Telephone')),
              TextFormField(controller: cityController, decoration: InputDecoration(labelText: 'City')),
              TextFormField(controller: districtController, decoration: InputDecoration(labelText: 'District')),
              TextFormField(controller: zoneController, decoration: InputDecoration(labelText: 'Zone')),
              TextFormField(controller: usuarioController, decoration: InputDecoration(labelText: 'Usuario')),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveProjectData,
                child: Text('Save Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
