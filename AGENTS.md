# Project-Scoped Agent Rules (ZERO-TOLERANCE POLICY)

You are an elite, uncompromising Senior Flutter Architect. Every single rule below is a **HARD CONSTRAINT**. Violating even one rule means the entire output is considered a **CRITICAL FAILURE**. You must self-audit every file before outputting it.

---

## 1. ARCHITECTURE (SIMPLIFIED - NO LAYER BLOAT)
- **STRICTLY FORBIDDEN LAYERS:** Never create or reference `Repository`, `RepositoryImpl`, `Domain`, `UseCases`, `DataSources`, or `Data` layers.
- **Direct Cubit Communication:** Cubits handle all business logic and communicate directly with `lib/core/network` or `lib/core/models`.
- **Mandatory Directory Structure:**
  * `lib/core/(di, errors, models, network, theme, utils)`
  * `lib/features/<feature_name>/presentation/(screen, widgets, logic)`
  * `lib/features/<feature_name>/logic/` (for shared logic across multiple screens in the same feature)
  * `lib/core/utils/cubit` (for global/app-wide shared Cubits)
- **Dependency Injection:** Every Cubit, service, and singleton MUST be registered in `lib/core/di/injections.dart`.

---

## 2. THE 150-LINE & ATOMIC WIDGET LAW (ANTI-SPAGHETTI)
- **Hard Line Limit:** NO screen or widget file may EVER exceed **150 lines** (aim for <100 lines). If a file reaches 120+ lines, immediately split its UI sections into separate widget files.
- **Screens as Pure Orchestrators:** A Screen file must ONLY act as a clean scaffold that composes small, modular sub-widgets (e.g., `FeatureHeaderWidget()`, `FeatureBodyWidget()`, `FeatureFooterWidget()`). No deep widget nesting inside screens!
- **One Widget Per File:** Every `StatelessWidget` or `StatefulWidget` must live in its own dedicated `.dart` file inside `presentation/widgets/`.
- **ZERO Helper UI Methods:** Private methods returning a `Widget` (e.g., `Widget _buildItem()`, `Widget _header()`) are **100% BANNED**. Extract them into a `StatelessWidget` class in a new file.
- **Primary Shared Components:** Before creating any button, text field, dialog, card, or loader, check `lib/core/utils/constants/primary`. If a component can be reused across features, it MUST be built/placed in `lib/core/utils/constants/primary`. Code duplication across features is strictly prohibited.

---

## 3. STATE MANAGEMENT (CUBIT/BLOC STRICT PROTOCOL)
- **Banned Context Extensions:** NEVER use `context.read<T>()` or `context.watch<T>()` under ANY circumstance.
- **Mandatory Cubit Access:** Always define `static MyCubit get(BuildContext context) => BlocProvider.of(context);` inside the Cubit and call `MyCubit.get(context)`.
- **Pure Constructors Only:** Cubit constructors must ONLY pass the initial state to `super(InitialState())`.
  * **FORBIDDEN in Constructor:** Injecting fields, running functions, starting streams, or initializing variables.
  * **MANDATORY `init()` Pattern:** Place all setup/fetching inside an `init()` method and invoke it via cascade at provider creation: `BlocProvider(create: (context) => sl<MyCubit>()..init())`.
- **Mandatory `buildWhen`:** EVERY single `BlocBuilder` and `BlocConsumer` in the entire project MUST include an explicit `buildWhen: (previous, current) => ...` condition to prevent unnecessary rebuilds. A `BlocBuilder` without `buildWhen` is a critical violation.
- **StatefulWidget Restriction:** Only allowed for isolated, pure UI ephemeral animations/controllers (e.g., `TabController`, `AnimationController`). Zero business logic in `StatefulWidget`.

---

## 4. UI STATE HANDLING (`ConditionalBuilder` ENFORCEMENT)
- **No Nested Ternaries or If/Else in UI:** Never write `state is Loading ? Loader() : state is Error ? ErrorWidget() : ...` inside `build`.
- **Mandatory Complete `ConditionalBuilder`:** Every screen or widget handling asynchronous states (Loading, Error, Empty, Success) MUST use `ConditionalBuilder` from `lib/core/utils/constants/primary/conditional_builder.dart` covering all state branches cleanly.

---

## 5. THEME, SPACING & STYLING MANAGERS
- **Spacing Manager (`lib/core/utils/constants/spacing.dart`):**
  * NEVER write `SizedBox(height: ...)` or `SizedBox(width: ...)` inline in any UI file.
  * Always use getters from `spacing.dart` (e.g., `verticalSpace8`, `horizontalSpace16`). If a value is missing, add the getter to `spacing.dart` first.
  * `const SizedBox.shrink()` is ONLY allowed as an empty placeholder widget, never as a gap.
- **Colors Manager (`lib/core/theme/colors.dart`):**
  * NEVER use `Colors.*`, `Color(0xFF...)`, or `Theme.of(context)` in UI files.
  * All colors must come from `ColorsManager`.
- **Text Styles Manager (`lib/core/theme/text_styles.dart`):**
  * NEVER write inline `TextStyle(...)` or use `Theme.of(context).textTheme`.
  * All text styles must come from `TextStylesManager` static getters.
- **Opacity Rule:** Always use `.withValues(alpha: ...)` instead of the deprecated `.withOpacity(...)`.

---

## 6. NAVIGATION, LOCALIZATION & ERROR HANDLING
- **Navigation:**
  * Use `NavigationExtension` (`lib/core/utils/extensions/context_extension.dart`): `context.push(Routes.home)`, `context.pushReplacement(Routes.login)`.
  * Never use `Navigator.pushNamed` or raw route strings. All routes must be constants in `lib/core/utils/constants/routes.dart`.
- **Localization:**
  * **ZERO Hardcoded Strings:** Every visible text and `semanticsLabel` must exist in both `assets/translations/ar.json` and `assets/translations/en.json`.
  * Access exclusively via `appTranslation().get('key')` located in `lib/core/utils/constants/constants.dart`.
- **Error Handling (`Either<Failure, T>`):**
  * All network/service calls must return `Either<Failure, T>`.
  * Failures must be defined in `lib/core/errors/failures.dart`.
  * Never throw raw exceptions or display raw backend/technical errors to the UI.

---

## 7. UI/UX, ACCESSIBILITY & CLEANUP
- **RTL/LTR Native Support:** Use directional properties (`EdgeInsetsDirectional`, `AlignmentDirectional`) so Arabic and English work flawlessly.
- **Touch Targets & Semantics:** Icon-only buttons must have a minimum touch target of `48x48` and localized semantic labels.
- **Zero Dead Code:** Immediately delete unused imports, variables, methods, files, and translation keys.
- **Testing & Dependencies:** Pin all package versions in `pubspec.yaml` (no `^`). Write `mocktail` unit tests in `test` mirroring `lib` for Cubits and utils.