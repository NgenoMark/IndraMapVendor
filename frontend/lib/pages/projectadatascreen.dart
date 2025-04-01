import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(ProjectDataApp());
}

class ProjectDataApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Data Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProjectDataScreen(),
    );
  }
}

class ProjectDataScreen extends StatefulWidget {
  @override
  _ProjectDataScreenState createState() => _ProjectDataScreenState();
}

class _ProjectDataScreenState extends State<ProjectDataScreen> {
  List<dynamic> projectDataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProjectData();
  }

  Future<void> fetchProjectData() async {
    final url = Uri.parse('http://localhost:8081/getAllProjectData'); // Replace with your actual backend URL
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          projectDataList = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load project data');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Project Data')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: projectDataList.length,
              itemBuilder: (context, index) {
                final data = projectDataList[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Application No: ${data['applicationNo']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Map Vendor ID: ${data['mapVendorId']}'),
                        Text('Map No: ${data['mapNo']}'),
                        Text('City: ${data['city']}'),
                        Text('District: ${data['district']}'),
                        Text('Zone: ${data['zone']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
