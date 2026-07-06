# Number Gravity

A deterministic, turn-based gravity puzzle game built with Flutter. Players move numbered tiles on a grid; positive numbers **attract** nearby tiles, negative numbers **repel** them. After each move, gravity resolves automatically until the board reaches a stable state. Complete level objectives in as few moves as possible to earn stars.

> **What “deterministic” means:** Given the same board and the same player move, the simulation always produces the same result. There is no randomness during gameplay — only fixed rules and priority order.

---

## Table of Contents

- [How to Play](#how-to-play)
- [Game Mechanics](#game-mechanics)
- [Worlds & Progression](#worlds--progression)
- [Objectives](#objectives)
- [Star Rating & Coins](#star-rating--coins)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Development Commands](#development-commands)
- [Level Data Format](#level-data-format)
- [Localization](#localization)
- [Testing](#testing)
- [Dependencies](#dependencies)

---

## How to Play

1. **Select a tile** — Tap a movable number tile on the board.
2. **Choose a direction** — Swipe or tap Up, Down, Left, or Right to move it one cell.
3. **Gravity resolves** — After your move, all movable tiles shift according to gravity forces until nothing moves (or the cycle cap is reached).
4. **Meet the objective** — Position tiles, hit target sums, complete sequences, etc., depending on the level.
5. **Earn stars** — Finish in the minimum number of moves for 3 stars; up to 2 extra moves still earns 2 stars.

---

## Game Mechanics

### Gravity Forces

Each **number** or **frozen** tile emits gravity. Force magnitude is:

```
force = |tile value| / distance
```

- **Distance** = Manhattan distance (rows + columns) between source and target.
- **Range cap:** Distance 4 or greater has **no effect** (`forceRangeCap = 4` in `lib/core/constants/game_constants.dart`).
- **Positive values** → **attraction** (pull toward the source).
- **Negative values** → **repulsion** (push away from the source).

Forces are applied independently on each axis (row and column). When multiple forces compete, the strongest wins; ties are broken deterministically (`lib/simulation/tie_breaker.dart`).

### Simulation Cycle

After a player move, the engine runs **gravity cycles** until the board is stable:

1. Compute intended direction for every movable tile.
2. Process movement in a fixed tile sort order.
3. Apply rules in priority order (see below).
4. Repeat until no tile moves, or `maxGravityCycles` (10) is hit.

**Simulation priority** (highest to lowest):

| Priority   | Rule        | Description                          |
|-----------|-------------|--------------------------------------|
| Boundary  | Edge of board | Tiles cannot leave the grid        |
| Wall      | Solid walls | Block movement                     |
| Portal    | Teleport    | Linked portal pairs                  |
| Collision | Tile clash  | Number tiles combine on collision  |
| Modifier  | Transform   | Multiplier, divider, inverter tiles  |
| Gravity   | Movement    | Apply attraction / repulsion         |

Core simulation lives in `lib/simulation/` — entry point is `DefaultGravityEngine`.

### Tile Types

| Type         | Movable | Emits Gravity | Notes                                      |
|-------------|---------|---------------|--------------------------------------------|
| `number`    | Yes     | Yes           | Core gameplay tile; positive = pull, negative = push |
| `freeze`    | No      | Yes           | Frozen in place but still affects others   |
| `wall`      | No      | No            | Blocks movement                            |
| `portal`    | No      | No            | Teleports tiles to paired portal           |
| `multiplier`| No      | No            | Modifies passing tile values               |
| `divider`   | No      | No            | Divides passing tile values              |
| `inverter`  | No      | No            | Flips sign of passing tile values          |
| `switchTile`| No      | No            | Toggles linked doors                       |
| `door`      | No      | No            | Opens/closes based on switch state         |
| `goal`      | No      | No            | Target cell for position objectives        |

Defined in `lib/models/tile_type.dart`.

---

## Worlds & Progression

The game ships with **8 worlds** and **200 levels** (25 per world). Each world introduces new mechanics:

| World | Name          | Mechanic           | Board Size | Levels   |
|-------|---------------|--------------------|------------|----------|
| 1     | First Pull    | Attraction only    | 4×4        | 1–25     |
| 2     | Push Back     | Repulsion          | 5×5        | 26–50    |
| 3     | Obstacles     | Walls              | 5×5        | 51–75    |
| 4     | Collisions    | Tile collisions    | 6×6        | 76–100   |
| 5     | Portals       | Portal pairs       | 6×6        | 101–125  |
| 6     | Transformers  | Modifier tiles     | 7×7        | 126–150  |
| 7     | Mechanisms    | Switches & doors   | 7×7        | 151–175  |
| 8     | Mastery       | Mixed mechanics    | 8×8        | 176–200  |

Configuration: `lib/levels/world_config.dart`  
Level JSON files: `assets/levels/world_01.json` … `world_08.json`

---

## Objectives

Each level has one objective (`lib/models/objective/objective_type.dart`):

| Type         | Goal                                                |
|-------------|-----------------------------------------------------|
| `position`  | Move a specific tile to a target cell               |
| `sequence`  | Visit cells in a defined order                      |
| `sum`       | Reach a target sum for a tile or group              |
| `balance`   | Balance values across regions                       |
| `collection`| Collect items or reach multiple goals               |
| `chain`     | Complete a chain of dependent moves                 |

Objective checking: `lib/simulation/objective_checker.dart`

---

## Star Rating & Coins

Stars are based on moves used vs. the level’s `minimumMoves`:

| Stars | Condition                          |
|-------|------------------------------------|
| ★★★   | `movesUsed <= minimumMoves`        |
| ★★    | `movesUsed <= minimumMoves + 2`    |
| ★     | Any successful completion          |

Coin rewards (first clear only): 5 / 15 / 30 coins for 1 / 2 / 3 stars.

Logic: `starsForMoves()` in `lib/core/constants/game_constants.dart`

---

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│  UI Layer (Flutter screens + widgets)                   │
│  home, worlds, levels, gameplay, settings, shop, …      │
└──────────────────────┬──────────────────────────────────┘
                       │ Riverpod providers
┌──────────────────────▼──────────────────────────────────┐
│  Game Layer (Flame)                                     │
│  NumberGravityGame → BoardComponent, force lines        │
│  SimulationBridge connects UI ↔ simulation              │
└──────────────────────┬──────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────┐
│  Simulation Layer (pure Dart, no Flutter)                 │
│  GravityEngine → CycleSimulator → rule processors         │
└──────────────────────┬────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────┐
│  Data Layer                                             │
│  Hive storage, JSON level assets, repositories          │
└─────────────────────────────────────────────────────────┘
```

### Key design choices

- **Riverpod** — State management, dependency injection, and async storage init.
- **go_router** — Declarative navigation with splash → home redirect after storage loads.
- **Flame** — Renders the game board, tile animations, and force-line overlays.
- **Hive** — Local persistence for settings, progress, statistics, and achievements.
- **Freezed + json_serializable** — Immutable models with JSON serialization for levels and simulation data.
- **Firebase (stub)** — Analytics, crash reporting, and remote config are wired but use a stub implementation until Firebase is configured (`lib/services/firebase/firebase_service_stub.dart`).

### App screens & routes

| Route            | Screen              | Purpose                        |
|------------------|---------------------|--------------------------------|
| `/`              | Splash              | Boot while storage initializes |
| `/home`          | Home                | Main menu                      |
| `/worlds`        | World Select        | Pick a world                   |
| `/levels/:worldId` | Level Select      | Pick a level within a world    |
| `/play/:levelId` | Gameplay            | Play a level                   |
| `/daily`         | Daily Puzzle        | Seeded puzzle for today        |
| `/tutorial`      | Tutorial            | Learn the mechanics            |
| `/zen`           | Zen Mode            | Relaxed play                   |
| `/settings`      | Settings            | Theme, accessibility, audio    |
| `/shop`          | Shop                | In-app purchases               |
| `/profile`       | Profile             | Player stats                   |
| `/achievements`  | Achievements        | Unlock tracking                |
| `/leaderboard`   | Leaderboard         | Rankings (stub service)        |

Routes defined in `lib/app/router/routes.dart` and `lib/app/router/app_router.dart`.

---

## Project Structure

```
lib/
├── app/                  # App shell: theme, router, root widget
├── core/                 # Constants, extensions, errors, Result type
├── game/                 # Flame game: board rendering, input, animations
│   ├── bridges/          # SimulationBridge — connects Flame ↔ simulation
│   └── components/       # Board, tiles, force lines, selection overlay
├── levels/               # Level loading, world config, daily puzzle generator
├── l10n/                 # Localization ARB files and generated delegates
├── models/               # Board, tiles, levels, objectives, simulation DTOs
├── providers/            # Riverpod providers (storage, engine, settings)
├── screens/              # One folder per screen (home, gameplay, shop, …)
├── services/             # Audio, ads, IAP, analytics, cloud save, replay
├── simulation/           # Pure simulation engine and rule processors
│   └── rules/            # Portal, collision, modifier, switch/door logic
├── storage/              # Hive adapters, repositories, initialization
└── widgets/              # Shared UI: buttons, cards, scaffold, game HUD

assets/
├── levels/               # world_01.json … world_08.json (200 levels)
└── images/               # Image assets

test/                     # Unit tests (simulation, models, storage)
tool/
└── generate_levels.dart  # Script to regenerate level JSON files
```

---

## Getting Started

### Prerequisites

- Flutter SDK **3.12+** (Dart `^3.12.2`)
- Xcode (iOS) and/or Android Studio (Android) for device builds

### Install & run

```bash
# Clone the repository, then:
flutter pub get

# Generate Freezed / JSON code (if models changed)
dart run build_runner build --delete-conflicting-outputs

# Generate localization files (if ARB files changed)
flutter gen-l10n

# Run on a connected device or emulator
flutter run
```

---

## Development Commands

```bash
# Run all tests
flutter test

# Analyze for lint issues
flutter analyze

# Regenerate all 200 level JSON files
dart run tool/generate_levels.dart

# Regenerate model code after editing @freezed classes
dart run build_runner build --delete-conflicting-outputs
```

---

## Level Data Format

Levels are stored as JSON in `assets/levels/`. Each world file contains a `levels` array:

```json
{
  "levels": [
    {
      "id": 1,
      "world": 1,
      "tier": "beginner",
      "rows": 4,
      "cols": 4,
      "objective": {
        "type": "position",
        "tileId": "t1",
        "goalRow": 3,
        "goalCol": 3
      },
      "tiles": [
        {
          "id": "t1",
          "type": "number",
          "value": 2,
          "row": 0,
          "col": 0,
          "isLocked": false
        }
      ],
      "minimumMoves": 3,
      "solutionMoves": ["R", "D", "R"]
    }
  ]
}
```

**Fields explained:**

- `id` — Global level number (1–200).
- `world` — World number (1–8).
- `tier` — Difficulty tier (`beginner`, `intermediate`, `advanced`, `expert`). Also sets solver depth caps: 20 / 40 / 80 / 150 moves.
- `rows` / `cols` — Board dimensions (max 10×10).
- `objective` — Win condition (see [Objectives](#objectives)).
- `tiles` — Starting board layout.
- `minimumMoves` — Optimal move count for 3-star rating.
- `solutionMoves` — Reference solution (`U`/`D`/`L`/`R`).

Loaded by `AssetLevelRepository` in `lib/levels/asset_level_repository.dart`.

---

## Localization

Supported languages: **English**, **Spanish**, **French**.

- Source strings: `lib/l10n/app_en.arb` (template), `app_es.arb`, `app_fr.arb`
- Config: `l10n.yaml`
- Generated code: `lib/l10n/app_localizations*.dart` (do not edit by hand)

After changing ARB files:

```bash
flutter gen-l10n
```

---

## Testing

Tests focus on the deterministic simulation engine and data layer:

| Test file                              | Covers                          |
|----------------------------------------|---------------------------------|
| `test/simulation/force_calculator_test.dart` | Gravity force math          |
| `test/simulation/board_applier_test.dart`    | Board state updates           |
| `test/simulation/collision_resolver_test.dart` | Tile collision rules        |
| `test/simulation/tie_breaker_test.dart`      | Force tie-breaking            |
| `test/models/board_model_test.dart`          | Board model helpers           |
| `test/levels/level_loader_test.dart`         | JSON level loading            |
| `test/storage/settings_repository_test.dart` | Settings persistence        |
| `test/core/game_constants_test.dart`         | Star / solver helpers         |

```bash
flutter test
```

---

## Dependencies

| Package              | Purpose                              |
|---------------------|--------------------------------------|
| `flutter_riverpod`  | State management                     |
| `flame`             | Game board rendering & animation     |
| `go_router`         | Navigation                           |
| `hive` / `hive_flutter` | Local storage                    |
| `freezed` / `json_annotation` | Immutable models & JSON      |
| `google_fonts`      | Typography                           |
| `google_mobile_ads` | Rewarded ads                         |
| `in_app_purchase`   | Shop / IAP                           |
| `firebase_*`        | Analytics, crashlytics, remote config|

Full list: `pubspec.yaml`

---

## Production Reference

Detailed game design spec: `docs/Number_Gravity_Production_Doc_v4.docx`

Simulation constants and priorities in code map directly to sections of that document (annotated in `lib/core/constants/game_constants.dart` and `lib/models/tile_type.dart`).

---

## License

Private project — `publish_to: "none"` in `pubspec.yaml`.
