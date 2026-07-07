/// Feature flags for the gameplay widget shell.
class GameplayOptions {
  const GameplayOptions({
    this.economyEnabled = false,
    this.showWinOverlay = true,
    this.autoNavigateOnWin = false,
  });

  /// When false, undo/redo/hint are free and skip coin confirmation sheets.
  final bool economyEnabled;

  /// Shows inline celebration overlay before optional victory navigation.
  final bool showWinOverlay;

  /// When true, navigates to victory screen automatically after win overlay.
  final bool autoNavigateOnWin;

  static const GameplayOptions pureGameplay = GameplayOptions();

  static const GameplayOptions campaign = GameplayOptions(
    economyEnabled: true,
    showWinOverlay: true,
    autoNavigateOnWin: false,
  );
}
