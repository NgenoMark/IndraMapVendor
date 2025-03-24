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
import 'project_details_page.dart';
import 'dashboard.dart';
import 'profile_page.dart';

class MapVendorPage extends StatefulWidget {
  const MapVendorPage({Key? key}) : super(key: key);

  @override
  _MapVendorPageState createState() => _MapVendorPageState();
}

class _MapVendorPageState extends State<MapVendorPage> {
  int _currentIndex = 1; // Default to "My Projects"
  List<dynamic> allProjectsList = [];
  List<dynamic> vendorDataList = [];
  bool isLoading = true;
  final String mapVendorId = "VM012";
  final String accessToken = "your_access_token";
  String selectedStatus = '';
  String searchQuery = '';

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
          vendorDataList = List.from(allProjectsList);
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

  void filterProjects() {
    setState(() {
      vendorDataList = allProjectsList.where((project) {
        bool matchesStatus = selectedStatus.isEmpty ||
            project['completionStatus']?.toLowerCase() == selectedStatus.toLowerCase();
        bool matchesSearch = searchQuery.isEmpty ||
            project.values.any((value) => value.toString().toLowerCase().contains(searchQuery.toLowerCase()));
        return matchesStatus && matchesSearch;
      }).toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
    // For index 1 (My Projects), we're already here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                              filterProjects();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search projects...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      PopupMenuButton<String>(
                        onSelected: (String value) {
                          setState(() {
                            selectedStatus = value;
                            filterProjects();
                          });
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(value: '', child: Text('All Projects')),
                          const PopupMenuItem<String>(value: 'Pending', child: Text('Pending')),
                          const PopupMenuItem<String>(value: 'Completed', child: Text('Completed')),
                          const PopupMenuItem<String>(value: 'Cancelled', child: Text('Cancelled')),
                        ],
                        icon: const Icon(Icons.filter_list),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: vendorDataList.length,
                    itemBuilder: (context, index) {
                      final data = vendorDataList[index];
                      final status = data['completionStatus'] ?? 'Unknown';
                      final statusColor = getStatusColor(status);

                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Application No:', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(data['applicationNo'] ?? 'N/A', textAlign: TextAlign.right),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Customer Name:', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(data['customerName'] ?? 'N/A', textAlign: TextAlign.right),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('City:', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(data['city'] ?? 'N/A', textAlign: TextAlign.right),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('District:', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(data['district'] ?? 'N/A', textAlign: TextAlign.right),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Zone:', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(data['zone'] ?? 'N/A', textAlign: TextAlign.right),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      status,
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                            // In MapVendorPage's ListView.builder:
                        onTap: () async {
                      final result = await Navigator.push(
                    context,
                  MaterialPageRoute(
                      builder: (context) => ProjectDetailsPage(projectData: data),
                  ),
                );
              if (result == true) {
            fetchVendorData(); // Refresh the data
          }
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
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
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
      ),
    );
  }
}

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'completed': return Colors.green.shade600;
    case 'cancelled': return Colors.red.shade700;
    case 'pending': return Colors.grey.shade800;
    default: return Colors.black;
  }
}