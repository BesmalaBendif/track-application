import 'package:flutter/material.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() =>
      _AddProjectScreenState();
}

class _AddProjectScreenState
    extends State<AddProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController projectNameController =
      TextEditingController();

  final TextEditingController locationController =
      TextEditingController();

  final TextEditingController clientController =
      TextEditingController();

  final TextEditingController budgetController =
      TextEditingController();

  String? selectedCrusher;
  String? selectedStatus;

  final List<String> crushers = [
    "Crusher A",
    "Crusher B",
    "Crusher C",
    "Crusher D",
  ];

  final List<String> statuses = [
    "Active",
    "Paused",
    "Completed",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Project"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              TextFormField(
                controller: projectNameController,

                decoration: const InputDecoration(
                  labelText: "Project Name",
                  prefixIcon:
                      Icon(Icons.business_center),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter project name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: locationController,

                decoration: const InputDecoration(
                  labelText: "Location",
                  prefixIcon:
                      Icon(Icons.location_on),
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: clientController,

                decoration: const InputDecoration(
                  labelText: "Client Name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: selectedCrusher,

                decoration: const InputDecoration(
                  labelText: "Assigned Crusher",
                  prefixIcon: Icon(
                    Icons.precision_manufacturing,
                  ),
                ),

                items: crushers.map((crusher) {
                  return DropdownMenuItem(
                    value: crusher,
                    child: Text(crusher),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedCrusher = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: selectedStatus,

                decoration: const InputDecoration(
                  labelText: "Project Status",
                  prefixIcon:
                      Icon(Icons.flag_outlined),
                ),

                items: statuses.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: budgetController,
                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                  labelText: "Budget (DZD)",
                  prefixIcon: Icon(Icons.payments),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!
                        .validate()) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Project added successfully",
                          ),
                        ),
                      );

                      Navigator.pop(context);
                    }
                  },

                  icon: const Icon(Icons.save),

                  label: const Text(
                    "Save Project",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}