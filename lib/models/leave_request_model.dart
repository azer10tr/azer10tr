class LeaveRequest {
  final String id;
  final String employeeId;
  final DateTime startDate;
  final DateTime endDate;
  final String type;
  final String status;
  final String? comments;

  LeaveRequest({
    required this.id,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.status,
    this.comments,
  });

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      id: json['id'],
      employeeId: json['employee_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      type: json['type'],
      status: json['status'],
      comments: json['comments'],
    );
    
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'type': type,
      'status': status,
      'comments': comments,
    };
  
}
}