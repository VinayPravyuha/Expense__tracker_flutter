import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key,required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();//title to atomatically save by flutter
  final _numberController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  void _pressentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_numberController.text);
    final amountInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctr) => AlertDialog(
                  title: const Text('Invalid input'),
                  content: const Text('Please make sure to give a valid Input'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(ctr);
                        },
                        child: const Text('Okay'))
                  ]));

      return;
    }
    widget.onAddExpense(Expense(title: _titleController.text,amount: enteredAmount ,date: _selectedDate!,category: _selectedCategory));
    Navigator.pop(context);

  }

  @override
  void dispose() { //dispose fuction must use in case of using textediting to close it
    _titleController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;//to adjust the screen keyboard
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(// for scrolling after orientation
        child: Padding(
          padding:  EdgeInsets.fromLTRB(16,48,16,keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Title')),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      maxLength: 20,
                      decoration: const InputDecoration(
                        prefixText: '\$',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(children: [
                      Text(_selectedDate == null
                          ? 'No Date Selected'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: _pressentDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toString(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Expense'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
