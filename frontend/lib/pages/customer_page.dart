import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home: CustomerPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  int _selectedIndex = 0;
  final List<Map<String, String>> _projects = []; // List to store projects

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _deleteProject(int index) {
    setState(() {
      _projects.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Project deleted successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Projects"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProjectSearch(_projects),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("My Projects"),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              }, 
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Create Project"),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0
          ? HomeScreen(projects: _projects, onDelete: _deleteProject)
          : CreateProjectScreen(
              onProjectCreated: (project) {
                setState(() {
                  _projects.add(project);
                });
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Create Project",
          ),
        ],
      ),
    );
  }
}

// Home Screen with delete functionality
class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> projects;
  final Function(int) onDelete;

  const HomeScreen({super.key, required this.projects, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return projects.isEmpty
        ? Center(
            child: Text(
              "No projects yet. Add some projects!",
              style: TextStyle(fontSize: 18),
            ),
          )
        :  ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(project['title'] ?? ""),
                  subtitle: Text(
                      "Due: ${project['date']} at ${project['time']}\n${project['description']}"),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      onDelete(index);
                    },
                  ),
                ),
              );
            },
          );
  }
}

// Create Project Screen
class CreateProjectScreen extends StatefulWidget {
  final Function(Map<String, String>) onProjectCreated;

  const CreateProjectScreen({super.key, required this.onProjectCreated});

  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create a Project",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          

            
              SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Project Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a project title";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Project Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please provide a description for the project";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Completion Date",
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text =
                          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                    });
                  }
                },
                readOnly: true,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: "Completion Time",
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _timeController.text = pickedTime.format(context);
                    });
                  }
                },
                readOnly: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onProjectCreated({
                      "title": _titleController.text,
                      "date": _dateController.text,
                      "time": _timeController.text,
                      "description": _descriptionController.text,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Project Created Successfully")),
                    );
                    _formKey.currentState?.reset();
                    _titleController.clear();
                    _dateController.clear();
                    _timeController.clear();
                    _descriptionController.clear();
                  }
                },
                child: Text("Create Project"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Creating a Logout Button and back button 

// Search Delegate
class ProjectSearch extends SearchDelegate<String> {
  final List<Map<String, String>> projects;

  ProjectSearch(this.projects);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = projects
        .where((project) =>
            project['title']!.toLowerCase().contains(query.toLowerCase()) ||
            project['description']!
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();

    return results.isEmpty
        ? Center(child: Text("No results found"))
        : ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final project = results[index];
              return ListTile(
                title: Text(project['title'] ?? ""),
                subtitle: Text(project['description'] ?? ""),
              );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = projects
        .where((project) =>
            project['title']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final project = suggestions[index];
        return ListTile(
          title: Text(project['title'] ?? ""),
          onTap: () {
            query = project['title']!;
            showResults(context);
          },
        );
      },
    );
  }
}
