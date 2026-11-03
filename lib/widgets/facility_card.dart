import 'package:flutter/material.dart';

import '../models/medical_facility.dart';
import '../services/launcher_service.dart';
import '../theme/app_theme.dart';
import 'facility_badges.dart';
import 'facility_type_icon.dart';
import 'icon_text.dart';

/// Summary card for one facility. Tapping it opens the details screen.
class FacilityCard extends StatelessWidget {
  const FacilityCard({super.key, required this.facility, required this.onTap});

  final MedicalFacility facility;
  final VoidCallback onTap;

  static const _maxServiceChips = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: cardDecoration(),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildDetails(),
                const SizedBox(height: 12),
                _buildServices(),
                const SizedBox(height: 16),
                _buildActions(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.tint,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(facility.type.icon, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                facility.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              FacilityBadges(facility: facility),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                facility.address,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${facility.distanceText} away',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            IconText(
              icon: Icons.star,
              iconColor: Colors.amber,
              text: facility.rating.toString(),
              bold: true,
            ),
            IconText(icon: Icons.phone, text: facility.phone),
            IconText(icon: Icons.access_time, text: 'Wait: ${facility.waitRange}'),
          ],
        ),
      ],
    );
  }

  Widget _buildServices() {
    final shown = facility.services.take(_maxServiceChips).toList();
    final extra = facility.services.length - shown.length;
    final labels = [...shown, if (extra > 0) '+$extra more'];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final label in labels)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(label, style: const TextStyle(fontSize: 12)),
          ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => callFacility(context, facility),
            icon: const Icon(Icons.phone, size: 18),
            label: const Text('Call'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => openDirections(context, facility),
            icon: const Icon(Icons.navigation, size: 18),
            label: const Text('Directions'),
          ),
        ),
      ],
    );
  }
}
