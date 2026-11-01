import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nemoventrt/core/theme/colors.dart';
import 'package:nemoventrt/core/utils/constants/constants.dart';
import 'package:nemoventrt/core/utils/constants/primary/primary_action_button_widget.dart';
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
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 14),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: ColorsManager.amberLight,
                child: Icon(
                  Icons.timer_outlined,
                  color: ColorsManager.amber,
                ),
              ),
              horizontalSpace12,
              Expanded(
                child: SbtDescriptionWidget(
                  isActive: _isActive,
                  secondsRemaining: _secondsRemaining,
                ),
              ),
            ],
          ),
          verticalSpace12,
          PrimaryActionButtonWidget(
            labelKey: _isActive ? 'stop' : 'start_30m',
            icon: _isActive ? Icons.stop_circle_outlined : Icons.play_arrow,
            height: 46,
            backgroundColor: _isActive
                ? ColorsManager.redAction
                : ColorsManager.primary,
            onPressed: _toggleTimer,
          ),
        ],
      ),
    ),
  );

  void _toggleTimer() {
    if (_isActive) {
      _timer?.cancel();
      setState(() => _isActive = false);
      return;
    }
    setState(() {
      _isActive = true;
      _secondsRemaining = 30 * 60;
    });
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
