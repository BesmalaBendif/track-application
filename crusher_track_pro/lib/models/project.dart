import 'package:intl/intl.dart';

class Project {
  final int? id;
  final String name;
  final String client;
  final String location;
  final String? description;
  final String status;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime? createdAt;

  const Project({
    this.id,
    required this.name,
    required this.client,
    required this.location,
    this.description,
    required this.status,
    required this.startDate,
    this.endDate,
    this.createdAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'] ?? '',
      client: json['client'] ?? '',
      location: json['location'] ?? '',
      description: json['description'],
      status: json['status'] ?? 'Active',
      startDate: DateTime.parse(json['start_date']),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'client': client,
      'location': location,
      'description': description,
      'status': status,
      'start_date': _formatDate(startDate),
      'end_date': endDate != null ? _formatDate(endDate!) : null,
    };
  }

  Project copyWith({
    int? id,
    String? name,
    String? client,
    String? location,
    String? description,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      client: client ?? this.client,
      location: location ?? this.location,
      description: description ?? this.description,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String get formattedStartDate {
    return DateFormat('dd MMM yyyy').format(startDate);
  }

  String get formattedEndDate {
    if (endDate == null) return '-';
    return DateFormat('dd MMM yyyy').format(endDate!);
  }

  String get formattedCreatedAt {
    if (createdAt == null) return '-';
    return DateFormat('dd MMM yyyy • HH:mm').format(createdAt!);
  }

  bool get isActive =>
      status.toLowerCase() == 'active';

  bool get isCompleted =>
      status.toLowerCase() == 'completed';

  bool get isOnHold =>
      status.toLowerCase() == 'on hold';

  @override
  String toString() {
    return 'Project('
        'id: $id, '
        'name: $name, '
        'client: $client, '
        'location: $location'
        ')';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          client == other.client &&
          location == other.location &&
          description == other.description &&
          status == other.status &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      client.hashCode ^
      location.hashCode ^
      description.hashCode ^
      status.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      createdAt.hashCode;
}