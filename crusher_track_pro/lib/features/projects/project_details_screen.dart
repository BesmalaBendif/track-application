import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/app_drawer.dart';
import 'edit_project_screen.dart';
import '../../models/project.dart';
import '../../providers/project_provider.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final int projectId;

  const ProjectDetailsScreen({
    super.key,
    required this.projectId,
  });

  @override
  State<ProjectDetailsScreen> createState() =>
      _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState
    extends State<ProjectDetailsScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ProjectProvider>()
          .loadProject(widget.projectId);
    });
  }

  Future<void> _refresh() async {
    await context
        .read<ProjectProvider>()
        .loadProject(widget.projectId);
  }

  Future<void> _delete(Project project) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Project"),
        content: Text(
          "Delete '${project.name}'?\n\nThis action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () =>
                Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final provider =
        context.read<ProjectProvider>();

    final success =
        await provider.deleteProject(project.id!);

    if (!mounted) return;

    if (success) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content:
              Text("Project deleted successfully."),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            provider.error ??
                "Unable to delete project.",
          ),
        ),
      );
    }
  }

  Future<void> _edit(Project project) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            EditProjectScreen(project: project),
      ),
    );

    if (!mounted) return;

    await context
        .read<ProjectProvider>()
        .loadProject(widget.projectId);
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return Colors.green;

      case "on hold":
        return Colors.orange;

      default:
        return Colors.blue;
    }
  }

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            child: Icon(icon, size: 20),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectProvider>(
      builder: (context, provider, child) {
        final project = provider.selectedProject;

        return Scaffold(
          drawer: const AppDrawer(),

          appBar: AppBar(
            title: const Text("Project Details"),
            centerTitle: false,
          ),

          body: RefreshIndicator(
            onRefresh: _refresh,
            child: Builder(
              builder: (_) {
                if (provider.isLoading && project == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (provider.error != null && project == null) {
                  return ListView(
                    children: [
                      const SizedBox(height: 150),

                      const Icon(
                        Icons.error_outline,
                        size: 80,
                        color: Colors.red,
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Text(
                            provider.error!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Center(
                        child: FilledButton.icon(
                          onPressed: () =>
                              provider.loadProject(widget.projectId),
                          icon: const Icon(Icons.refresh),
                          label: const Text("Retry"),
                        ),
                      ),
                    ],
                  );
                }

                if (project == null) {
                  return ListView(
                    children: const [
                      SizedBox(height: 180),
                      Icon(
                        Icons.folder_off_outlined,
                        size: 90,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "Project not found",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  );
                }

                return ListView(
                  padding: const EdgeInsets.all(18),
                  children: [

                    /// Header
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(22),
                        child: Column(
                          children: [

                            CircleAvatar(
                              radius: 34,
                              backgroundColor:
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                              child: const Icon(
                                Icons.business_center,
                                size: 34,
                              ),
                            ),

                            const SizedBox(height: 16),

                            Text(
                              project.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              project.client,
                              style: TextStyle(
                                color:
                                    Colors.grey.shade700,
                              ),
                            ),

                            const SizedBox(height: 18),

                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: _statusColor(
                                        project.status)
                                    .withOpacity(.15),
                                borderRadius:
                                    BorderRadius.circular(
                                        25),
                              ),
                              child: Text(
                                project.status,
                                style: TextStyle(
                                  color: _statusColor(
                                      project.status),
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    _sectionTitle("Project Information"),

                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(20),
                        child: Column(
                          children: [

                            _infoTile(
                              icon: Icons.person_outline,
                              title: "Client",
                              value: project.client,
                            ),

                            _infoTile(
                              icon:
                                  Icons.location_on_outlined,
                              title: "Location",
                              value: project.location,
                            ),

                            _infoTile(
                              icon:
                                  Icons.calendar_today_outlined,
                              title: "Start Date",
                              value:
                                  project.formattedStartDate,
                            ),

                            _infoTile(
                              icon: Icons.event,
                              title: "End Date",
                              value:
                                  project.formattedEndDate,
                            ),

                            _infoTile(
                              icon:
                                  Icons.access_time_outlined,
                              title: "Created",
                              value:
                                  project.formattedCreatedAt,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    _sectionTitle("Description"),

                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(20),
                        child: Text(
                          (project.description == null ||
                                  project.description!
                                      .trim()
                                      .isEmpty)
                              ? "No description available."
                              : project.description!,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                                        _sectionTitle("Project Dashboard"),

                    GridView.count(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.35,
                      children: const [
                        _StatCard(
                          title: "Machines",
                          value: "0",
                          icon: Icons.precision_manufacturing,
                          color: Colors.blue,
                        ),
                        _StatCard(
                          title: "Employees",
                          value: "0",
                          icon: Icons.people,
                          color: Colors.green,
                        ),
                        _StatCard(
                          title: "Production",
                          value: "0 T",
                          icon: Icons.factory_outlined,
                          color: Colors.orange,
                        ),
                        _StatCard(
                          title: "Fuel Logs",
                          value: "0",
                          icon: Icons.local_gas_station,
                          color: Colors.red,
                        ),
                        _StatCard(
                          title: "Maintenance",
                          value: "0",
                          icon: Icons.build_circle_outlined,
                          color: Colors.purple,
                        ),
                        _StatCard(
                          title: "Attendance",
                          value: "0",
                          icon: Icons.fact_check_outlined,
                          color: Colors.teal,
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    _sectionTitle("Quick Actions"),

                    FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Machines module coming next.",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.precision_manufacturing),
                      label: const Text("Manage Machines"),
                    ),

                    const SizedBox(height: 12),

                    FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Employees module coming next.",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.people),
                      label: const Text("Manage Employees"),
                    ),

                    const SizedBox(height: 12),

                    FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Production module coming next.",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.factory_outlined),
                      label: const Text("Production"),
                    ),

                    const SizedBox(height: 12),

                    FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Fuel module coming next.",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.local_gas_station),
                      label: const Text("Fuel Logs"),
                    ),

                    const SizedBox(height: 12),

                    FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Maintenance module coming next.",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.build),
                      label: const Text("Maintenance"),
                    ),

                    const SizedBox(height: 12),

                    FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Attendance module coming next.",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.fact_check),
                      label: const Text("Attendance"),
                    ),

                    const SizedBox(height: 28),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.edit),
                            label: const Text("Edit"),
                            onPressed: () => _edit(project),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            icon: const Icon(Icons.delete),
                            label: const Text("Delete"),
                            onPressed: () => _delete(project),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor:
                  color.withOpacity(.15),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const Spacer(),

            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}