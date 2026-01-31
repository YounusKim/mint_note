import 'package:flutter/material.dart';
import 'package:mint_note/config/theme/app_theme.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.secondary,

      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
        title: Text(
          'Note',
          style: TextStyle(
            fontFamily: 'KumarOne',
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: AppTheme.lightTheme.colorScheme.primary,
        backgroundColor: Colors.white,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.secondary,
        ),
      ),
    );
  }
}
