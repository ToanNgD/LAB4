// Test cơ bản kiểm tra ứng dụng Lab 4 khởi chạy và hiển thị đầy đủ thông tin
import 'package:flutter_test/flutter_test.dart';
import 'package:lab4/main.dart';

void main() {
  testWidgets('Lab4App smoke test - verifies student info and exercise list',
      (WidgetTester tester) async {
    // Build app Lab 4
    await tester.pumpWidget(const Lab4App());

    // Kiểm tra hiển thị tên sinh viên Hà Hưng Phước và Mã sinh viên 26A4041653
    expect(find.text('Hà Hưng Phước'), findsOneWidget);
    expect(find.text('Mã sinh viên: 26A4041653'), findsOneWidget);

    // Kiểm tra hiển thị đủ 5 bài tập
    expect(find.text('Exercise 1 – Core Widgets Demo'), findsOneWidget);
    expect(find.text('Exercise 2 – Input Controls Demo'), findsOneWidget);
    expect(find.text('Exercise 3 – Layout Demo'), findsOneWidget);
    expect(find.text('Exercise 4 – App Structure & Theme'), findsOneWidget);
    expect(find.text('Exercise 5 – Common UI Fixes'), findsOneWidget);
  });
}
