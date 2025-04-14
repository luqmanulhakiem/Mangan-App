import 'package:flutter/material.dart';

class SwitchSettingWidget extends StatelessWidget {
  final String title, subtitle;
  final bool value;
  final Function(bool) onChanged;
  const SwitchSettingWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SwitchListTile(
      title: Text(
        title,
        style: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: textTheme.bodyMedium,
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
