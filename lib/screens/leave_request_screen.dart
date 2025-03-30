import 'package:employee_attendance/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  LeaveRequestScreenState createState() => LeaveRequestScreenState();
}

class LeaveRequestScreenState extends State<LeaveRequestScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  String _type = 'annuel';
  final _commentsController = TextEditingController();

  Future<void> _submit() async {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez sélectionner les dates")),
      );
      return;
    }

    try {
      await Provider.of<DbService>(context, listen: false).submitLeaveRequest(
        startDate: _startDate!,
        endDate: _endDate!,
        type: _type,
        comments: _commentsController.text,
        context: context,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Demande envoyée avec succès")),
      );

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nouvelle Demande de Congé")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  _buildDatePicker("Date de début", _startDate, (date) => setState(() => _startDate = date)),
                  _buildDatePicker("Date de fin", _endDate, (date) => setState(() => _endDate = date)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              value: _type,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Type de congé",
              ),
              items: const [
                DropdownMenuItem(value: 'annuel', child: Text("Congé Annuel")),
                DropdownMenuItem(value: 'maladie', child: Text("Maladie")),
                DropdownMenuItem(value: 'maternite', child: Text("Maternité")),
              ],
              onChanged: (value) => setState(() => _type = value!),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _commentsController,
              decoration: InputDecoration(
                labelText: "Commentaires",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _submit,
              child: const Text("Soumettre", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(String label, DateTime? date, Function(DateTime) onSelect) {
    return ListTile(
      title: Text("$label : ${date?.toLocal().toString().split(' ')[0] ?? 'Sélectionner'}"),
      trailing: const Icon(Icons.calendar_month, color: Colors.blue),
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (selectedDate != null) {
          setState(() => onSelect(selectedDate));
        }
      },
    );
  }
}
