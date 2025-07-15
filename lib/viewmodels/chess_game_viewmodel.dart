import 'package:chess/chess.dart' as chess;
import 'package:flutter/material.dart';

class ChessGameViewModel extends ChangeNotifier {
  final chess.Chess _game = chess.Chess();

  chess.Chess get game => _game;

  String? get gameResult {
    if (_game.in_checkmate) {
      return _game.turn == chess.Color.WHITE ? 'Black wins!' : 'White wins!';
    }
    if (_game.in_draw) return 'Draw';
    return null;
  }

  void resetGame() {
    _game.reset();
    notifyListeners();
  }

  void undoMove() {
    _game.undo_move();
    notifyListeners();
  }

  void selectSquare(String square) {
    if (_game.game_over) return;

    if (_selected == null) {
      if (_game.get(square) != null && _game.get(square)!.color == _game.turn) {
        _selected = square;
        notifyListeners();
      }
    } else {
      if (_selected == square) {
        _selected = null;
      } else {
        final move = {'from': _selected, 'to': square};
        final result = _game.move(move);
        _selected = null;
        notifyListeners();
      }
    }
  }

  String? _selected;
  String? get selected => _selected;

  List<String> legalMoves(String square) {
    final moves = _game.moves({'square': square, 'verbose': true});
    return moves.map((m) => m['to'] as String).toList();
  }
}
