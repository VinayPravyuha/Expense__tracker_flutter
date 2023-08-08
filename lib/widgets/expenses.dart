import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_lists/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expenses.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(
        title: 'Flutter',
        amount: 300,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 30,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpense.indexOf(expense);

    setState(
      () {
        _registeredExpense.remove(expense);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _registeredExpense.insert(expenseIndex, expense);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final width =MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No expense found.Start adding some!'),
    );

    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpense, onRemovedExpense: _removeExpense);
    }
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Expense Tracker',
              //style: TextStyle(color: Color.fromARGB(255, 88, 4, 101)),
            ),
            actions: [
              IconButton(
                onPressed: _openAddExpenseOverlay,
                icon: const Icon(Icons.add),
              ),
            ]),
        body: width<600 
        ? Column(
          children: [
            Chart(expenses: _registeredExpense),
            Expanded(
              child: mainContent,
            ),
          ],
        ):Row(children: [
          Expanded(child: 
            Chart(expenses: _registeredExpense),),
            Expanded(
              child: mainContent,
            ),
          ],),);
  }
}
