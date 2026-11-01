---
name: bug-fixing
description: Root-cause diagnostic and production-grade bug fixing workflow without quick hacks or architectural rule violations.
---

# Skill: Production-Grade Bug Fixing

When fixing bugs, crashes, UI glitches, or state synchronization issues, **temporary workarounds and quick hacks are strictly forbidden**. Fix the root cause while keeping the code compliant with all project rules.

## Diagnostic & Resolution Workflow

### 1. State & Cubit Lifecycle Bugs
- **Symptom:** Data not loading on screen open, or state firing multiple times.
    * **Root Cause Check:** Verify `..init()` is called exactly once at the `BlocProvider` creation cascade, NOT inside `build()` and NOT inside the Cubit constructor.
- **Symptom:** UI not updating when state changes.
    * **Root Cause Check:** Inspect `buildWhen: (previous, current) => ...` inside `BlocBuilder`. Ensure the emitted state satisfies the `buildWhen` condition and carries updated immutable properties.
- **Symptom:** `BlocProvider.of() called with a context that does not contain a Bloc`.
    * **Root Cause Check:** Ensure `CubitName.get(context)` is called inside a child context below the `BlocProvider` (e.g., inside `Builder` or extracted sub-widget file). Never use `context.read()` as a quick fix.

### 2. UI State & `ConditionalBuilder` Bugs
- **Symptom:** Blank screen, infinite loader, or unhandled empty list.
    * **Root Cause Check:** Inspect `ConditionalBuilder` flags:
        - `loadingState: state is FeatureLoading`
        - `errorState: state is FeatureError`
        - `emptyState: state is FeatureEmpty` (or `cubit.items.isEmpty`)
        - Ensure the Cubit explicitly emits `FeatureEmpty` when a returned list is empty before emitting `FeatureSuccess`.

### 3. Network & Error Handling Bugs
- **Symptom:** Unhandled exception crashing the app or raw exception string shown to user.
    * **Root Cause Check:** Ensure the service/network layer catches exceptions and wraps them into `Left(ServerFailure(...))` returning `Either<Failure, T>`.
    * Ensure the Cubit maps `Failure` to a clean error state using a localized translation key (`appTranslation().get(key)`), never passing `e.toString()` to the UI.

### 4. Layout, RTL/LTR & Overflow Bugs
- **Symptom:** `RenderFlex overflowed` or broken Arabic layout.
    * **Root Cause Check:**
        - Replace fixed `SizedBox` containers with flexible layout constraints (`Expanded`, `Flexible`) and use `spacing.dart` getters for gaps.
        - Replace `EdgeInsets.only(left/right)` with `EdgeInsetsDirectional.only(start/end)`.
        - If fixing the layout adds lines to the screen, extract the fixed component into its own widget file so the file stays strictly under **150 lines**.

### 5. Regression Verification
- Add or update unit tests in `test/` (mirroring `lib/`) using `mocktail` to cover the failing scenario inside the Cubit or utility function.