import 'package:chess/chess.dart' as chess;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/chess_game_viewmodel.dart';

class ChessBoardScreen extends StatelessWidget {
  const ChessBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ChessGameViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Chess')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildBoard(vm)),
          if (vm.gameResult != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                vm.gameResult!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              ElevatedButton(
                onPressed: vm.resetGame,
                child: const Text('Restart'),
              ),
              ElevatedButton(onPressed: vm.undoMove, child: const Text('Undo')),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildBoard(ChessGameViewModel vm) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 64,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),
        itemBuilder: (context, index) {
          final row = 7 - index ~/ 8;
          final col = index % 8;
          final file = String.fromCharCode('a'.codeUnitAt(0) + col);
          final rank = (row + 1).toString();
          final square = file + rank;

          final piece = vm.game.get(square);
          final isWhiteTile = (row + col) % 2 == 0;
          final isSelected = vm.selected == square;
          final legalMoves = vm.selected != null
              ? vm.legalMoves(vm.selected!)
              : [];

          final isLegalMove = legalMoves.contains(square);

          return GestureDetector(
            onTap: () => vm.selectSquare(square),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.yellow[300]
                    : isLegalMove
                    ? Colors.green[300]
                    : isWhiteTile
                    ? Colors.grey[300]
                    : Colors.brown[400],
              ),
              child: piece != null
                  ? Center(
                      child: Text(
                        _pieceSymbol(piece),
                        style: const TextStyle(fontSize: 30),
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  String _pieceSymbol(chess.Piece piece) {
    final symbols = {
      chess.PieceType.KING: {'w': '♔', 'b': '♚'},
      chess.PieceType.QUEEN: {'w': '♕', 'b': '♛'},
      chess.PieceType.ROOK: {'w': '♖', 'b': '♜'},
      chess.PieceType.BISHOP: {'w': '♗', 'b': '♝'},
      chess.PieceType.KNIGHT: {'w': '♘', 'b': '♞'},
      chess.PieceType.PAWN: {'w': '♙', 'b': '♟'},
    };
    return symbols[piece.type]![piece.color == chess.Color.WHITE ? 'w' : 'b']!;
  }
}
