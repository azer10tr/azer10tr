import 'package:employee_attendance/constants/constants.dart';
import 'package:employee_attendance/models/attendance_model.dart';
import 'package:employee_attendance/services/location_service.dart';
import 'package:employee_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceService extends ChangeNotifier{
  final SupabaseClient _supabase = Supabase.instance.client;
  AttendanceModel? attendanceModel;
  String todayDate = DateFormat("dd MMMM yyyy").format(DateTime.now());

  bool _isLoading = false;
  bool get isLoading => _isLoading  ;
  set setIsLoading (bool value) {
    _isLoading = value;
    notifyListeners();
}

String  _attendanceHistoryMonth =
  DateFormat('MMMM yyyy').format(DateTime.now());

String get attendanceHistoryMonth => _attendanceHistoryMonth;
set attendanceHistoryMonth(String value){
  _attendanceHistoryMonth = value;
  notifyListeners();
}

Future getTodayAttendance() async {
  final List result = await _supabase
  .from(Constants.attendanceTable)
  .select()
  .eq("employee_id",_supabase.auth.currentUser!.id)
  .eq("date", todayDate);
  if(result.isNotEmpty){
    attendanceModel = AttendanceModel.fromJson(result.first);
  }
  else {
    attendanceModel = null;
  }
  notifyListeners();
}

Future markAttendance(BuildContext context) async {
  Map? getLocation = await LocationService().initializedAndGetLocation(context);

  if (getLocation != null) {
    // Vérifie l'état actuel avant toute insertion ou update
    await getTodayAttendance();

    if (attendanceModel == null) {
      // Aucune ligne pour aujourd'hui → insère une nouvelle
      await _supabase.from(Constants.attendanceTable).insert({
        'employee_id': _supabase.auth.currentUser!.id,
        'date': todayDate,
        'check_in': DateFormat('HH:mm').format(DateTime.now()),
        'check_in_location': getLocation,
      });
    } else if (attendanceModel?.checkOut == null) {
      // Il existe une ligne avec check-in mais pas encore check-out
      await _supabase.from(Constants.attendanceTable).update({
        'check_out': DateFormat('HH:mm').format(DateTime.now()),
        'check_out_location': getLocation,
      })
      .eq('employee_id', _supabase.auth.currentUser!.id)
      .eq('date', todayDate);
    } else {
      Utils.showSnackBar("Vous avez déjà marqué votre check-out aujourd'hui.", context);
    }

    await getTodayAttendance();
  } else {
    Utils.showSnackBar("Localisation non disponible.", context, color: Colors.red);
  }
}

Future<List<AttendanceModel>> getAttendanceHistory() async{
  final List data = await _supabase.from(Constants.attendanceTable).select().eq('employee_id',_supabase.auth.currentUser!.id).textSearch('date', "'$attendanceHistoryMonth'",config: 'english').order('created_at',ascending: false);
  return data.map((attendance) => AttendanceModel.fromJson(attendance)).toList();
  }
}
