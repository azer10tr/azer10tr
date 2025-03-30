import 'package:employee_attendance/models/leave_request_model.dart';
import 'package:employee_attendance/services/db_service.dart';
import 'package:employee_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveManagementScreen extends StatelessWidget {
  const LeaveManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestion des Congés")),
      body: FutureBuilder<List<LeaveRequest>>(
        future: Provider.of<DbService>(context, listen: false).getAllLeaveRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucune demande de congé trouvée"));
          }
          
          return DataTable(
            columns: const [
              DataColumn(label: Text("Employé")),
              DataColumn(label: Text("Type")),
              DataColumn(label: Text("Dates")),
              DataColumn(label: Text("Statut")),
              DataColumn(label: Text("Actions")),
            ],
            rows: snapshot.data!.map((request) => DataRow(
              cells: [
                DataCell(Text(request.employeeId)), // Remplacez par le nom de l'employé
                DataCell(Text(request.type)),
                DataCell(Text("${_formatDate(request.startDate)} - ${_formatDate(request.endDate)}")),
                DataCell(_statusChip(request.status)),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => _updateStatus(context, request.id, 'approuve'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => _updateStatus(context, request.id, 'rejete'),
                    ),
                  ],
                )),
              ],
            )).toList(),
          );
        },
      ),
    );
  }

  static String _formatDate(DateTime date) => "${date.day}/${date.month}/${date.year}";

  static Widget _statusChip(String status) {
    return Chip(
      label: Text(status),
      backgroundColor: status == 'approuve' 
          ? Colors.green.shade100 
          : status == 'rejete' 
              ? Colors.red.shade100 
              : Colors.orange.shade100,
    );
  }

  void _updateStatus(BuildContext context, String requestId, String status) {
    Provider.of<DbService>(context, listen: false)
      .updateLeaveStatus(requestId, status)
      .then((_) => Utils.showSnackBar("Statut mis à jour", context));
  }
}
