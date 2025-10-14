import 'package:flutter/material.dart';
import 'main.dart';

class ProjectFormScreen extends StatefulWidget {
  const ProjectFormScreen({super.key});

  @override
  State<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _fileNumberController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _status = 'Active';

  void _saveProject() {
    if (_formKey.currentState!.validate()) {
      final newProject = Project(
        id: DateTime.now().toString(),
        name: _nameController.text,
        location: _locationController.text,
        fileNumber: _fileNumberController.text,
        description: _descriptionController.text,
        status: _status,
      );
      Navigator.pop(context, newProject);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Project Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) => value!.isEmpty ? 'Please enter a location' : null,
              ),
              TextFormField(
                controller: _fileNumberController,
                decoration: const InputDecoration(labelText: 'File Number'),
                validator: (value) => value!.isEmpty ? 'Please enter a file number' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description (Optional)'),
                maxLines: 3,
              ),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['Active', 'Completed', 'On Hold'].map((status) {
                  return DropdownMenuItem(value: status, child: Text(status));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProject,
                child: const Text('Save Project'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _fileNumberController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}