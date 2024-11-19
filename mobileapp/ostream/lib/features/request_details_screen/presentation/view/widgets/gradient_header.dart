import 'package:flutter/material.dart';

import '../../../../../utils/resources/app_colors.dart';

class GradientHeader extends StatelessWidget {
  final String requestTitle;
  final String requestStatus;
  final String lastUpdate;

  const GradientHeader({
    required this.requestTitle,
    required this.requestStatus,
    required this.lastUpdate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.lightColor, AppColors.mainColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32), // Spacer for status bar
          Row(
            children: [
              BackButton(color: Colors.white,),
              Expanded(
                child: Text(
                  requestTitle,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Chip(
                label: Text(
                  requestStatus,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: AppColors.getStatusColor(requestStatus),
              ),
              const SizedBox(width: 8),
              Text(
                "Last Updated: $lastUpdate",
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
