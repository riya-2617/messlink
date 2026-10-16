import 'package:flutter_test/flutter_test.dart';
import 'package:messlink_app/main.dart';

void main() {
  testWidgets('MessLink landing page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MessLinkApp());

    // Verify that the core decision gate is rendered.
    expect(find.text('Are you here to Eat or Manage a Mess?'), findsOneWidget);
    expect(find.text('Eat at a Mess'), findsOneWidget);
    expect(find.text('Manage a Mess'), findsOneWidget);
  });
}
