import 'package:flutter/material.dart';
import 'project_form.dart';

void main() {
  runApp(const ArchitectureProjectManagerApp());
}

class ArchitectureProjectManagerApp extends StatelessWidget {
  const ArchitectureProjectManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Architecture Project Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ProjectListScreen(),
    );
  }
}

class Project {
  final String id;
  final String name;
  final String location;
  final String fileNumber;
  final String description;
  final String status;

  Project({
    required this.id,
    required this.name,
    required this.location,
    required this.fileNumber,
    this.description = '',
    this.status = 'Active',
  });
}

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  final List<Project> _projects = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<Project> get _filteredProjects {
    if (_searchQuery.isEmpty) return _projects;
    return _projects.where((project) {
      return project.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             project.location.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             project.fileNumber.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _addProject(Project project) {
    setState(() {
      _projects.add(project);
    });
  }

  void _navigateToAddProject() async {
    final newProject = await Navigator.push<Project>(
      context,
      MaterialPageRoute(builder: (context) => ProjectFormScreen()),
    );
    if (newProject != null) {
      _addProject(newProject);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Architecture Projects'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search by Name, Location, or File Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: _filteredProjects.isEmpty
                ? const Center(child: Text('No projects found. Add one below!'))
                : ListView.builder(
                    itemCount: _filteredProjects.length,
                    itemBuilder: (context, index) {
                      final project = _filteredProjects[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(project.name),
                          subtitle: Text('Location: ${project.location}\nFile Number: ${project.fileNumber}\nStatus: ${project.status}'),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddProject,
        tooltip: 'Add Project',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}