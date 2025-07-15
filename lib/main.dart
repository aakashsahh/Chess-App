import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'viewmodels/chess_game_viewmodel.dart';
import 'views/screens/chess_board_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ChessGameViewModel(),
      child: const ChessApp(),
    ),
  );
}

class ChessApp extends StatelessWidget {
  const ChessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const ChessBoardScreen(),
    );
  }
}
