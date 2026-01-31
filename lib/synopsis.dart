import 'package:flutter/material.dart';
import 'package:mint_note/config/theme/app_theme.dart';

class SynopsisPage extends StatelessWidget {
  const SynopsisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.08),
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
        title: Text(
          'Synopsis',
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
          border: Border.all(
            width: 1,
            color: AppTheme.lightTheme.colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}
