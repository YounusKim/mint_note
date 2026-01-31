import 'package:flutter/material.dart';
import 'package:mint_note/memo.dart';
import 'package:mint_note/search.dart';
import 'package:mint_note/synopsis.dart';
import 'package:mint_note/config/theme/app_theme.dart';

class NotebookWidget extends StatefulWidget {
  const NotebookWidget({super.key});

  @override
  State<NotebookWidget> createState() => _NotebookWidgetState();
}

class _NotebookWidgetState extends State<NotebookWidget> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    SynopsisPage(),
    MemoPage(),
    SearchPage(),
    // NotePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(child: _pages[_selectedIndex]),
              _buildBottomNavigationBar(
                _selectedIndex,
                (index) => setState(() => _selectedIndex = index),
                [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.movie_edit, size: 20),
                    label: '시놉시스',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.sticky_note_2, size: 20),
                    label: '메모',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search, size: 20),
                    label: '검색',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 바텀 네비게이션 바 공통 위젯
  Widget _buildBottomNavigationBar(
    int currentIndex,
    Function(int) onTap,
    List<BottomNavigationBarItem> items,
  ) {
    return BottomNavigationBar(
      backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      fixedColor: AppTheme.lightTheme.colorScheme.primary,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(
        fontFamily: 'NanumBarunGothic',
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
    );
  }
}
