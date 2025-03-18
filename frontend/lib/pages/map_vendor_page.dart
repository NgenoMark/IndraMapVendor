// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class MapVendorPage extends StatefulWidget {
//   @override
//   _MapVendorPageState createState() => _MapVendorPageState();
// }

// class _MapVendorPageState extends State<MapVendorPage> {
//   List<dynamic> vendorDataList = [];
//   bool isLoading = true;
//   bool isError = false;
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
//         isError = true;
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
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Application No: ${data['applicationNo'] ?? "N/A"}'),
//                 Text('Customer Name: ${data['customerName'] ?? "N/A"}'),
//                 Text('Customer Address: ${data['customerAddress'] ?? "N/A"}'),
//                 Text('Customer Telephone: ${data['Telephone'] ?? "N/A"}'),
//                 Text('Customer Email: ${data['customerEmail'] ?? "N/A"}'),
//                 Text('City: ${data['city'] ?? "N/A"}'),
//                 Text('District: ${data['district'] ?? "N/A"}'),
//                 Text('Zone: ${data['zone'] ?? "N/A"}'),
//                 Text('Map Vendor ID: ${data['mapVendorId'] ?? "N/A"}'),
//                 Text('Map No: ${data['mapNo'] ?? "N/A"}'),
//               ],
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

//   Widget _buildProjectList() {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (isError) {
//       return Center(child: Text('Failed to load data. Please try again later.'));
//     }

//     if (vendorDataList.isEmpty) {
//       return Center(child: Text('No projects available.'));
//     }

//     return ListView.builder(
//       itemCount: vendorDataList.length,
//       itemBuilder: (context, index) {
//         final data = vendorDataList[index];
//         return Card(
//           child: ListTile(
//             title: Text(data['mapNo'] ?? 'No Map No'),
//             subtitle: Text('Status: ${data['status'] ?? 'Unknown'}\n'
//                 '${getStatusStars(data['status'] ?? 'Unknown')}'),
//             trailing: Icon(Icons.arrow_forward),
//             onTap: () => _showDescriptionDialog(context, data),
//           ),
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
//         leading: IconButton(
//           icon: Icon(Icons.home),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => MapVendorPage()),
//             );
//           },
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
//           PopupMenuButton<String>(
//             onSelected: (String result) {
//               print("Selected: $result");
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
//       body: _buildProjectList(),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: MapVendorPage(),
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//     ),
//   ));
// }





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









import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'payment.dart';
import 'package:intl/intl.dart'; // Import this at the top

class MapVendorPage extends StatefulWidget {

  final String mapVendorId;
  final String accessToken;

  // final String mapVendorId = "VM012"; // Hardcoded for independent execution
  // final String accessToken ="your_access_token"; // Replace with actual token if needed


  const MapVendorPage({Key? key, required this.mapVendorId, required this.accessToken}) : super(key: key);


  @override
  _MapVendorPageState createState() => _MapVendorPageState();
}

class _MapVendorPageState extends State<MapVendorPage> {
  List<dynamic> vendorDataList = [];
  bool isLoading = true;
  //final String mapVendorId = "VM012"; // Hardcoded for independent execution
  //final String accessToken ="your_access_token"; // Replace with actual token if needed

  @override
  void initState() {
    super.initState();
    fetchVendorData();
  }

  Future<void> fetchVendorData() async {
    final url = Uri.parse('http://localhost:8081/getProjectById/${widget.mapVendorId}');
    //final url = Uri.parse('http://localhost:8081/getProjectById/$mapVendorId');
    print("Fetching data from: $url");

    try {
      final response = await http.get(
        url,  
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          //'Authorization': 'Bearer $accessToken',
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
    //home: MapVendorPage(),
    home: MapVendorPage(mapVendorId: '', accessToken: '',),
  ));
}




