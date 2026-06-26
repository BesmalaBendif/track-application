import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/project.dart';
import '../../providers/project_provider.dart';

class EditProjectScreen extends StatefulWidget {
  final Project project;

  const EditProjectScreen({
    super.key,
    required this.project,
  });

  @override
  State<EditProjectScreen> createState() =>
      _EditProjectScreenState();
}

class _EditProjectScreenState
    extends State<EditProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _clientController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;

  late DateTime _startDate;
  DateTime? _endDate;

  late String _status;

  bool _saving = false;

  final List<String> _statuses = const [
    "Active",
    "Completed",
    "On Hold",
  ];

  @override
  void initState() {
    super.initState();

    _nameController =
        TextEditingController(text: widget.project.name);

    _clientController =
        TextEditingController(text: widget.project.client);

    _locationController =
        TextEditingController(text: widget.project.location);

    _descriptionController =
        TextEditingController(
      text: widget.project.description ?? "",
    );

    _status = widget.project.status;

    _startDate = widget.project.startDate;

    _endDate = widget.project.endDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _clientController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked;

        if (_endDate != null &&
            _endDate!.isBefore(_startDate)) {
          _endDate = null;
        }
      });
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          _endDate ?? _startDate,
      firstDate: _startDate,
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _saving = true;
    });

    final updated = widget.project.copyWith(
      name: _nameController.text.trim(),
      client: _clientController.text.trim(),
      location: _locationController.text.trim(),
      description:
          _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
      status: _status,
      startDate: _startDate,
      endDate: _endDate,
    );

    final provider =
        Provider.of<ProjectProvider>(
      context,
      listen: false,
    );

    final success =
        await provider.updateProject(updated);

    setState(() {
      _saving = false;
    });

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content:
              Text("Project updated successfully."),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            provider.error ??
                "Unable to update project.",
          ),
        ),
      );
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Project"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 700,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Update Project",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                        ),

                        const SizedBox(height: 24),

                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: "Project Name",
                            prefixIcon: Icon(
                              Icons.business_center,
                            ),
                            border:
                                OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return "Project name is required";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        TextFormField(
                          controller: _clientController,
                          decoration: const InputDecoration(
                            labelText: "Client",
                            prefixIcon: Icon(
                              Icons.person_outline,
                            ),
                            border:
                                OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return "Client is required";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        TextFormField(
                          controller:
                              _locationController,
                          decoration: const InputDecoration(
                            labelText: "Location",
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                            ),
                            border:
                                OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return "Location is required";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        TextFormField(
                          controller:
                              _descriptionController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: "Description",
                            alignLabelWithHint: true,
                            prefixIcon:
                                Icon(Icons.description),
                            border:
                                OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 20),

                        DropdownButtonFormField<String>(
                          value: _status,
                          decoration:
                              const InputDecoration(
                            labelText: "Status",
                            prefixIcon: Icon(
                              Icons.flag_outlined,
                            ),
                            border:
                                OutlineInputBorder(),
                          ),
                          items: _statuses
                              .map(
                                (status) =>
                                    DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _status = value;
                              });
                            }
                          },
                        ),

                        const SizedBox(height: 20),

                        InkWell(
                          onTap: _pickStartDate,
                          child: InputDecorator(
                            decoration:
                                const InputDecoration(
                              labelText:
                                  "Start Date",
                              prefixIcon: Icon(
                                Icons.calendar_today,
                              ),
                              border:
                                  OutlineInputBorder(),
                            ),
                            child: Text(
                              _formatDate(_startDate),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        InkWell(
                          onTap: _pickEndDate,
                          child: InputDecorator(
                            decoration:
                                const InputDecoration(
                              labelText: "End Date",
                              prefixIcon:
                                  Icon(Icons.event),
                              border:
                                  OutlineInputBorder(),
                            ),
                            child: Text(
                              _endDate == null
                                  ? "Select end date (Optional)"
                                  : _formatDate(
                                      _endDate!,
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton.icon(
                            onPressed: _saving
                                ? null
                                : _saveChanges,
                            icon:
                                const Icon(Icons.save),
                            label: const Text(
                              "Update Project",
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton.icon(
                            onPressed: _saving
                                ? null
                                : () =>
                                    Navigator.pop(
                                      context,
                                    ),
                            icon:
                                const Icon(Icons.close),
                            label:
                                const Text("Cancel"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          if (_saving)
            Container(
              color: Colors.black26,
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child:
                        CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}