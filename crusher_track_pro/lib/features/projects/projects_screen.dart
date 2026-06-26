import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/project_provider.dart';
import '../../models/project.dart';
import 'add_project_screen.dart';
import 'edit_project_screen.dart';
import 'project_details_screen.dart';
import '../../core/widgets/app_drawer.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectProvider>().loadProjects();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await context.read<ProjectProvider>().refresh();
  }

  void _search(String value) {
    context.read<ProjectProvider>().search(value);
  }

  Future<void> _goToAddProject() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddProjectScreen(),
      ),
    );

    if (!mounted) return;

    await context.read<ProjectProvider>().refresh();
  }

  Future<void> _goToEdit(Project project) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProjectScreen(
          project: project,
        ),
      ),
    );

    if (!mounted) return;

    await context.read<ProjectProvider>().refresh();
  }

  Future<void> _goToDetails(Project project) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProjectDetailsScreen(
          projectId: project.id!,
        ),
      ),
    );

    if (!mounted) return;

    await context.read<ProjectProvider>().refresh();
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            success ? Colors.green : Colors.red,
        content: Text(
          success
              ? "Project deleted successfully."
              : provider.error ??
                  "Failed to delete project.",
        ),
      ),
    );
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
  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          drawer: const AppDrawer(),

          appBar: AppBar(
            title: const Text("Projects"),
            centerTitle: false,
          ),

          floatingActionButton: FloatingActionButton.extended(
            onPressed: _goToAddProject,
            icon: const Icon(Icons.add),
            label: const Text("New Project"),
          ),

          body: RefreshIndicator(
            onRefresh: _refresh,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    10,
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _search,
                    decoration: InputDecoration(
                      hintText: "Search projects...",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                provider.clearSearch();
                                setState(() {});
                              },
                            ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Builder(
                    builder: (_) {
                      if (provider.isLoading &&
                          provider.projects.isEmpty) {
                        return const Center(
                          child:
                              CircularProgressIndicator(),
                        );
                      }

                      if (provider.error != null &&
                          provider.projects.isEmpty) {
                        return Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  size: 70,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  provider.error!,
                                  textAlign:
                                      TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                FilledButton.icon(
                                  onPressed: () {
                                    provider
                                        .loadProjects();
                                  },
                                  icon: const Icon(
                                      Icons.refresh),
                                  label: const Text(
                                      "Retry"),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      if (provider.projects.isEmpty) {
                        return ListView(
                          physics:
                              const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 120),
                            Icon(
                              Icons.business_center_outlined,
                              size: 90,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                "No projects found",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Center(
                              child: Text(
                                "Tap + to create your first project.",
                              ),
                            ),
                          ],
                        );
                      }

                      return ListView.separated(
                        padding:
                            const EdgeInsets.fromLTRB(
                          16,
                          0,
                          16,
                          90,
                        ),
                        physics:
                            const AlwaysScrollableScrollPhysics(),
                        itemCount:
                            provider.projects.length,
                        separatorBuilder:
                            (_, __) =>
                                const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final project =
                              provider.projects[index];

                          return Dismissible(
                            key: ValueKey(project.id),
                            direction:
                                DismissDirection.endToStart,
                            confirmDismiss:
                                (_) async {
                              await _delete(project);
                              return false;
                            },
                            background: Container(
                              alignment:
                                  Alignment.centerRight,
                              padding:
                                  const EdgeInsets.only(
                                      right: 25),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.circular(
                                        18),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: _buildProjectCard(
                              project,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildProjectCard(Project project) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _goToDetails(project),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    child: Icon(Icons.business_center),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          project.client,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(project.status)
                          .withOpacity(.12),
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      project.status,
                      style: TextStyle(
                        color:
                            _statusColor(project.status),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      project.location,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 18,
                  ),
                  const SizedBox(width: 8),

                  Text(project.formattedStartDate),

                  const Text("  →  "),

                  Expanded(
                    child: Text(
                      project.formattedEndDate,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              if (project.description != null &&
                  project.description!.isNotEmpty) ...[
                const SizedBox(height: 16),

                Text(
                  project.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
              ],

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.visibility),
                      label: const Text("Details"),
                      onPressed: () =>
                          _goToDetails(project),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit"),
                      onPressed: () =>
                          _goToEdit(project),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}