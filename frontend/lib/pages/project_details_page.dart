import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectDetailsPage extends StatefulWidget {
  final dynamic projectData;

  const ProjectDetailsPage({Key? key, required this.projectData}) : super(key: key);

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          _buildDetailRow('Application No', data['applicationNo']),
          _buildDetailRow('Customer Name', data['customerName']),
          _buildDetailRow('Customer Address', data['customerAddress']),
          _buildDetailRow('Customer Telephone', data['customerTelephone']),
          _buildDetailRow('City', data['city']),
          _buildDetailRow('District', data['district']),
          _buildDetailRow('Zone', data['zone']),
          _buildDetailRow('Map Vendor ID', data['mapVendorId']),
          _buildDetailRow('Map No', data['mapNo']),
          _buildDetailRow('Amount', data['amount'].toString()),
          _buildDetailRow('Date Paid', formatDate(data['fActual'])),
        ],
      ),
    );
  }

  Widget _buildSurveyDetailsTab() {
    // Replace with actual survey details
    return Center(
      child: Text('Survey Details will be displayed here.'),
    );
  }

  Widget _buildPaymentDetailsTab() {
    // Replace with actual payment details
    return Center(
      child: Text('Payment Details will be displayed here.'),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text('$label: ${value ?? 'N/A'}', style: TextStyle(fontSize: 16)),
    );
  }

  String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'N/A';
    }
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedDate);
    } catch (e) {
      print("Error parsing date: $e");
      return 'Invalid Date';
    }
  }
}