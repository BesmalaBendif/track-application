import 'package:flutter/material.dart';

import '../models/project.dart';
import '../services/project_service.dart';

class ProjectProvider extends ChangeNotifier {
  final List<Project> _projects = [];

  List<Project> _filteredProjects = [];

  Project? _selectedProject;

  bool _isLoading = false;

  String? _error;

  String _searchQuery = '';

  // ===========================
  // Getters
  // ===========================

  List<Project> get projects => _filteredProjects;

  Project? get selectedProject => _selectedProject;

  bool get isLoading => _isLoading;

  String? get error => _error;

  String get searchQuery => _searchQuery;

  // ===========================
  // Load Projects
  // ===========================

  Future<void> loadProjects() async {
    _setLoading(true);

    try {
      final data = await ProjectService.getProjects();

      _projects
        ..clear()
        ..addAll(data);

      _applySearch();

      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _setLoading(false);
  }

  // ===========================
  // Refresh
  // ===========================

  Future<void> refresh() async {
    await loadProjects();
  }

  // ===========================
  // Load Single Project
  // ===========================

  Future<void> loadProject(int id) async {
    _setLoading(true);

    try {
      _selectedProject = await ProjectService.getProject(id);

      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _setLoading(false);
  }

  // ===========================
  // Add Project
  // ===========================

  Future<bool> addProject(Project project) async {
    _setLoading(true);

    try {
      final created = await ProjectService.createProject(project);

      _projects.insert(0, created);

      _applySearch();

      _error = null;

      _setLoading(false);

      return true;
    } catch (e) {
      _error = e.toString();

      _setLoading(false);

      return false;
    }
  }

  // ===========================
  // Update Project
  // ===========================

  Future<bool> updateProject(Project project) async {
    _setLoading(true);

    try {
      final updated = await ProjectService.updateProject(project);

      final index =
          _projects.indexWhere((element) => element.id == updated.id);

      if (index != -1) {
        _projects[index] = updated;
      }

      _selectedProject = updated;

      _applySearch();

      _error = null;

      _setLoading(false);

      return true;
    } catch (e) {
      _error = e.toString();

      _setLoading(false);

      return false;
    }
  }

  // ===========================
  // Delete Project
  // ===========================

  Future<bool> deleteProject(int id) async {
    _setLoading(true);

    try {
      await ProjectService.deleteProject(id);

      _projects.removeWhere((e) => e.id == id);

      if (_selectedProject?.id == id) {
        _selectedProject = null;
      }

      _applySearch();

      _error = null;

      _setLoading(false);

      return true;
    } catch (e) {
      _error = e.toString();

      _setLoading(false);

      return false;
    }
  }

  // ===========================
  // Search
  // ===========================

  void search(String value) {
    _searchQuery = value;

    _applySearch();

    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';

    _applySearch();

    notifyListeners();
  }

  void _applySearch() {
    if (_searchQuery.trim().isEmpty) {
      _filteredProjects = List.from(_projects);
      return;
    }

    final query = _searchQuery.toLowerCase();

    _filteredProjects = _projects.where((project) {
      return project.name.toLowerCase().contains(query) ||
          project.client.toLowerCase().contains(query) ||
          project.location.toLowerCase().contains(query) ||
          project.status.toLowerCase().contains(query);
    }).toList();
  }

  // ===========================
  // Helpers
  // ===========================

  void clearError() {
    _error = null;

    notifyListeners();
  }

  void clearSelectedProject() {
    _selectedProject = null;

    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;

    notifyListeners();
  }
}