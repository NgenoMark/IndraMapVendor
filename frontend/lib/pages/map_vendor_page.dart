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
  int _currentIndex = 1;
  List<dynamic> _allProjects = [];
  List<dynamic> _filteredProjects = [];
  bool _isLoading = true;
  bool _hasError = false;
  final String _mapVendorId = "VM012";
  final String _accessToken = "your_access_token";
  String _selectedStatus = '';
  String _searchQuery = '';
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    try {
      setState(() => _isLoading = true);
      
      final response = await http.get(
        Uri.parse('http://localhost:8081/project-data/getProjectById/$_mapVendorId'),
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _allProjects = data is List ? data : [data];
          _filteredProjects = List.from(_allProjects);
          _isLoading = false;
          _hasError = false;
        });
      } else {
        throw Exception('Failed to load projects');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      _showErrorSnackbar('Failed to load projects: $e');
    }
  }

  void _filterProjects() {
    setState(() {
      _filteredProjects = _allProjects.where((project) {
        final statusMatch = _selectedStatus.isEmpty || 
            (project['completionStatus']?.toString().toLowerCase() == _selectedStatus.toLowerCase());
        final searchMatch = _searchQuery.isEmpty ||
            project.values.any((value) => 
                value.toString().toLowerCase().contains(_searchQuery.toLowerCase()));
        return statusMatch && searchMatch;
      }).toList();
    });
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: _loadProjects,
        ),
      ),
    );
  }

  // Future<void> _navigateToProjectDetails(BuildContext context, dynamic projectData) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ProjectDetailsPage(projectData: projectData),
  //     ),
  //   );

  //   // This is the key part that ensures refresh when returning from edit
  //   if (result == true) {
  //     _refreshIndicatorKey.currentState?.show();
  //     await _loadProjects();
  //   }
  // }

  // In MapVendorPage's _navigateToProjectDetails method:
Future<void> _navigateToProjectDetails(BuildContext context, dynamic projectData) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProjectDetailsPage(projectData: projectData),
    ),
  );

  if (result == true) {
    // Refresh the project list
    await _loadProjects();
  }
}

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;
    
    setState(() => _currentIndex = index);
    if (index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Dashboard()));
    } else if (index == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfilePage()));
    }
  }

  Widget _buildProjectCard(dynamic project) {
    final status = project['completionStatus']?.toString() ?? 'Unknown';
    final statusColor = _getStatusColor(status);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => _navigateToProjectDetails(context, project),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    project['applicationNo'] ?? 'N/A',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildDetailRow('Customer:', project['customerName']),
              _buildDetailRow('Location:', '${project['city']}, ${project['district']}'),
              _buildDetailRow('Zone:', project['zone']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'Not available',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search projects...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
        onChanged: (value) {
          setState(() => _searchQuery = value);
          _filterProjects();
        },
      ),
    );
  }

  Widget _buildStatusFilter() {
    const statuses = ['All', 'Pending', 'Completed', 'Cancelled'];
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: statuses.map((status) {
          final isSelected = (status == 'All' && _selectedStatus.isEmpty) || 
              _selectedStatus.toLowerCase() == status.toLowerCase();
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(status),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  _selectedStatus = status == 'All' ? '' : status;
                  _filterProjects();
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty && _selectedStatus.isEmpty
                ? 'No projects available'
                : 'No matching projects',
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
          if (_searchQuery.isNotEmpty || _selectedStatus.isNotEmpty)
            TextButton(
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                  _selectedStatus = '';
                  _filterProjects();
                });
              },
              child: const Text('Clear filters'),
            ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text('Failed to load projects', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _loadProjects,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildProjectList() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: _filteredProjects.length,
      itemBuilder: (context, index) => _buildProjectCard(_filteredProjects[index]),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed': return Colors.green.shade600;
      case 'cancelled': return Colors.red.shade600;
      case 'pending': return Colors.orange.shade600;
      default: return Colors.grey.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _refreshIndicatorKey.currentState?.show(),
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _loadProjects,
        child: _isLoading
            ? _buildLoadingState()
            : _hasError
                ? _buildErrorState()
                : _filteredProjects.isEmpty
                    ? _buildEmptyState()
                    : Column(
                        children: [
                          _buildSearchField(),
                          _buildStatusFilter(),
                          Expanded(child: _buildProjectList()),
                        ],
                      ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}