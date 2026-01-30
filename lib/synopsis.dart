import 'package:flutter/material.dart';
import 'package:mint_note/config/theme/app_theme.dart';

class SynopsisPage extends StatelessWidget {
  const SynopsisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        title: Text(
          'Synopsis',
          style: TextStyle(
            fontFamily: 'KumarOne',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
