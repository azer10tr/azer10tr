class AttendanceModel {
  final String id ;
  final String date;
  final String checkIn;
  final String? checkOut;
  final DateTime createdAt;
  final Map? checkOutlocation;
  final Map? checkInlocation;
  AttendanceModel({
    required this.id,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.createdAt,
    this.checkInlocation,
    this.checkOutlocation,
    });

  factory AttendanceModel.fromJson(Map<String, dynamic>data){
    return AttendanceModel(id: data['employee_id'],
    date: data['date'],
    checkIn: data['check_in'],
    checkOut: data['check_out'],
    createdAt: DateTime.parse(data['created_at']),
    checkInlocation: data['check_in_location'],
    checkOutlocation: data['check_out_location'],
    );
  }
}
