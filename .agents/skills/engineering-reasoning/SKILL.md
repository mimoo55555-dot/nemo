---
name: engineering-reasoning
description: Deep architectural reasoning, mental simulation, and pre-computation framework that forces Sol/Astra-level cognitive rigor before writing or modifying any Flutter code.
---

# Skill: Engineering Reasoning & Cognitive Framework (Astra/Sol Brain)

You must NEVER jump directly from reading a prompt to generating code. Every request must pass through this 5-Stage Cognitive Reasoning Engine. Think systematically, anticipate edge cases, and validate structural constraints mentally before emitting a single line of Dart.

---

## Stage 1: Intent Deconstruction & Blast-Radius Analysis
Before touching any file, analyze the true scope of the request:
1. **Direct vs. Implied Requirements:**
    - What did the user explicitly ask for?
    - What is implicitly required by the project rules? (e.g., if the user asks for a "Profile Screen", you implicitly need: `ar.json`/`en.json` keys, `Routes` constant, `injections.dart` registration, `ConditionalBuilder` state handling, and atomic sub-widgets).
2. **Reuse Discovery (`primary/` First):**
    - Scan `lib/core/utils/constants/primary/`. Can an existing component fulfill part of this task?
    - Will any UI piece in this task be needed in future screens? If yes, reason about it as a generic, parameterized Primary Component first—never hardcode it inside a feature folder.
3. **Architecture Boundary Check:**
    - Immediately reject any mental reflex to create `Repository`, `DataSource`, `UseCase`, or `Domain` layers.
    - Trace the shortest, cleanest data path: `Core Network/Models` ➔ `Cubit` ➔ `UI State` ➔ `Atomic Widgets`.

---

## Stage 2: Mental Tree Slicing (The <150-Line Mathematical Proof)
Before writing UI code, mentally construct the widget tree and estimate line counts:
1. **The Orchestrator Rule:**
    - A `Screen` file is strictly a layout orchestrator (`Scaffold` + `BlocBuilder` + `ConditionalBuilder`). It should mentally estimate to **50–85 lines max**.
2. **Pre-Emptive Slicing:**
    - Anytime a UI section has more than 3 nested layout widgets (e.g., `Container` > `Column` > `Row` > `Text`), slice it into an independent `StatelessWidget` class in its own `.dart` file inside `presentation/widgets/`.
    - **Zero `_build*()` Tolerance:** If you catch yourself thinking of a helper method to keep code tidy, immediately convert that thought into a new widget file with a `const` constructor.

---

## Stage 3: State Machine & Data-Flow Simulation
Simulate the complete lifecycle of the feature from initialization to disposal:
1. **Lifecycle Entry (`..init()`):**
    - How does the screen start? The Cubit constructor MUST remain empty (`super(InitialState())`).
    - Trace exactly what parameters `..init()` needs when invoked via cascade at the `BlocProvider`.
2. **Exhaustive State Matrix:**
    - Every async operation must map to 4 deterministic states:
        * **Loading** ➔ mapped to `ConditionalBuilder.loadingState`
        * **Error** (`Left(Failure)`) ➔ mapped to `ConditionalBuilder.errorState` (with localized message key & retry callback)
        * **Empty** (`Right(data)` where `data.isEmpty`) ➔ mapped to `ConditionalBuilder.emptyState`
        * **Success** (`Right(data)` where `data.isNotEmpty`) ➔ mapped to `ConditionalBuilder.successBuilder`
    - Never leave a gap where an empty list renders a blank `Success` view or a network failure throws an unhandled exception.
3. **Rebuild Blast-Radius (`buildWhen` Calculus):**
    - For every `BlocBuilder` or `BlocConsumer`, ask: *"Which exact state transitions require THIS specific widget subtree to repaint?"*
    - Formulate a strict `buildWhen: (previous, current) => ...` expression. Never allow unrelated state emissions (like a bottom-sheet action or minor toggle) to rebuild the entire screen.

---

## Stage 4: Design System & Directionality Reasoning
Mentally verify the visual and localization integrity of every widget:
1. **Zero Magic Values:**
    - Every gap maps to `spacing.dart` (`verticalSpace*`, `horizontalSpace*`).
    - Every color maps to `ColorsManager.*` (using `.withValues(alpha: ...)` for transparency).
    - Every text style maps to `TextStylesManager.*`.
2. **Bi-Directional (RTL/LTR) Physics:**
    - Mentally flip the screen between Arabic (RTL) and English (LTR).
    - Are paddings using `EdgeInsetsDirectional`? Are alignments using `AlignmentDirectional`? Do directional icons (arrows, chevrons) adapt properly?
    - Are all touch targets at least `48x48` with localized semantic labels?

---

## Stage 5: Pre-Output Adversarial Self-Correction (The Red-Team Gate)
Before outputting your response, act as a hostile Senior Reviewer trying to break your own solution. Ask yourself:
- *"Did I accidentally type `context.read` or `context.watch` instead of `CubitName.get(context)`?"*
- *"Did I sneak in a `SizedBox(height: ...)` or `Colors.white` out of habit?"*
- *"Did I forget `buildWhen` on any `BlocBuilder`?"*
- *"Did I use the exact parameter names of `ConditionalBuilder` (`loadingState`, `errorState`, `emptyState`, `successBuilder`, `loadingBuilder`, `errorBuilder`, `emptyBuilder`)?"*
- *"Did any file cross 150 lines?"*
- *"Are both `ar.json` and `en.json` updated with every new string key?"*

If ANY answer exposes a flaw, silently refactor the mental draft BEFORE generating the final code output.