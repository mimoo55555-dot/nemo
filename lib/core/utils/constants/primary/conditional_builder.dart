import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';

class ConditionalBuilder extends StatelessWidget {
  final bool loadingState;
  final bool errorState;
  final bool emptyState;
  final WidgetBuilder successBuilder;
  final WidgetBuilder? loadingBuilder;
  final WidgetBuilder? errorBuilder;
  final WidgetBuilder? emptyBuilder;

  const ConditionalBuilder({
    super.key,
    required this.loadingState,
    required this.successBuilder,
    this.errorState = false,
    this.emptyState = false,
    this.loadingBuilder,
    this.errorBuilder,
    this.emptyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (loadingState) {
      return loadingBuilder?.call(context) ??
          const Center(
            child: CircularProgressIndicator(color: ColorsManager.primary),
          );
    }
    if (errorState) {
      return errorBuilder?.call(context) ?? const SizedBox.shrink();
    }
    if (emptyState) {
      return emptyBuilder?.call(context) ?? const SizedBox.shrink();
    }
    return successBuilder(context);
  }
}
