class EmployeeModel {
  String? id;
  String? name;
  String? email;
  int? departmentId;
  String? departmentName;
  String? createdAt;

  EmployeeModel({
    this.id,
    this.name,
    this.email,
    this.departmentId,
    this.departmentName,
    this.createdAt,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Not Found',
      email: json['email']?.toString() ?? 'Not Found',
      departmentId: json['department_id'] ?? json['departmentId'] ?? 0,
      departmentName: json['department_name'] ??
          json['departments']?['title'] ??
          json['departments']?['title'] ??
          'No Department',
      createdAt: json['created_at']?.toString() ?? 'Not Found',
    );
  }

  @override
  String toString() {
    return 'EmployeeModel{id: $id, name: $name, email: $email, '
        'departmentId: $departmentId, departmentName: $departmentName, '
        'createdAt: $createdAt}';
  }
}
