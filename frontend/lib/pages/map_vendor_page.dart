import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'project_details_page.dart';
import 'dashboard.dart';
import 'profile_page.dart';

class MapVendorPage extends StatefulWidget {

  final String mapVendorNumber;
  final String accessToken;
  final Map<String, dynamic> userDetails;


  const MapVendorPage({
    Key? key,
    required this.mapVendorNumber,
    required this.accessToken,
    required this.userDetails,
  }) : super(key: key);


  @override
  _MapVendorPageState createState() => _MapVendorPageState();
}

class _MapVendorPageState extends State<MapVendorPage> {
  int _currentIndex = 1;
  List<dynamic> _allProjects = [];
  List<dynamic> _filteredProjects = [];
  bool _isLoading = true;
  bool _hasError = false;
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
        Uri.parse('http://localhost:8081/project-data/getProjectById/${widget.mapVendorNumber}'),
        headers: {
         'Authorization': 'Bearer ${widget.accessToken}',
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Dashboard(
            mapVendorNumber: widget.mapVendorNumber,
            accessToken: widget.accessToken,
            userDetails: widget.userDetails,
          ),
        ),
      );

    } else if (index == 2) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ProfilePage(
            mapVendorNumber: widget.mapVendorNumber,
            accessToken: widget.accessToken,
            userDetails: widget.userDetails,
          ),
        ),
      );

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
        backgroundColor: Colors.blue,
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