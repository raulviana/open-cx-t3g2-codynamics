import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:speed_meeting/locator.dart';
import 'package:speed_meeting/providers/user_provider.dart';
import 'package:speed_meeting/screens/meeting/meeting.dart';
import 'package:speed_meeting/services/auth.dart';
import 'package:speed_meeting/services/database.dart';

void main() {
  group("Meetings' test | ", () {
    setUpAll(() async {
      setUpLocator();
      locator.allowReassignment = true;
    });
    testWidgets("User with no displayName, displays email instead",
        (WidgetTester tester) async {
      //Given : set up initial conditions
      var mockAuthService = MockAuthService();
      locator.registerLazySingleton<AuthService>(() => mockAuthService);

      var userId = "beepboop";
      var userEmail = "anythingyouwant";

      var mockUser = MockUser();
      Stream<User> userStream = Stream.value(mockUser);

      when(mockUser.uid).thenReturn(userId);
      when(mockUser.displayName).thenReturn('');
      when(mockUser.email).thenReturn(userEmail);
      when(mockAuthService.user).thenAnswer((_) => userStream);

      //When : perform the actions
      await tester.pumpWidget(makeTestableWidget(child: Meeting()));
      await tester.pumpAndSettle();

      //Assert : check expected results
      expect(find.text(userEmail), findsNWidgets(2));
    });
  });
}

class MockDatabaseService extends Mock implements DatabaseService {}

class MockAuthService extends Mock implements AuthService {}

class MockUser extends Mock implements User {}

Widget makeTestableWidget({Widget child}) {
  return ChangeNotifierProvider.value(
      value: locator<UserProvider>(),
      child: MaterialApp(
        home: child,
      ),
    );}
