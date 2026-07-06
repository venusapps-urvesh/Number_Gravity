import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_gravity/app/app.dart';

void main() {
  testWidgets('app renders splash while bootstrapping', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: NumberGravityApp(),
      ),
    );

    expect(find.text('Loading...'), findsOneWidget);
    await tester.pump();
  });
}
