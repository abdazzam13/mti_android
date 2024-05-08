import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart'; // Import Mockito
import 'package:mti_android/view/Login/controller/LoginController.dart';
import 'package:mti_android/view/Login/view/LoginScreen.dart';
// Buat class Mock untuk LoginController
class MockLoginController extends Mock implements LoginController {}

void main() {
  group('Login Screen Test', () {
    testWidgets('Login with username and password Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Find text fields for username and password
      final usernameTextField = find.byKey(Key('username'));
      final passwordTextField = find.byKey(Key('password'));

      // Enter username and password
      await tester.enterText(usernameTextField, 'your_username');
      await tester.enterText(passwordTextField, 'your_password');

      // Tap the "Login" button
      final loginButton = find.byKey(ValueKey('login'));
      expect(loginButton, findsOneWidget);
      await tester.tap(loginButton);
      await tester.pump();
    });
  });
}
