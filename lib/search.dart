import 'package:flutter/material.dart';
import 'package:mint_note/config/theme/app_theme.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
        title: Text(
          'Search',
          style: TextStyle(
            fontFamily: 'KumarOne',
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.secondary,
        ),
      ),
    );
  }
}
