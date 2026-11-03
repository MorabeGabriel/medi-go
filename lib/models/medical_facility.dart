enum FacilityType {
  hospital('Hospital'),
  clinic('Clinic'),
  pharmacy('Pharmacy');

  const FacilityType(this.label);

  final String label;
}

class MedicalFacility {
  const MedicalFacility({
    required this.name,
    required this.type,
    required this.address,
    required this.distanceKm,
    required this.rating,
    required this.phone,
    required this.waitMinMinutes,
    required this.waitMaxMinutes,
    required this.isOpen,
    required this.is24Hours,
    required this.services,
  });

  final String name;
  final FacilityType type;
  final String address;
  final double distanceKm;
  final double rating;
  final String phone;
  final int waitMinMinutes;
  final int waitMaxMinutes;
  final bool isOpen;
  final bool is24Hours;
  final List<String> services;

  /// e.g. "1.5 km"
  String get distanceText => '${distanceKm.toStringAsFixed(1)} km';

  /// e.g. "15–25 min"
  String get waitRange => '$waitMinMinutes–$waitMaxMinutes min';

  /// Phone number reduced to digits and "+", safe for a `tel:` link.
  String get dialableNumber => phone.replaceAll(RegExp(r'[^\d+]'), '');

  /// Case-insensitive match against name, address, type and services.
  bool matches(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return name.toLowerCase().contains(q) ||
        address.toLowerCase().contains(q) ||
        type.label.toLowerCase().contains(q) ||
        services.any((service) => service.toLowerCase().contains(q));
  }
}
