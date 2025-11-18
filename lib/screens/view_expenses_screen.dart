import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewExpensesScreen extends StatelessWidget {
  const ViewExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Expenses")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('expenses').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          var expenses = snapshot.data!.docs;
          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              var exp = expenses[index];
              return ListTile(
                title: Text(exp['title']),
                subtitle: Text("${exp['category']} - ₹${exp['amount']}"),
              );
            },
          );
        },
      ),
    );
  }
}
