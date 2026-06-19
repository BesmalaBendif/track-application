import 'package:flutter/material.dart';
import '../../core/widgets/app_drawer.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text("Projects"),

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // Add Project Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
  Navigator.pushNamed(
    context,
    '/add-project',
  );
},

                icon: const Icon(Icons.add),

                label: const Text(
                  "Add New Project",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 56, 79, 129),
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search projects...",
                prefixIcon: const Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Projects List
            Expanded(
              child: ListView(
                children: const [
                  ProjectCard(
                    projectName: "Highway East Section",
                    location: "Setif",
                    crusher: "Crusher A",
                    status: "Active",
                    progress: 0.75,
                  ),

                  SizedBox(height: 15),

                  ProjectCard(
                    projectName: "Airport Expansion",
                    location: "Algiers",
                    crusher: "Crusher B",
                    status: "Completed",
                    progress: 1.0,
                  ),

                  SizedBox(height: 15),

                  ProjectCard(
                    projectName: "Industrial Zone",
                    location: "Oran",
                    crusher: "Crusher C",
                    status: "Paused",
                    progress: 0.40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String projectName;
  final String location;
  final String crusher;
  final String status;
  final double progress;

  const ProjectCard({
    super.key,
    required this.projectName,
    required this.location,
    required this.crusher,
    required this.status,
    required this.progress,
  });

  Color getStatusColor() {
    switch (status) {
      case "Active":
        return Colors.green;

      case "Completed":
        return Colors.blue;

      case "Paused":
        return Colors.orange;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    projectName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  decoration: BoxDecoration(
                    color: getStatusColor().withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Text(
                    status,
                    style: TextStyle(
                      color: getStatusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: 8),
                Text(location),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.precision_manufacturing),
                const SizedBox(width: 8),
                Text(crusher),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              "Progress ${(progress * 100).toInt()}%",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},

                    icon: const Icon(Icons.visibility),

                    label: const Text("Details"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},

                    icon: const Icon(Icons.edit),

                    label: const Text("Edit"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}