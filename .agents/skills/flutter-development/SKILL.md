---
name: flutter-development
description: Elite workflow for building new Flutter features, screens, widgets, and Cubits following strict simplified architecture and <150 lines per file rules.
---

# Skill: Flutter Development (Sol/Astra Precision Mode)

When asked to build a new feature, screen, or UI component, NEVER write monolithic code. Follow this deterministic 4-phase engineering pipeline:

## Phase 1: Pre-Code Blueprinting (Before writing a single line of code)
1. **Scan Primary Components:** Check `lib/core/utils/constants/primary/` first. Any button, text field, dialog, card, or state wrapper that can be shared MUST be placed in or reused from `primary/`.
2. **Decompose into Atomic Files (<150 Lines Guarantee):**
   - A Screen file must NEVER exceed **150 lines** (target: 50–90 lines).
   - Plan a separate `.dart` file in `lib/features/<feature>/presentation/widgets/` for every distinct UI section (e.g., `feature_header.dart`, `feature_list_item.dart`, `feature_filter_bar.dart`).
   - Private `_build*()` widget methods are **STRICTLY FORBIDDEN**.
3. **Prepare Core Assets:**
   - Add missing spacing getters to `lib/core/utils/constants/spacing.dart`.
   - Add colors to `ColorsManager` (`lib/core/theme/colors.dart`).
   - Add text styles to `TextStylesManager` (`lib/core/theme/text_styles.dart`).
   - Add route constants to `lib/core/utils/constants/routes.dart`.
   - Add translation keys to BOTH `assets/translations/ar.json` and `assets/translations/en.json`.

## Phase 2: Simplified Architecture & Cubit Implementation
- **NO BLOAT LAYERS:** Never create `Repository`, `RepositoryImpl`, `Domain`, `UseCases`, or `DataSource` files.
- **Cubit Placement:**
   * Global shared -> `lib/core/utils/cubit/`
   * Feature shared -> `lib/features/<feature>/logic/`
   * Screen specific -> `lib/features/<feature>/presentation/logic/`
- **Strict Cubit Template:**
```dart
class FeatureCubit extends Cubit<FeatureState> {
  // Pure constructor ONLY passing InitialState to super
  FeatureCubit() : super(FeatureInitial());

  // Mandatory static accessor (NEVER use context.read or context.watch)
  static FeatureCubit get(BuildContext context) => BlocProvider.of(context);

  late final ApiService _apiService;

  // All initialization and dependency setup MUST happen inside init()
  Future<void> init(ApiService apiService) async {
    _apiService = apiService;
    await fetchData();
  }

  Future<void> fetchData() async {
    emit(FeatureLoading());
    final Either<Failure, List<ItemModel>> result = await _apiService.getItems();
    result.fold(
      (failure) => emit(FeatureError(failure.messageKey)),
      (items) => items.isEmpty ? emit(FeatureEmpty()) : emit(FeatureSuccess(items)),
    );
  }
}