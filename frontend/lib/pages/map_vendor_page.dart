// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'payment.dart';

// class MapVendorPage extends StatefulWidget {
//   @override
//   _MapVendorPageState createState() => _MapVendorPageState();
// }

// class _MapVendorPageState extends State<MapVendorPage> {
//   List<dynamic> vendorDataList = [];
//   bool isLoading = true;
//   final String mapVendorId = "VM012"; // Hardcoded for independent execution
//   final String accessToken = "your_access_token"; // Replace with actual token if needed

//   @override
//   void initState() {
//     super.initState();
//     fetchVendorData();
//   }

//   Future<void> fetchVendorData() async {
//     final url = Uri.parse('http://localhost:8081/getProjectById/$mapVendorId');
//     print("Final URL: $url");

//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer $accessToken',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         var decodedResponse = json.decode(response.body);
//         print("API Response: $decodedResponse");

//         setState(() {
//           vendorDataList = decodedResponse is List ? decodedResponse : [decodedResponse];
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to load vendor data. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print("Error: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   String getStatusStars(String status) {
//     switch (status.toLowerCase()) {
//       case "not started":
//         return "⭐☆☆☆☆";
//       case "pending":
//         return "⭐⭐☆☆☆";
//       case "completed":
//         return "⭐⭐⭐⭐⭐";
//       default:
//         return "No Rating";
//     }
//   }

//   void _showDescriptionDialog(BuildContext context, dynamic data) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Project Description'),
//           content: SingleChildScrollView  (
//             child: ListBody(
//               children: <Widget>[
//                 Text('Application No: ${data['applicationNo']}'),
//                 Text('Customer Name: ${data['customerName']}'),
//                 Text('Customer Address: ${data ['customerAddress']}'),
//                 Text('Customer Telephone: ${data ['Telephone']}'),
//                 Text('Customer Email: ${data ['customerEmail']}'),
//                 Text('City: ${data['city']}'),
//                 Text('District: ${data['district']}'),
//                 Text('Zone: ${data['zone']}'),
//                 Text('Map Vendor ID: ${data['mapVendorId']}'),
//                 Text('Map No: ${data['mapNo']}'),

//               ]
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Close'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _logout() {
//     print("User logged out");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Projects'),
//         leading: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               icon: Icon(Icons.home),
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => MapVendorPage()),
//                 );
//               },
//             ),
//             PopupMenuButton<String>(
//               onSelected: (String result) {
//                 print("Selected:  \$result");
//               },
//               itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                 PopupMenuItem<String>(
//                   value: 'My Account',
//                   child: Text('My Account'),
//                 ),
//                 PopupMenuItem<String>(
//                   value: 'My Projects',
//                   child: Text('My Projects'),
//                 ),
//                 PopupMenuItem<String>(
//                   value: 'Past Projects' ,
//                   child: Text('Past Projects'),
//                 ),
//               ],
//               icon: Icon(Icons.menu),
//                 ),
//               ],
//             ),

//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               print("Search button clicked");
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: _logout,
//           ),
//         ],
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: vendorDataList.length,
//                     itemBuilder: (context, index) {
//                       final data = vendorDataList[index];
//                       return Card(
//                         margin: EdgeInsets.all(8.0),
//                         child: ListTile(
//                           title: Text('Application No: ${data['applicationNo']}'),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Application No: ${data['applicationNo']}'),
//                               Text('Customer Name: ${data['customerName']}'),
//                               Text('Customer Address: ${data ['customerAddress']}'),
//                               Text('Customer Telephone: ${data ['Telephone']}'),
//                               Text('Customer Email: ${data ['customerEmail']}'),
//                               Text('City: ${data['city']}'),
//                               Text('District: ${data['district']}'),
//                               Text('Zone: ${data['zone']}'),
//                               Text('Map Vendor ID: ${data['mapVendorId']}'),
//                                 Text('Map No: ${data['mapNo']}'),
//                             ],
//                           ),
//                           onTap: () {
//                             _showDescriptionDialog(context, data);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           print("Explore Projects clicked");
//                         },
//                         child: Text('Explore Projects'),
//                       ),
//                       SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder:( context) => PaymentPage()),
//                             );

