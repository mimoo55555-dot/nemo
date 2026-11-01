import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/spacing.dart';
import 'package:nemoventrt/features/clinical/presentation/widgets/sbt_description_widget.dart';

class SbtControlWidget extends StatefulWidget {
  const SbtControlWidget({super.key});

  @override
  State<SbtControlWidget> createState() => _SbtControlWidgetState();
}

class _SbtControlWidgetState extends State<SbtControlWidget> {
  bool _isActive = false;
  int _secondsRemaining = 30 * 60;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Card(
    color: _isActive ? ColorsManager.amberLight : ColorsManager.surface,
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(
            Icons.timer,
            color: _isActive ? ColorsManager.amber : ColorsManager.grey,
          ),
          horizontalSpace12,
          Expanded(
            child: SbtDescriptionWidget(
              isActive: _isActive,
              secondsRemaining: _secondsRemaining,
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: _isActive
                  ? ColorsManager.red
                  : ColorsManager.primary,
              foregroundColor: ColorsManager.white,
            ),
            onPressed: _toggleTimer,
            child: Text(appTranslation().get(_isActive ? 'stop' : 'start_30m')),
          ),
        ],
      ),
    ),
  );

  void _toggleTimer() {
    setState(() => _isActive = !_isActive);
    if (!_isActive) {
      _timer?.cancel();
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer timer) {
    if (!mounted) {
      timer.cancel();
      return;
    }
    if (_secondsRemaining > 1) {
      setState(() => _secondsRemaining--);
      return;
    }
    timer.cancel();
    setState(() {
      _isActive = false;
      _secondsRemaining = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(appTranslation().get('sbt_completed_assess_rsbi')),
      ),
    );
  }
}
