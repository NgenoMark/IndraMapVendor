import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AssignSurveyorPage extends StatefulWidget {
  final dynamic projectData;

  const AssignSurveyorPage({Key? key, required this.projectData}) : super(key: key);

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
    final vendorId = "VM012";
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

  Future<void> assignSurveyor(String surveyorId) async {
    final url = Uri.parse("https://your-backend.com/api/projects/${widget.projectData['id']}/assign-surveyor");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"surveyorId": surveyorId}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Surveyor assigned successfully")),
        );
      } else {
        throw Exception('Failed to assign surveyor');
      }
    } catch (e) {
      print('Error assigning surveyor: $e');
    }
  }

  void filterSurveyors(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredSurveyors = List.from(surveyors);
      } else {
        filteredSurveyors = surveyors
            .where((surveyor) =>
                surveyor['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
                surveyor['surveyorId'].toString().toLowerCase().contains(query.toLowerCase()) ||
                surveyor['employeeNumber'].toString().toLowerCase().contains(query.toLowerCase()) ||
                surveyor['phoneNumber'].toString().toLowerCase().contains(query.toLowerCase()) ||
                surveyor['email'].toString().toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assign Surveyor')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: filterSurveyors,
                    decoration: InputDecoration(
                      labelText: "Search Surveyor",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: filteredSurveyors.length,
                    itemBuilder: (context, index) {
                      final surveyor = filteredSurveyors[index];

                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              buildInfoRow("Name", surveyor['name']),
                              buildInfoRow("Surveyor ID", surveyor['surveyorId']),
                              buildInfoRow("Employee No", surveyor['employeeNumber']),
                              buildInfoRow("Phone", surveyor['phoneNumber']),
                              buildInfoRow("Email", surveyor['email']),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () => assignSurveyor(surveyor['surveyorId']),
                                  child: Text("Assign Surveyor"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }
}
