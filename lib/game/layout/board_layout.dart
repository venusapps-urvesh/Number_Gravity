import '../../core/constants/board_constants.dart';

/// Responsive board geometry for Flame rendering.
class BoardLayout {
  const BoardLayout({
    required this.rows,
    required this.cols,
    required this.cellSize,
    required this.gap,
  });

  final int rows;
  final int cols;
  final double cellSize;
  final double gap;

  double get boardWidth => cols * (cellSize + gap) - gap;

  double get boardHeight => rows * (cellSize + gap) - gap;

  double get cornerRadius => (tileCornerRadiusPx / tileSizePx) * cellSize;

  double get fontSize => (22 / tileSizePx) * cellSize;

  /// Fits the board inside [maxWidth] x [maxHeight] with [padding] on each side.
  factory BoardLayout.fit({
    required int rows,
    required int cols,
    required double maxWidth,
    required double maxHeight,
    double padding = 16,
  }) {
    const gap = boardCellGapPx;
    final availableW = maxWidth - padding * 2;
    final availableH = maxHeight - padding * 2;

    final cellFromW = (availableW - (cols - 1) * gap) / cols;
    final cellFromH = (availableH - (rows - 1) * gap) / rows;
    var cellSize = cellFromW < cellFromH ? cellFromW : cellFromH;

    if (cellSize > tileSizePx) {
      cellSize = tileSizePx;
    }

    return BoardLayout(
      rows: rows,
      cols: cols,
      cellSize: cellSize,
      gap: gap,
    );
  }

  /// Default fixed size used before viewport constraints are known.
  factory BoardLayout.defaultFor({required int rows, required int cols}) {
    return BoardLayout(
      rows: rows,
      cols: cols,
      cellSize: tileSizePx,
      gap: boardCellGapPx,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardLayout &&
          rows == other.rows &&
          cols == other.cols &&
          cellSize == other.cellSize &&
          gap == other.gap;

  @override
  int get hashCode => Object.hash(rows, cols, cellSize, gap);
}
