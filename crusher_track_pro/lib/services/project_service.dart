import 'package:dio/dio.dart';

import '../../../api/api_client.dart';
import '../models/project.dart';

class ProjectService {
  /// ===========================
  /// Get All Projects
  /// GET /projects
  /// ===========================
  static Future<List<Project>> getProjects() async {
    try {
      final response = await ApiClient.dio.get('/projects');

      final List<dynamic> data = response.data;

      return data
          .map((json) => Project.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Failed to load projects.');
    }
  }

  /// ===========================
  /// Get Project By ID
  /// GET /projects/{id}
  /// ===========================
  static Future<Project> getProject(int id) async {
    try {
      final response = await ApiClient.dio.get('/projects/$id');

      return Project.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Failed to load project.');
    }
  }

  /// ===========================
  /// Create Project
  /// POST /projects
  /// ===========================
  static Future<Project> createProject(Project project) async {
    try {
      final response = await ApiClient.dio.post(
        '/projects',
        data: project.toJson(),
      );

      return Project.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Failed to create project.');
    }
  }

  /// ===========================
  /// Update Project
  /// PUT /projects/{id}
  /// ===========================
  static Future<Project> updateProject(Project project) async {
    if (project.id == null) {
      throw Exception('Project ID cannot be null.');
    }

    try {
      final response = await ApiClient.dio.put(
        '/projects/${project.id}',
        data: project.toJson(),
      );

      return Project.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Failed to update project.');
    }
  }

  /// ===========================
  /// Delete Project
  /// DELETE /projects/{id}
  /// ===========================
  static Future<void> deleteProject(int id) async {
    try {
      await ApiClient.dio.delete('/projects/$id');
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Failed to delete project.');
    }
  }

  /// ===========================
  /// Dio Error Handler
  /// ===========================
  static String _handleDioError(DioException e) {
    if (e.response != null) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        if (data.containsKey('detail')) {
          return data['detail'].toString();
        }

        if (data.containsKey('message')) {
          return data['message'].toString();
        }
      }

      switch (e.response?.statusCode) {
        case 400:
          return 'Bad request.';
        case 401:
          return 'Unauthorized.';
        case 403:
          return 'Forbidden.';
        case 404:
          return 'Project not found.';
        case 409:
          return 'Conflict.';
        case 422:
          return 'Validation error.';
        case 500:
          return 'Internal server error.';
        default:
          return 'Server error (${e.response?.statusCode}).';
      }
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout.';

      case DioExceptionType.sendTimeout:
        return 'Request timeout.';

      case DioExceptionType.receiveTimeout:
        return 'Response timeout.';

      case DioExceptionType.connectionError:
        return 'Unable to connect to the server.';

      case DioExceptionType.badCertificate:
        return 'Invalid server certificate.';

      case DioExceptionType.cancel:
        return 'Request cancelled.';

      case DioExceptionType.unknown:
        return 'Unexpected network error.';

      default:
        return 'Unexpected error.';
    }
  }
}