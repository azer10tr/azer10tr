import 'package:employee_attendance/models/leave_request_model.dart';
import 'package:employee_attendance/screens/leave_request_screen.dart';
import 'package:employee_attendance/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/enums/date_enum.dart';
import '../core/functions/date_format.dart';

class EmployeeLeaveListScreen extends StatefulWidget {
  const EmployeeLeaveListScreen({super.key});

  @override
  State<EmployeeLeaveListScreen> createState() =>
      _EmployeeLeaveListScreenState();
}

class _EmployeeLeaveListScreenState extends State<EmployeeLeaveListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _statusTabs = ['En attente', 'Approuvé', 'Rejeté'];

  String _getStatusValue(String tabName) {
    switch (tabName) {
      case 'En attente':
        return 'en_attente';
      case 'Approuvé':
        return 'approuve';
      case 'Rejeté':
        return 'rejete';
      default: // 'Tous'
        return 'en_attente';
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _statusTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Demandes de Congé"),
        bottom: TabBar(
          controller: _tabController,
          tabs: _statusTabs.map((status) => Tab(text: status)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LeaveRequestScreen()),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _statusTabs.map((status) {
          return _buildLeaveList(_getStatusValue(status));
        }).toList(),
      ),
    );
  }

  Widget _buildLeaveList(String status) {
    return FutureBuilder<List<LeaveRequest>>(
      future: Provider.of<DbService>(context)
          .getEmployeeLeaveRequests(status: status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Aucune demande trouvée"));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final request = snapshot.data![index];
            return Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: _getStatusColor(request.status),
                    radius: 25,
                    child: const Icon(Icons.contact_page,
                        size: 25, color: Colors.white),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              request.type,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            _statusChip(request.status),
                          ],
                        ),
                        Text(
                          "Du ${formatDate(inputDate: request.startDate.toString(), formatType: DateFormatType.long)} au ${formatDate(inputDate: request.endDate.toString(), formatType: DateFormatType.long)}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 15),
        );
      },
    );
  }

  Widget _statusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getStatusColor(status)),
      ),
      child: Text(
        status == 'en_attente'
            ? 'En attente'
            : status == 'approuve'
                ? 'Approuvé'
                : 'Rejeté',
        style: TextStyle(
          color: _getStatusColor(status),
          fontSize: 12,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approuve':
        return Colors.green;
      case 'rejete':
        return Colors.red;
      case 'en_attente':
      default:
        return Colors.orange;
    }
  }
}
