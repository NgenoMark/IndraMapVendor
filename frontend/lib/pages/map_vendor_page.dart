// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'payment.dart';
// import 'package:intl/intl.dart';

// class MapVendorPage extends StatefulWidget {
//   final String mapVendorId;
//   final String accessToken;

//   const MapVendorPage(
//       {Key? key, required this.mapVendorId, required this.accessToken})
//       : super(key: key);

//   @override
//   _MapVendorPageState createState() => _MapVendorPageState();
// }

// class _MapVendorPageState extends State<MapVendorPage> {
//   List<dynamic> vendorDataList = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchVendorData();
//   }

//   Future<void> fetchVendorData() async {
//     final url =
//         Uri.parse('http://localhost:8081/getProjectById/${widget.mapVendorId}');
//     print("Fetching data from: $url");

//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': 'Bearer ${widget.accessToken}',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         var decodedResponse = json.decode(response.body);
//         print("API Response: $decodedResponse");

//         setState(() {
//           vendorDataList =
//               decodedResponse is List ? decodedResponse : [decodedResponse];
//           isLoading = false;
//         });
//       } else {
//         print("Error: Failed to load vendor data. Status Code: ${response.statusCode}");
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   String formatDate(String? dateString) {
//     if (dateString == null || dateString.isEmpty) {
//       return 'N/A';
//     }
//     try {
//       DateTime parsedDate = DateTime.parse(dateString);
//       return DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedDate);
//     } catch (e) {
//       print("Error parsing date: $e");
//       return 'Invalid Date';
//     }
//   }

//   void _showDescriptionDialog(BuildContext context, dynamic data) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Project Description'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 _buildDetailRow('Application No', data['applicationNo']),
//                 _buildDetailRow('Customer Name', data['customerName']),
//                 _buildDetailRow('Customer Address', data['customerAddress']),
//                 _buildDetailRow('Customer Telephone', data['customerTelephone']),
//                 _buildDetailRow('City', data['city']),
//                 _buildDetailRow('District', data['district']),
//                 _buildDetailRow('Zone', data['zone']),
//                 _buildDetailRow('Map Vendor ID', data['mapVendorId']),
//                 _buildDetailRow('Map No', data['mapNo']),
//                 _buildDetailRow('Amount', data['amount'].toString()),
//                 Text('Date Paid: ${formatDate(data['fActual'])}'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Close'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildDetailRow(String label, String? value) {
//     return Text('$label: ${value ?? 'N/A'}', style: const TextStyle(fontSize: 16));
//   }

//   void _logout() {
//     print("User logged out");
//     // Implement logout functionality
//   }

//   void _navigateTo(String route) {
//     Navigator.pushNamed(context, route);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Projects'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               print("Search button clicked");
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: _logout,
//           ),
//           PopupMenuButton<String>(
//             onSelected: (String result) {
//               if (result == 'My Account') {
//                 _navigateTo('/myAccount');
//               } else if (result == 'Past Projects') {
//                 _navigateTo('/pastProjects');
//               }
//             },
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//               const PopupMenuItem<String>(
//                 value: 'My Account',
//                 child: Text('My Account'),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'Past Projects',
//                 child: Text('Past Projects'),
//               ),
//             ],
//             icon: const Icon(Icons.menu),
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Text(
//                     'Map Survey Summary',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: vendorDataList.length,
//                     itemBuilder: (context, index) {
//                       final data = vendorDataList[index];
//                       String projectStatus = getProjectStatus(data);

//                       return Card(
//                         margin: const EdgeInsets.all(8.0),
//                         child: ListTile(
//                           title: Text(
//                             'Application No: ${data['applicationNo']}',
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               _buildDetailRow('Customer Name', data['customerName']),
//                               _buildDetailRow('City', data['city']),
//                               _buildDetailRow('District', data['district']),
//                               _buildDetailRow('Zone', data['zone']),
//                               Text('Status: $projectStatus'),
//                             ],
//                           ),
//                           leading: getStatusIcon(projectStatus),
//                           onTap: () => _showDescriptionDialog(context, data),
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
//                           _navigateTo('/exploreProjects');
//                         },
//                         child: const Text('Explore Projects'),
//                       ),
//                       const SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: () {
//                           _navigateTo('/payment');
//                         },
//                         child: const Text('Payment Page'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 _buildBottomNavigationBar(),
//               ],
//             ),
//     );
//   }

//   String getProjectStatus(dynamic data) {
//     if (data['fActual'] == null || data['fActual'].isEmpty) {
//       return 'Not Started';
//     } else if (data['status'] == 'complete') {
//       return 'Complete';
//     } else {
//       return 'In Progress';
//     }
//   }

//   Widget getStatusIcon(String status) {
//     switch (status) {
//       case 'Not Started':
//         return const Icon(Icons.radio_button_unchecked, color: Colors.grey);
//       case 'In Progress':
//         return const Icon(Icons.hourglass_bottom, color: Colors.orange);
//       case 'Complete':
//         return const Icon(Icons.check_circle, color: Colors.green);
//       default:
//         return const Icon(Icons.error, color: Colors.red);
//     }
//   }

//   Widget _buildBottomNavigationBar() {
//     return BottomNavigationBar(
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//         BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Projects'),
//         BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
//       ],
//       currentIndex: 1,
//       selectedItemColor: Colors.blue,
//       onTap: (int index) {
//         if (index == 0) _navigateTo('/home');
//         if (index == 2) _navigateTo('/account');
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'payment.dart';
// import 'package:intl/intl.dart'; // Import this at the top

// class MapVendorPage extends StatefulWidget {

//   // final String mapVendorId;
//   // final String accessToken;

//   // final String mapVendorId = "VM012"; // Hardcoded for independent execution
//   // final String accessToken ="your_access_token"; // Replace with actual token if needed

//   //const MapVendorPage({Key? key, required this.mapVendorId, required this.accessToken}) : super(key: key);
//   const MapVendorPage({Key? key}) : super(key: key);

//   @override
//   _MapVendorPageState createState() => _MapVendorPageState();
// }

// class _MapVendorPageState extends State<MapVendorPage> {
//   List<dynamic> vendorDataList = [];

//   bool isLoading = true;
//   final String mapVendorId = "VM012"; // Hardcoded for independent execution
//   final String accessToken ="your_access_token"; // Replace with actual token if needed

//   @override
//   void initState() {
//     super.initState();
//     fetchVendorData();
//   }

//   Future<void> fetchVendorData() async {
//     //final url = Uri.parse('http://localhost:8081/getProjectById/${widget.mapVendorId}');
//     final url = Uri.parse('http://localhost:8081/getProjectById/$mapVendorId');
//     print("Fetching data from: $url");

//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           //'Authorization': 'Bearer ${widget.accessToken}',
//           'Authorization': 'Bearer $accessToken',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         var decodedResponse = json.decode(response.body);
//         print("API Response: $decodedResponse");

//         setState(() {
//           vendorDataList =
//               decodedResponse is List ? decodedResponse : [decodedResponse];
//           isLoading = false;
//         });
//       } else {
//         print(
//             "Error: Failed to load vendor data. Status Code: ${response.statusCode}");
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   String formatDate(String? dateString) {
//     if (dateString == null || dateString.isEmpty) {
//       return 'N/A';
//     }
//     try {
//       DateTime parsedDate = DateTime.parse(dateString);
//       return DateFormat('yyyy-MM-dd HH:mm:ss')
//           .format(parsedDate); // Adjust format as needed
//     } catch (e) {
//       print("Error parsing date: $e");
//       return 'Invalid Date';
//     }
//   }

//   void _showDescriptionDialog(BuildContext context, dynamic data) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Project Description'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 _buildDetailRow('Application No', data['applicationNo']),
//                 _buildDetailRow('Customer Name', data['customerName']),
//                 _buildDetailRow('Customer Address', data['customerAddress']),
//                 _buildDetailRow('Customer Telephone',
//                     data['customerTelephone']), // Fixed key
//                 _buildDetailRow('City', data['city']),
//                 _buildDetailRow('District', data['district']),
//                 _buildDetailRow('Zone', data['zone']),
//                 _buildDetailRow('Map Vendor ID', data['mapVendorId']),
//                 _buildDetailRow('Map No', data['mapNo']),
//                 _buildDetailRow('Amount', data['amount'].toString()),
//                 Text('Date Paid: ${formatDate(data['fActual'])}'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Close'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildDetailRow(String label, String? value) {
//     return Text('$label: ${value ?? 'N/A'}', style: TextStyle(fontSize: 16));
//   }

//   void _logout() {
//     print("User logged out");
//     // Implement logout functionality here
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Projects'),
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
//           PopupMenuButton<String>(
//             onSelected: (String result) {
//               print("Selected: $result");
//               // Implement navigation logic based on selection
//             },
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//               PopupMenuItem<String>(
//                 value: 'My Account',
//                 child: Text('My Account'),
//               ),
//               PopupMenuItem<String>(
//                 value: 'My Projects',
//                 child: Text('My Projects'),
//               ),
//               PopupMenuItem<String>(
//                 value: 'Past Projects',
//                 child: Text('Past Projects'),
//               ),
//             ],
//             icon: Icon(Icons.menu),
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
//                           title: Text(
//                               'Application No: ${data['applicationNo']}',
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               _buildDetailRow(
//                                   'Customer Name', data['customerName']),
//                               _buildDetailRow('City', data['city']),
//                               _buildDetailRow('District', data['district']),
//                               _buildDetailRow('Zone', data['zone']),
//                             ],
//                           ),
//                           onTap: () => _showDescriptionDialog(context, data),
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
//                             MaterialPageRoute(
//                                 builder: (context) => PaymentPage()),
//                           );
//                         },
//                         child: Text('Payment Page'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: MapVendorPage(),
//     //home: MapVendorPage(mapVendorId: '', accessToken: '',),
//   ));
// }


import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'payment.dart';
import 'package:intl/intl.dart';
import 'project_details_page.dart';
import 'dashboard.dart';

class MapVendorPage extends StatefulWidget {
  const MapVendorPage({Key? key}) : super(key: key);

  @override
  _MapVendorPageState createState() => _MapVendorPageState();
}

class _MapVendorPageState extends State<MapVendorPage> {
  List<dynamic> allProjectsList = []; // Store all fetched projects
  List<dynamic> vendorDataList = []; // Displayed list after filtering
  bool isLoading = true;
  final String mapVendorId = "VM012"; // Hardcoded for independent execution
  final String accessToken = "your_access_token"; // Replace with actual token
  String selectedStatus = ''; // Holds the selected filter

  @override
  void initState() {
    super.initState();
    fetchVendorData();
  }

  Future<void> fetchVendorData() async {
    String baseUrl = 'http://localhost:8081/project-data/getProjectById/$mapVendorId';
    
    Uri url = Uri.parse(baseUrl);
    print("Fetching data from: $url");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        print("API Response: $decodedResponse");

        setState(() {
          allProjectsList = decodedResponse is List ? decodedResponse : [decodedResponse];
          vendorDataList = List.from(allProjectsList); // Initialize display list
          isLoading = false;
        });
      } else {
        print("Error: Failed to load vendor data. Status Code: ${response.statusCode}");
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

  void filterProjectsByStatus(String status) {
    setState(() {
      selectedStatus = status;
      if (status.isEmpty) {
        vendorDataList = List.from(allProjectsList); // Reset to full list
      } else {
        vendorDataList = allProjectsList.where((project) =>
            project['completionStatus']?.toLowerCase() == status.toLowerCase()
        ).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Projects'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              filterProjectsByStatus(value);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: '',
                child: Text('All Projects'),
              ),
              PopupMenuItem<String>(
                value: 'Pending',
                child: Text('Pending'),
              ),
              PopupMenuItem<String>(
                value: 'Completed',
                child: Text('Completed'),
              ),
              PopupMenuItem<String>(
                value: 'Cancelled',
                child: Text('Cancelled'),
              ),
            ],
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              print("User logged out");
            },
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
                      final status = data['completionStatus'] ?? 'Unknown';
                      final statusColor = getStatusColor(status);

                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            'Application No: ${data['applicationNo']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Customer Name: ${data['customerName'] ?? 'N/A'}'),
                              Text('City: ${data['city'] ?? 'N/A'}'),
                              Text('District: ${data['district'] ?? 'N/A'}'),
                              Text('Zone: ${data['zone'] ?? 'N/A'}'),
                              Row(
                                children: [
                                  Text('Status: ', style: TextStyle(fontSize: 16)),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectDetailsPage(projectData: data),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'My Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Account',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          }
        },
      ),
    );
  }
}

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
      return Colors.green;
    case 'cancelled':
      return Colors.red;
    case 'pending':
      return Colors.grey;
    default:
      return Colors.black;
  }
}