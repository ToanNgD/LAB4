// =======================================================================
// BÀI TẬP 4: APP STRUCTURE WITH SCAFFOLD, APPBAR, FAB & THEME
// Sinh viên thực hiện: Hà Hưng Phước
// Mã sinh viên: 26A4041653
// Mục tiêu: Xây dựng cấu trúc hoàn chỉnh bằng Scaffold và đổi chủ đề Sáng / Tối
// =======================================================================

import 'package:flutter/material.dart';

class AppStructureThemeDemo extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const AppStructureThemeDemo({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<AppStructureThemeDemo> createState() => _AppStructureThemeDemoState();
}

class _AppStructureThemeDemoState extends State<AppStructureThemeDemo> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = widget.isDarkMode;

    return Scaffold(
      // 1. AppBar với tiêu đề và công tắc chuyển đổi Dark Mode
      appBar: AppBar(
        title: const Text('Exercise 4 – App Structure & Theme'),
        actions: [
          Row(
            children: [
              const Text('Dark', style: TextStyle(fontSize: 14)),
              Switch(
                value: isDark,
                onChanged: (value) {
                  widget.onThemeChanged(value);
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),

      // 2. Body: Giao diện chính hiển thị nội dung và thử nghiệm Theme
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Banner thông tin sinh viên
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark ? Colors.grey.shade700 : Colors.blue.shade200,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.badge,
                    color: isDark ? Colors.lightBlueAccent : Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Họ tên: Hà Hưng Phước | MSV: 26A4041653',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: isDark ? Colors.lightBlueAccent : Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),

            // Card mô tả cấu trúc màn hình (khớp yêu cầu trong hình PDF)
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(
                      isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                      size: 56,
                      color: isDark ? Colors.amber : Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'This is a simple screen with theme toggle.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Hiện đang dùng: ${isDark ? "Dark Mode (Chủ đề tối)" : "Light Mode (Chủ đề sáng)"}',
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Số lần bấm nút FloatingActionButton: $_counter',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Các widget kiểm chứng màu sắc ThemeData tự động đồng bộ
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _counter++;
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Tăng biến đếm'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    widget.onThemeChanged(!isDark);
                  },
                  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  label: Text(isDark ? 'Chuyển sang Sáng' : 'Chuyển sang Tối'),
                ),
              ],
            ),
          ],
        ),
      ),

      // 3. FloatingActionButton: Nút hành động nổi ở góc dưới
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tăng biến đếm',
        onPressed: () {
          setState(() {
            _counter++;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('FAB được bấm! Biến đếm hiện tại: $_counter'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
