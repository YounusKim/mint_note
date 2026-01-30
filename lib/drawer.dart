import 'package:flutter/material.dart';
import 'package:mint_note/config/theme/app_theme.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/mint_logo.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Smart Editor for Web-Novel',
                    style: TextStyle(
                      fontFamily: 'KumarOne',
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: AppTheme.lightTheme.colorScheme.secondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
