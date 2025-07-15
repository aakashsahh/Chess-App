enum ChessPieceType { king, queen, bishop, knight, rook, pawn }

class ChessPiece {
  final ChessPieceType type;
  final bool isWhite;

  ChessPiece({required this.type, required this.isWhite});
}
