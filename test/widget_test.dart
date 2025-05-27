void main() {
  List<String> names = ['Ali', 'Sara', 'Mohammed', 'Salma'];

  // Filter names that start with the letter 'S'
  List<String> namesStartingWithS = filterNamesStartingWith(names, 'S');

  print('Names starting with S: $namesStartingWithS');
}

/// Returns a list of names that start with the given letter
List<String> filterNamesStartingWith(List<String> names, String letter) {
  return names.where((name) => name.startsWith(letter)).toList();
}


// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:flutter_personal_website/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
