import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'assign_surveyor_page.dart';
import 'add_material_page.dart';
import 'add_survey_page.dart';

class ProjectDetailsPage extends StatefulWidget {
  final dynamic projectData;

  const ProjectDetailsPage({Key? key, required this.projectData})
      : super(key: key);

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<dynamic>? surveyData;
  List<dynamic>? paymentData;
  List<dynamic>? materialData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchSurveyData();
    fetchPaymentData();
    fetchMaterialData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getMeterPhaseDisplayValue(String? phaseCode) {
  if (phaseCode == null) return 'Not specified';
  
  switch (phaseCode) {
    case 'FA001':
      return '1 Phase';
    case 'FA002':
      return '3 Phase';
    case 'FA003':
      return '3 Phase CT';
    case 'FA004':
      return '3 Phase/4 Wire';
    default:
      return phaseCode; // Return the code if it's not recognized
  }
}

  void fetchSurveyData() async {
    final applicationNo = widget.projectData['applicationNo'];

    final url = Uri.parse(
        'http://localhost:8081/survey-detail/getByApplicationNo/$applicationNo');
    //final url =Uri.parse('http://localhost:8081/survey/searchSurvey/MAPXYZ678901');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          surveyData = json.decode(response.body);
        });
      } else {
        print('Failed to load survey data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching survey data: $e');
    }
  }

  void fetchPaymentData() async {
    final applicationNo = widget.projectData['applicationNo'];
    final url = Uri.parse(
        'http://localhost:8081/payment-detail/getPaymentByApplicationNo/$applicationNo');

    //final url = Uri.parse('http://localhost:8081/payment/numMap/MAPUPL001503');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          paymentData = json.decode(response.body);
        });
      } else {
        print('Failed to load payment data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching payment data: $e');
    }
  }

  void fetchMaterialData() async {
    final applicationNo = widget.projectData['applicationNo'];
    final url = Uri.parse(
        'http://localhost:8081/survey-material/getByApplicationNo/$applicationNo');

    // final url = Uri.parse('http://localhost:8081/materials/mapNo/MAPXYZ678901');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          materialData = json.decode(response.body);
        });
      } else {
        print('Failed to load material data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching material data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Project Details'),
            Tab(text: 'Survey Details'),
            Tab(text: 'Payment Details'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProjectDetailsTab(),
          _buildSurveyDetailsTab(),
          _buildPaymentDetailsTab(),
        ],
      ),
    );
  }

  Widget _buildProjectDetailsTab() {
    final data = widget.projectData;
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Buttons at the top
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
// // In ProjectDetailsPage's _buildProjectDetailsTab method:
// ElevatedButton(
//   onPressed: () async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditProjectPage(projectData: data),
//       ),
//     );

//     if (result == true) {
//       // Refresh the project data if update was successful
//       Navigator.pop(context, true); // Pass the result back to MapVendorPage
//     }
//   },
//   child: Text('Edit Project'),
// ),
// In the button that opens AssignSurveyorPage in ProjectDetailsPage:
// In ProjectDetailsPage's _buildProjectDetailsTab method:
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AssignSurveyorPage(projectData: data),
                    ),
                  );

                  if (result == true) {
                    // Return the refresh signal to MapVendorPage
                    Navigator.pop(context, true);
                  }
                },
                child: Text('Assign Surveyor'),
              ),
            ],
          ),
          SizedBox(height: 20.0), // Add spacing

          // Project details sections
          _buildDetailCard('Project Details', [
            _buildDetailRow('Application No', data['applicationNo']),
            _buildDetailRow('Map Vendor ID', data['mapVendorId']),
            _buildDetailRow('Map No', data['mapNo']),
          ]),
          _buildDetailCard('Customer Details', [
            _buildDetailRow('Customer Name', data['customerName']),
            _buildDetailRow('Customer Address', data['customerAddress']),
            _buildDetailRow('Customer Telephone', data['customerTelephone']),
          ]),
          _buildDetailCard('Location Details', [
            _buildDetailRow('City', data['city']),
            _buildDetailRow('District', data['district']),
            _buildDetailRow('Zone', data['zone']),
          ]),
          _buildDetailCard('Status Details', [
            _buildDetailRow('Completion Status', data['completionStatus']),
            _buildDetailRow('Survey Status', data['surveyStatus']),
            _buildDetailRow('Assigned to Surveyor : ', data['assignedToId']),
          ]),
        ],
      ),
    );
  }

