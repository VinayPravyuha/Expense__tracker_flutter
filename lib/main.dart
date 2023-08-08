import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var colorSchem=ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 27, 4, 71));

var dcolorSchem=ColorScheme.fromSeed(brightness: Brightness.dark,  seedColor:const Color.fromARGB(255, 5, 99, 125));


void main(){
  runApp( MaterialApp(
    darkTheme: ThemeData.dark().copyWith(useMaterial3: true,colorScheme:  dcolorSchem,
    cardTheme: const CardTheme().copyWith(color: dcolorSchem.secondaryContainer,margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16)),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      backgroundColor: dcolorSchem.primaryContainer,
    )),
    textTheme:  ThemeData().textTheme.copyWith(
      titleLarge:  TextStyle(
        fontWeight:FontWeight.bold,
        color: colorSchem.onSecondaryContainer,
        fontSize: 16,),),

    ),
    theme: ThemeData().copyWith(useMaterial3: true,colorScheme:  colorSchem,
    appBarTheme: const AppBarTheme().copyWith(backgroundColor: colorSchem.onPrimaryContainer,foregroundColor: colorSchem.primaryContainer),
    cardTheme: const CardTheme().copyWith(color: colorSchem.secondaryContainer,margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16)),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      backgroundColor: colorSchem.primaryContainer,
    )),
    textTheme:  ThemeData().textTheme.copyWith(
      titleLarge:  TextStyle(
        fontWeight:FontWeight.bold,
        color: colorSchem.onSecondaryContainer,
        fontSize: 16,
      )
    ),
    ),
    home: const Expenses()));
}