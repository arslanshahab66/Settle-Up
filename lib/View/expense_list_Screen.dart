import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final String collectionName = 'Expenses';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Expenses')
            .where('Split by', isEqualTo: 'Percentage')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final dataMap =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              final date = preprocessDateString(dataMap['date']);
              String formattedDate = DateFormat('MM/dd/yyyy').format(date);

              if (date == DateTime.now()) {
                formattedDate = 'Today';
              } else if (date == DateTime.now().subtract(const Duration(days: 1))) {
                formattedDate = 'Yesterday';
              } else {
                final difference = DateTime.now().difference(date);
                if (difference.inDays > 0) {
                  formattedDate = '${difference.inDays} days ago';
                } else if (difference.inHours > 0) {
                  formattedDate = '${difference.inHours} hours ago';
                } else if (difference.inMinutes > 0) {
                  formattedDate = '${difference.inMinutes} minutes ago';
                } else {
                  formattedDate = 'Just now';
                }
              }

              // Get the selected contact initial
              final selectedContactInitial =
                  dataMap['selectedContactInitials'] != null
                      ? dataMap['selectedContactInitials'][0]
                      : '';

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xff5CAF9F),
                  child: Text(
                    selectedContactInitial,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                title: Text(dataMap['description']),
                subtitle: Text(dataMap['categories']),
                trailing: Text(formattedDate),
              );
            },
          );
        },
      ),
    );
  }

  DateTime preprocessDateString(String dateString) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    if (dateString == 'Today') {
      return today;
    } else if (dateString == 'Yesterday') {
      return yesterday;
    } else {
      final matches = RegExp(r'^(\d+)\s+(\w+)\s+ago$').firstMatch(dateString);
      if (matches != null) {
        final count = int.parse(matches.group(1)!);
        final unit = matches.group(2);
        switch (unit) {
          case 'days':
            return today.subtract(Duration(days: count));
          case 'weeks':
            return today.subtract(Duration(days: count * 7));
          case 'months':
            return today.subtract(Duration(days: count * 30));
          case 'years':
            return today.subtract(Duration(days: count * 365));
        }
      }
    }
    return DateFormat('MM/dd/yyyy').parse(dateString);
  }
}
