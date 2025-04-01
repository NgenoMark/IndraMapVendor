    // Import necessary packages
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Model class for ProjectData
class ProjectData {
  final String applicationNo;
  final String customerName;
  final String customerAddress;
  final String customerTelephone;
  final String city;
  final String district;
  final String zone;
  final String programa;

  ProjectData({
    required this.applicationNo,
    required this.customerName,
    required this.customerAddress,
    required this.customerTelephone,
    required this.city,
    required this.district,
    required this.zone,
    required this.programa,
  });

  // Factory method to parse JSON
  factory ProjectData.fromJson(Map<String, dynamic> json) {
    return ProjectData(
      applicationNo: json['applicationNo'],
      customerName: json['customerName'],
      customerAddress: json['customerAddress'],
      customerTelephone: json['customerTelephone'],
      city: json['city'],
      district: json['district'],
      zone: json['zone'],
      programa: json['programa'],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProjectDataScreen(),
    );
  }
}

class ProjectDataScreen extends StatefulWidget {
  @override
  _ProjectDataScreenState createState() => _ProjectDataScreenState();
}

class _ProjectDataScreenState extends State<ProjectDataScreen> {
  late Future<List<ProjectData>> futureProjectData;

  @override
  void initState() {
    super.initState();
    futureProjectData = fetchProjectData();
  }

  // Function to fetch data from backend
  Future<List<ProjectData>> fetchProjectData() async {
    final response = await http.get(Uri.parse('http://localhost:8081/getAllProjectData'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ProjectData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Data List'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<List<ProjectData>>(
          future: futureProjectData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No data available');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var project = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(project.customerName),
                      subtitle: Text('${project.city}, ${project.district}, ${project.zone}'),
                      trailing: Text(project.programa),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
