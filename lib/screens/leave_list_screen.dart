import 'package:employee_attendance/models/leave_request_model.dart';
import 'package:employee_attendance/screens/leave_request_screen.dart';
import 'package:employee_attendance/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeLeaveListScreen extends StatelessWidget {
  const EmployeeLeaveListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mes Demandes de Congé")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveRequestScreen())),
      ),
      body: FutureBuilder<List<LeaveRequest>>(
        future: Provider.of<DbService>(context).getEmployeeLeaveRequests(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final request = snapshot.data![index];
              return ListTile(
                title: Text("${request.type} - ${request.status}"),
                subtitle: Text("Du ${request.startDate} au ${request.endDate}"),
                trailing: _statusIcon(request.status),
              );
            },
          );
        },
      ),
    );
  }

  Widget _statusIcon(String status) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: status == 'approuve' 
            ? Colors.green.shade100 
            : status == 'rejete' 
                ? Colors.red.shade100 
                : Colors.orange.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: status == 'approuve' 
              ? Colors.green 
              : status == 'rejete' 
                  ? Colors.red 
                  : Colors.orange,
        ),
      ),
    );
  }
}