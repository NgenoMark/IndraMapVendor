import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchSurveyData();
    fetchPaymentData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void fetchSurveyData() async {
    final url =
        Uri.parse('http://localhost:8081/survey/searchSurvey/MAPXYZ678901');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          surveyData = json.decode(response.body); // List<dynamic>
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

    //'http://localhost:8081/payment/numMap/${widget.projectData['mapNo']}');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          paymentData = json.decode(response.body); // List<dynamic>
        });
      } else {
        print('Failed to load payment data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching payment data: $e');
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
          _buildDetailRow('Application No', data['applicationNo']),
          _buildDetailRow('Map Vendor ID', data['mapVendorId']),
          _buildDetailRow('Map No', data['mapNo']),
          _buildDetailRow('Customer Name', data['customerName']),
          _buildDetailRow('Customer Address', data['customerAddress']),
          _buildDetailRow('Customer Telephone', data['customerTelephone']),
          _buildDetailRow('City', data['city']),
          _buildDetailRow('District', data['district']),
          _buildDetailRow('Zone', data['zone']),
          _buildDetailRow('Completion Status', data['completionStatus']),
          _buildDetailRow('Survey Status', data['surveyStatus']),
          _buildDetailRow('Assigned to', data['assignedToId']),
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

    final survey = surveyData![
        0]; // Assuming you want to display only the first survey entry

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Map Number', survey['mapNumber']),
          _buildDetailRow('Map Vendor', survey['vendorId']),
          _buildDetailRow('Phase Type', survey['tipFase']),
          _buildDetailRow('Last Altered', formatDate(survey['fActual'])),
          _buildDetailRow('Survey Id', survey['idSurveyData'].toString()),
          _buildDetailRow('Remarks', survey['remarks']),
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

    final payment = paymentData![0];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Map Number', payment['numMap']),
          _buildDetailRow('Map Vendor', payment['coMapVend']),
          // _buildDetailRow('Application Number', survey['tipFase']),

          _buildDetailRow('Account Payer ID', payment['accountId'].toString()),
          _buildDetailRow('Total Amount', payment['impTotRec'].toString()),
          _buildDetailRow('Payment Date', formatDate(payment['fActual'])),
          _buildDetailRow('Status', payment['estPago']),
        ],
      ),
    );
  

    // return ListView.builder(
    //   padding: EdgeInsets.all(16.0),
    //   itemCount: paymentData!.length,
    //   itemBuilder: (context, index) {
    //     final payment = paymentData![index];
    //     return Card(
    //       margin: EdgeInsets.symmetric(vertical: 8.0),
    //       child: ListTile(
    //         title: Text('Payment ID: ${payment['paymentId'] ?? 'N/A'}'),
    //         subtitle: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text('Amount: ${payment['amount'] ?? 'N/A'}'),
    //             Text('Paid By: ${payment['paidBy'] ?? 'N/A'}'),
    //             Text('Date: ${formatDate(payment['date'])}'),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
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
