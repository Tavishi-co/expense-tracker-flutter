import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  Future<void> _addExpense() async {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;

    await FirebaseFirestore.instance.collection('expenses').add({
      'title': _titleController.text,
      'amount': double.parse(_amountController.text),
      'category': _categoryController.text,
      'date': DateTime.now().toIso8601String(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Expense Added!")),
    );

    _titleController.clear();
    _amountController.clear();
    _categoryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: _amountController, decoration: const InputDecoration(labelText: "Amount"), keyboardType: TextInputType.number),
            TextField(controller: _categoryController, decoration: const InputDecoration(labelText: "Category")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _addExpense, child: const Text("Add Expense")),
          ],
        ),
      ),
    );
  }
}
