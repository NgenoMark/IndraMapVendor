import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ProjectDetailsPage extends StatefulWidget {
  final dynamic projectData;

  const ProjectDetailsPage({Key? key, required this.projectData}) : super(key: key);

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> with SingleTickerProviderStateMixin {
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

  void fetchSurveyData() async {
    final url = Uri.parse('http://localhost:8081/survey/searchSurvey/MAPXYZ678901');
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
    final url = Uri.parse('http://localhost:8081/payment/numMap/MAPUPL001503');
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
    final url = Uri.parse('http://localhost:8081/materials/mapNo/MAPXYZ678901');
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
        children: [
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
            _buildDetailRow('Assigned to', data['assignedToId']),
          ]),
        ],
      ),
    );
  }

  Widget _buildSurveyDetailsTab() {
    if (surveyData == null) {
      return Center(child: CircularProgressIndicator());
    } else if (surveyData!.isEmpty) {
      return Center(child: Text('No survey data available.'));
    }

    final survey = surveyData![0];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildDetailCard('Survey Details', [
            _buildDetailRow('Map Number', survey['mapNumber']),
            _buildDetailRow('Map Vendor', survey['vendorId']),
            _buildDetailRow('Phase Type', survey['tipFase']),
            _buildDetailRow('Last Altered', formatDate(survey['fActual'])),
            _buildDetailRow('Survey Id', survey['idSurveyData'].toString()),
            _buildDetailRow('Remarks', survey['remarks']),
          ]),
          _buildMaterialsUsedSection(), // Materials inside survey tab
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
            _buildDetailRow('Map Number', payment['numMap']),
            _buildDetailRow('Map Vendor', payment['coMapVend']),
            _buildDetailRow('Account Payer ID', payment['accountId'].toString()),
            _buildDetailRow('Total Amount', payment['impTotRec'].toString()),
            _buildDetailRow('Payment Date', formatDate(payment['fActual'])),
            _buildDetailRow('Status', payment['estPago']),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildMaterialsUsedSection() {
    if (materialData == null) {
      return Center(child: CircularProgressIndicator());
    } else if (materialData!.isEmpty) {
      return Center(child: Text('No material data available.'));
    }

    return _buildDetailCard('Materials Used', materialData!.map((material) {
      return _buildDetailRow(
        '${material['material']}',
        '',
      );
    }).toList());
  }

  Widget _buildDetailCard(String title, List<Widget> children) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? 'N/A'),
        ],
      ),
    );
  }

  String formatDate(String? date) {
    if (date == null) return 'N/A';
    return DateFormat.yMMMMd().format(DateTime.parse(date));
  }
}
