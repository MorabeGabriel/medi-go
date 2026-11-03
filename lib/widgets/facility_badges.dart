import 'package:flutter/material.dart';

import '../models/medical_facility.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// "Open / Closed" plus a 24-hour badge when applicable.
class FacilityBadges extends StatelessWidget {
  const FacilityBadges({super.key, required this.facility});

  final MedicalFacility facility;

  @override
  Widget build(BuildContext context) {
    final isHospital = facility.type == FacilityType.hospital;
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        StatusBadge(
          label: facility.isOpen ? 'Open' : 'Closed',
          color: facility.isOpen ? Colors.green.shade700 : Colors.grey.shade700,
        ),
        if (facility.is24Hours)
          StatusBadge(
            label: isHospital ? '24/7 Emergency' : 'Open 24 hours',
            color: isHospital ? Colors.red.shade700 : Colors.blue.shade700,
          ),
      ],
    );
  }
}
