---
name: performance
description: Flutter rendering, memory, and state rebuild optimization skill enforcing granular buildWhen, const constructors, and atomic widget trees.
---

# Skill: High-Performance Flutter Optimization

When optimizing a feature or building complex interactive screens, enforce 60/120 FPS rendering performance by eliminating unnecessary widget rebuilds and memory leaks.

## 1. Granular `BlocBuilder` Scoping & `buildWhen` Precision
- **Push `BlocBuilder` Down the Tree:** Never wrap an entire `Scaffold` in a single `BlocBuilder` if only a small section changes. Keep the `Scaffold` and static headers `const`, and wrap ONLY the dynamic body/widget with `BlocBuilder`.
- **Strict State Filtering (`buildWhen`):**
    * Bad: `buildWhen: (previous, current) => true`
    * Good: Filter by exact state subset relevant to that specific widget:
      ```dart
      buildWhen: (previous, current) =>
          current is FeatureLoading ||
          current is FeatureSuccess ||
          current is FeatureError ||
          current is FeatureEmpty,
      ```
    * For micro-widgets (e.g., a favorite button or item counter in a list), scope a dedicated `BlocBuilder` in that item's widget file with a targeted `buildWhen`:
      ```dart
      buildWhen: (previous, current) =>
          current is ItemFavoriteToggled && current.itemId == item.id,
      ```

## 2. Atomic Widget Files & `const` Propagation
- Because private `_build*()` methods are forbidden and every widget lives in its own `.dart` file:
    * Mark EVERY widget constructor as `const`.
    * Pass only the primitive data or model needed by that widget—never pass the entire `Cubit` instance as a constructor parameter.
    * Inside the atomic widget, access actions via `CubitName.get(context)` inside callbacks (`onTap`, `onPressed`).

## 3. List & Scroll Performance
- Always use `ListView.separated` or `ListView.builder` / `GridView.builder` / `CustomScrollView` with `SliverList.builder` for dynamic collections—never use `.map().toList()` inside a `Column` for dynamic lists.
- In `ListView.separated`, use spacing getters from `lib/core/utils/constants/spacing.dart`:
  `separatorBuilder: (context, index) => verticalSpace12,`

## 4. Rendering & Paint Optimization
- **Zero `withOpacity`:** Always use `.withValues(alpha: ...)` to avoid costly offscreen buffer (`saveLayer`) allocations triggered by legacy opacity methods.
- **Zero `Theme.of(context)` Lookups:** Directly reference `ColorsManager` and `TextStylesManager` static getters so widgets do not register inherited dependencies on `Theme` changes.
- **Ephemeral UI Isolation:** If an animation or scroll controller updates every frame, isolate it inside a dedicated small `<150 line` widget file so frame ticks never rebuild parent layouts or trigger Cubit state emissions.