Widget _buildSurveyDetailsTab() {
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      children: [
        // Add Survey Button (only show if no survey exists)
        if (surveyData == null || surveyData!.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddSurveyPage(
                      applicationNumber: widget.projectData['applicationNo'],
                      mapNumber: widget.projectData['mapNo'],
                      vendorId: widget.projectData['mapVendorId'],
                    ),
                  ),
                );
                
                if (result == true) {
                  fetchSurveyData();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text('Add Survey'),
            ),
          ),
        
        // Survey Details (only show if survey exists)
        if (surveyData != null && surveyData!.isNotEmpty)
          _buildDetailCard('Survey Details', [
            _buildDetailRow('Survey Id', surveyData![0]['surveyId'].toString()),
            _buildDetailRow('Application Number', surveyData![0]['applicationNumber']),
            _buildDetailRow('Map Number', surveyData![0]['mapNumber']),
            _buildDetailRow('Map Vendor', surveyData![0]['vendorId']),
            _buildDetailRow('Phase Type', 
              _getMeterPhaseDisplayValue(surveyData![0]['meterPhase'])), // Use the helper function here
            _buildDetailRow('Last Altered', formatDate(surveyData![0]['fActual'])),
            _buildDetailRow('Survey Status', surveyData![0]['surveyStatus']),
          ]),
        
        // Materials section
        _buildMaterialsUsedSection(),
      ],
    ),
  );
}

  Widget _buildPaymentDetailsTab() {
    if (paymentData == null) {
      return Center(child: CircularProgressIndicator());
    } else if (paymentData!.isEmpty) {
      return Center(child: Text('No payment data available.'));
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: paymentData!.map((payment) {
          return _buildDetailCard('Payment Details', [
            _buildDetailRow('Application Number', payment['applicationNo']),
            _buildDetailRow('Map Number', payment['mapNo']),
            _buildDetailRow('Map Vendor', payment['mapVendorId']),
            _buildDetailRow('Payent Reference', payment['paymentRef']),
            _buildDetailRow('Total Amount', payment['amount'].toString()),
            _buildDetailRow('Payment Date', formatDate(payment['paymentDate'])),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildMaterialsUsedSection() {
    if (materialData == null) {
      return Center(child: CircularProgressIndicator());
    }

    if (materialData is List) {
      final materials = materialData as List;
      return Column(
        children: [
          if (materials.isNotEmpty)
            _buildDetailCard(
              'Materials Used',
              materials.map((material) {
            return _buildDetailRow(' Material' ,
              material['material'] ?? 'Unknown Material',
               // Pass an empty string or null if _buildDetailRow requires two arguments
            );
              }).toList(),
            ),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMaterialPage(
                    applicationNumber: widget.projectData['applicationNo'],
                    mapNumber: widget.projectData['mapNo'],
                    vendorId: widget.projectData['mapVendorId'],
                  ),
                ),
              );

              if (result == true) {
                // Refresh material data if save was successful
                fetchMaterialData();
              }
            },
            child: Text('Add New Material'),
          ),
        ],
      );
    }

    return Center(child: Text('Invalid material data format'));
  }

  Widget _buildDetailCard(String title, List<Widget> children) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    final isAssignedField = label == 'Assigned to Surveyor : ';
    final isNullValue = value == null || value.toString().isEmpty;

    // Convert value to string for display
    final displayValue = value?.toString() ?? '';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          if (isAssignedField && isNullValue)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Not assigned',
                style: TextStyle(
                  color: Colors.red[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else if (isNullValue)
            Text(
              'Not assigned',
              style: TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
              ),
            )
          else if (isAssignedField)
            Text(
              displayValue,
              style: TextStyle(
                color: Colors.green[800],
                fontWeight: FontWeight.bold,
              ),
            )
          else
            Text(displayValue),
        ],
      ),
    );
  }

  String formatDate(String? date) {
    if (date == null) return 'N/A';
    return DateFormat.yMMMMd().format(DateTime.parse(date));
  }
}
