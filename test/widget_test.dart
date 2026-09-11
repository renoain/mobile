import 'package:flutter_test/flutter_test.dart';

import 'package:kkos/app.dart';

void main() {
  testWidgets('App renders KKOS title', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('KKOS'), findsOneWidget);
  });
}
