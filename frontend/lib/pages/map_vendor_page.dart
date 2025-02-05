import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapVendorPage extends StatefulWidget {
  final Map<String, dynamic> userDetails;

  const MapVendorPage({super.key, required this.userDetails});

  @override
  _MapVendorPageState createState() => _MapVendorPageState();
}

class _MapVendorPageState extends State<MapVendorPage> {
  List<dynamic> projectData = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProjectData();
  }

  Future<void> fetchProjectData() async {
    final String vendorNumber = widget.userDetails['vendorNumber'] ?? '';

    if (vendorNumber.isEmpty) {
      setState(() {
        isLoading = false;
        errorMessage = 'Vendor number is missing.';
      });
      return;
    }

    final String apiUrl = 'http://localhost:8081/getProjectData/$vendorNumber';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          projectData = data is List ? data : [data];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load data. Status: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Vendor Page'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage, style: const TextStyle(color: Colors.red)))
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: projectData.length,
                  itemBuilder: (context, index) {
                    final item = projectData[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: ListTile(
                        title: Text('Application No: ${item['applicationNo']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Customer: ${item['customerName'] ?? 'N/A'}'),
                            Text('Address: ${item['customerAddress'] ?? 'N/A'}'),
                            Text('Telephone: ${item['customerTelephone'] ?? 'N/A'}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
