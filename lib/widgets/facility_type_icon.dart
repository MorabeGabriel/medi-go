import 'package:flutter/material.dart';

import '../models/medical_facility.dart';

extension FacilityTypeIcon on FacilityType {
  IconData get icon {
    switch (this) {
      case FacilityType.hospital:
        return Icons.local_hospital;
      case FacilityType.clinic:
        return Icons.medical_services;
      case FacilityType.pharmacy:
        return Icons.local_pharmacy;
    }
  }
}
