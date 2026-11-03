import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medi_go/main.dart';
import 'package:medi_go/screens/login_screen.dart';
import 'package:medi_go/widgets/facility_card.dart';

/// Use a tall phone-sized surface so the whole screen is built and tappable.
void useTallScreen(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 3000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

Future<void> signInWithDemo(WidgetTester tester) async {
  await tester.pumpWidget(const MediGoApp());
  await tester.enterText(find.byKey(const Key('emailField')), demoEmail);
  await tester.enterText(find.byKey(const Key('passwordField')), demoPassword);
  await tester.tap(find.text('Sign In'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('rejects wrong credentials', (tester) async {
    useTallScreen(tester);
    await tester.pumpWidget(const MediGoApp());

    await tester.enterText(find.byKey(const Key('emailField')), 'a@b.com');
    await tester.enterText(find.byKey(const Key('passwordField')), 'nope');
    await tester.tap(find.text('Sign In'));
    await tester.pump();

    expect(find.text('Incorrect email or password.'), findsOneWidget);
    expect(find.text('Find Medical Facilities Near You'), findsNothing);
  });

  testWidgets('demo account signs in and lists facilities', (tester) async {
    useTallScreen(tester);
    await signInWithDemo(tester);

    expect(find.text('Find Medical Facilities Near You'), findsOneWidget);
    expect(find.byType(FacilityCard), findsNWidgets(6));
  });

  testWidgets('search and type filter narrow the list', (tester) async {
    useTallScreen(tester);
    await signInWithDemo(tester);

    await tester.enterText(find.byKey(const Key('searchField')), 'lakeview');
    await tester.pump();
    expect(find.byType(FacilityCard), findsOneWidget);
    expect(find.text('Lakeview Pharmacy'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('searchField')), 'zzzz');
    await tester.pump();
    expect(find.text('No facilities found'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('searchField')), '');
    await tester.tap(find.widgetWithText(ChoiceChip, 'Clinic'));
    await tester.pump();
    expect(find.byType(FacilityCard), findsNWidgets(2));
    expect(find.text('Sunrise Family Clinic'), findsOneWidget);
    expect(find.text('Lakeview Pharmacy'), findsNothing);
  });
}
