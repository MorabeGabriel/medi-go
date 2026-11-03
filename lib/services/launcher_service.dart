import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/medical_facility.dart';

/// Opens the phone dialer with the facility's number.
Future<void> callFacility(BuildContext context, MedicalFacility facility) {
  return _open(
    context,
    Uri(scheme: 'tel', path: facility.dialableNumber),
    "Couldn't start a call to ${facility.phone}.",
  );
}

/// Opens Google Maps directions to the facility (no API key needed).
Future<void> openDirections(BuildContext context, MedicalFacility facility) {
  return _open(
    context,
    Uri.https('www.google.com', '/maps/dir/', {
      'api': '1',
      'destination': '${facility.name}, ${facility.address}',
    }),
    "Couldn't open Google Maps.",
  );
}

Future<void> _open(BuildContext context, Uri uri, String errorMessage) async {
  final messenger = ScaffoldMessenger.of(context);
  var launched = false;
  try {
    launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    launched = false;
  }
  if (!launched) {
    messenger.showSnackBar(SnackBar(content: Text(errorMessage)));
  }
}
