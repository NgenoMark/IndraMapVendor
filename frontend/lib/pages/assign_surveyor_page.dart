import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AssignSurveyorPage extends StatefulWidget {
  final dynamic projectData;
  final Function(bool)? onSurveyorAssigned;

  const AssignSurveyorPage({
    Key? key, 
    required this.projectData,
    this.onSurveyorAssigned,
  }) : super(key: key);

  @override
  _AssignSurveyorPageState createState() => _AssignSurveyorPageState();
}

class _AssignSurveyorPageState extends State<AssignSurveyorPage> {
  List<dynamic> surveyors = [];
  List<dynamic> filteredSurveyors = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSurveyors();
  }

  Future<void> fetchSurveyors() async {
    final vendorId = "VM012"; // Or get from widget.projectData
    final url = Uri.parse("http://localhost:8081/surveyors/selectSurveyor?mapVendorId=$vendorId");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          surveyors = json.decode(response.body);
          filteredSurveyors = List.from(surveyors);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load surveyors');
      }
    } catch (e) {
      print('Error fetching surveyors: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> assignSurveyor(String surveyorId, String surveyorName, String employeeNumber) async {
    final url = Uri.parse("http://localhost:8081/project-data/${widget.projectData['applicationNo']}/assign-surveyor");
    final displayName = "$surveyorName ($employeeNumber)";

    try {
      final response = await http.patch(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "assignedToId": surveyorId,
          "assignedToName": displayName
        }),
      );

// In the assignSurveyor method of AssignSurveyorPage:
// In AssignSurveyorPage's assignSurveyor method:
if (response.statusCode == 200) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Surveyor $displayName assigned successfully")),
  );
  
  if (widget.onSurveyorAssigned != null) {
    widget.onSurveyorAssigned!(true);
  }
  
  Navigator.pop(context, true); // Return success signal
} else {
        throw Exception('Failed to assign surveyor: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error assigning surveyor: $e")),
      );
    }
  }

  void filterSurveyors(String query) {
    setState(() {
      filteredSurveyors = query.isEmpty
          ? List.from(surveyors)
          : surveyors.where((surveyor) =>
              surveyor['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
              surveyor['surveyorId'].toString().toLowerCase().contains(query.toLowerCase()) ||
              surveyor['employeeNumber'].toString().toLowerCase().contains(query.toLowerCase()) ||
              surveyor['phoneNumber'].toString().toLowerCase().contains(query.toLowerCase()) ||
              surveyor['email'].toString().toLowerCase().contains(query.toLowerCase()))
            .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assign Surveyor')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: filterSurveyors,
                    decoration: InputDecoration(
                      labelText: "Search Surveyor",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Expanded(
                  child: filteredSurveyors.isEmpty
                      ? const Center(child: Text("No surveyors found"))
                      : ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: filteredSurveyors.length,
                          itemBuilder: (context, index) {
                            final surveyor = filteredSurveyors[index];
                            return _buildSurveyorCard(surveyor);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildSurveyorCard(dynamic surveyor) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfoRow("Name", surveyor['name']?.toString() ?? 'N/A'),
            _buildInfoRow("Surveyor ID", surveyor['surveyorId']?.toString() ?? 'N/A'),
            _buildInfoRow("Employee No", surveyor['employeeNumber']?.toString() ?? 'N/A'),
            _buildInfoRow("Phone", surveyor['phoneNumber']?.toString() ?? 'N/A'),
            _buildInfoRow("Email", surveyor['email']?.toString() ?? 'N/A'),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => assignSurveyor(
                  surveyor['surveyorId']?.toString() ?? '',
                  surveyor['name']?.toString() ?? '',
                  surveyor['employeeNumber']?.toString() ?? '',
                ),
                child: const Text("Assign Surveyor"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }
}