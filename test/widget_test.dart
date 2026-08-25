import 'package:flutter_test/flutter_test.dart';

import 'package:ui_e_commerce/main.dart';

void main() {
  testWidgets('Login screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('TealShop'), findsOneWidget);
    expect(find.text('Pembeli'), findsOneWidget);
    expect(find.text('Admin'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
