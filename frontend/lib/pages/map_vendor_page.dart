// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class MapVendorPage extends StatefulWidget {
//   final Map<String, dynamic> userDetails;

//   const MapVendorPage({super.key, required this.userDetails});

//   @override
//   _MapVendorPageState createState() => _MapVendorPageState();
// }

// class _MapVendorPageState extends State<MapVendorPage> {
//   List<dynamic> projectData = [];
//   bool isLoading = true;
//   String errorMessage = '';

//   @override
//   // void initState()
//     super.initState();
//     fetchProjectData();
//   }

//   Future<void> fetchProjectData() async {
//     final String vendorNumber = widget.userDetails['vendorNumber'] ?? '';

//     if (vendorNumber.isEmpty) {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Vendor number is missing.';
//       });
//       return;
//     }

//     final String apiUrl = 'http://localhost:8081/getProjectData/$vendorNumber';

//     try {
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           projectData = data is List ? data : [data];
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           errorMessage = 'Failed to load data. Status: ${response.statusCode}';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error fetching data: $e';
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map Vendor Page'),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//               ? Center(child: Text(errorMessage, style: const TextStyle(color: Colors.red)))
//               : ListView.builder(
//                   padding: const EdgeInsets.all(10),
//                   itemCount: projectData.length,
//                   itemBuilder: (context, index) {
//                     final item = projectData[index];
//                     return Card(
//                       elevation: 3,
//                       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//                       child: ListTile(
//                         title: Text('Application No: ${item['applicationNo']}'),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Customer: ${item['customerName'] ?? 'N/A'}'),
//                             Text('Address: ${item['customerAddress'] ?? 'N/A'}'),
//                             Text('Telephone: ${item['customerTelephone'] ?? 'N/A'}'),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapVendorPage extends StatefulWidget {
  final String mapVendorId;
  final String accessToken;

  const MapVendorPage(
      {super.key, required this.mapVendorId, required this.accessToken});

  @override
  _MapVendorPageState createState() => _MapVendorPageState();
}

class _MapVendorPageState extends State<MapVendorPage> {
  List<dynamic> vendorDataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVendorData();
  }

Future<void> fetchVendorData() async {
  final url = Uri.parse('http://localhost:8081/getProjectById/${widget.mapVendorId}');
  
  print("Final URL: $url"); // Print URL to debug

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${widget.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body); // Decode JSON response

      print("API Response: $decodedResponse"); // Debugging

      // Check if the response is a map (single object)
      if (decodedResponse is Map<String, dynamic>) {
        setState(() {
          vendorDataList = [decodedResponse]; // Wrap single object in a list
          isLoading = false;
        });
      } else if (decodedResponse is List) {
        // If the response is already a list, assign it directly
        setState(() {
          vendorDataList = decodedResponse;
          isLoading = false;
        });
      } else {
        throw Exception("Unexpected response format.");
      }
    } else {
      throw Exception('Failed to load vendor data. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    print("Error: $e");
    setState(() {
      isLoading = false;
    });
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vendor Data')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : vendorDataList.isEmpty
              ? Center(
                  child: Text(
                      "No data found for Map Vendor ID: ${widget.mapVendorId}"))
              : ListView.builder(
                  itemCount: vendorDataList.length,
                  itemBuilder: (context, index) {
                    final data = vendorDataList[index];
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Application No: ${data['applicationNo']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Map Vendor ID: ${data['mapVendorId']}'),
                            Text('Map No: ${data['mapNo']}'),
                            Text('City: ${data['city']}'),
                            Text('District: ${data['district']}'),
                            Text('Zone: ${data['zone']}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