//                        },
//                         child: Text('Payment Page'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: MapVendorPage(),
//   ));
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'payment.dart';
import 'package:intl/intl.dart'; // Import this at the top

class MapVendorPage extends StatefulWidget {

  // final String mapVendorId;
  // final String accessToken;

  // final String mapVendorId = "VM012"; // Hardcoded for independent execution
  // final String accessToken ="your_access_token"; // Replace with actual token if needed


  // const MapVendorPage({Key? key, required this.mapVendorId, required this.accessToken}) : super(key: key);


  @override
  _MapVendorPageState createState() => _MapVendorPageState();
}

class _MapVendorPageState extends State<MapVendorPage> {
  List<dynamic> vendorDataList = [];
  bool isLoading = true;
  final String mapVendorId = "VM012"; // Hardcoded for independent execution
  final String accessToken ="your_access_token"; // Replace with actual token if needed

  @override
  void initState() {
    super.initState();
    fetchVendorData();
  }

  Future<void> fetchVendorData() async {
    // final url = Uri.parse('http://localhost:8081/getProjectById/${widget.mapVendorId}');
    final url = Uri.parse('http://localhost:8081/getProjectById/$mapVendorId');
    print("Fetching data from: $url");

    try {
      final response = await http.get(
        url,
        headers: {
          // 'Authorization': 'Bearer ${widget.accessToken}',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        print("API Response: $decodedResponse");

        setState(() {
          vendorDataList =
              decodedResponse is List ? decodedResponse : [decodedResponse];
          isLoading = false;
        });
      } else {
        print(
            "Error: Failed to load vendor data. Status Code: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'N/A';
    }
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(parsedDate); // Adjust format as needed
    } catch (e) {
      print("Error parsing date: $e");
      return 'Invalid Date';
    }
  }

  void _showDescriptionDialog(BuildContext context, dynamic data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Project Description'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildDetailRow('Application No', data['applicationNo']),
                _buildDetailRow('Customer Name', data['customerName']),
                _buildDetailRow('Customer Address', data['customerAddress']),
                _buildDetailRow('Customer Telephone',
                    data['customerTelephone']), // Fixed key
                _buildDetailRow('City', data['city']),
                _buildDetailRow('District', data['district']),
                _buildDetailRow('Zone', data['zone']),
                _buildDetailRow('Map Vendor ID', data['mapVendorId']),
                _buildDetailRow('Map No', data['mapNo']),
                _buildDetailRow('Amount', data['amount'].toString()),
                Text('Date Paid: ${formatDate(data['fActual'])}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Text('$label: ${value ?? 'N/A'}', style: TextStyle(fontSize: 16));
  }

  void _logout() {
    print("User logged out");
    // Implement logout functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Projects'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print("Search button clicked");
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
          PopupMenuButton<String>(
            onSelected: (String result) {
              print("Selected: $result");
              // Implement navigation logic based on selection
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'My Account',
                child: Text('My Account'),
              ),
              PopupMenuItem<String>(
                value: 'My Projects',
                child: Text('My Projects'),
              ),
              PopupMenuItem<String>(
                value: 'Past Projects',
                child: Text('Past Projects'),
              ),
            ],
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: vendorDataList.length,
                    itemBuilder: (context, index) {
                      final data = vendorDataList[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                              'Application No: ${data['applicationNo']}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow(
                                  'Customer Name', data['customerName']),
                              _buildDetailRow('City', data['city']),
                              _buildDetailRow('District', data['district']),
                              _buildDetailRow('Zone', data['zone']),
                            ],
                          ),
                          onTap: () => _showDescriptionDialog(context, data),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print("Explore Projects clicked");
                        },
                        child: Text('Explore Projects'),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentPage()),
                          );
                        },
                        child: Text('Payment Page'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MapVendorPage(),
    //home: MapVendorPage(mapVendorId: '', accessToken: '',),
  ));
}
