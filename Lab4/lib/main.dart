
import 'package:flutter/material.dart';
import 'screens/core_widgets_demo.dart';
import 'screens/input_controls_demo.dart';
import 'screens/layout_demo.dart';
import 'screens/app_structure_theme_demo.dart';
import 'screens/common_ui_fixes_demo.dart';

void main() {
  runApp(const Lab4App());
}

class Lab4App extends StatefulWidget {
  const Lab4App({super.key});

  @override
  State<Lab4App> createState() => _Lab4AppState();
}

class _Lab4AppState extends State<Lab4App> {

  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 – Flutter UI Fundamentals',
      debugShowCheckedModeBanner: false,

      
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 1,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Cấu hình Theme Tối (Dark Theme)
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 1,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      themeMode: _themeMode,

      home: MainNavigationMenu(
        isDarkMode: _themeMode == ThemeMode.dark,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}

// Màn hình Menu điều hướng chính tương ứng ảnh chụp ở Trang 1 của tài liệu PDF
class MainNavigationMenu extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const MainNavigationMenu({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> exercises = [
      {
        'title': 'Exercise 1 – Core Widgets Demo',
        'subtitle': 'Text, Image, Icon, Card, ListTile',
        'icon': Icons.widgets_outlined,
        'page': const CoreWidgetsDemo(),
      },
      {
        'title': 'Exercise 2 – Input Controls Demo',
        'subtitle': 'Slider, Switch, RadioListTile, DatePicker',
        'icon': Icons.tune_rounded,
        'page': const InputControlsDemo(),
      },
      {
        'title': 'Exercise 3 – Layout Demo',
        'subtitle': 'Column, Row, Padding, ListView',
        'icon': Icons.view_quilt_outlined,
        'page': const LayoutDemo(),
      },
      {
        'title': 'Exercise 4 – App Structure & Theme',
        'subtitle': 'Scaffold, AppBar, FAB & Dark Mode Toggle',
        'icon': Icons.color_lens_outlined,
        'page': AppStructureThemeDemo(
          isDarkMode: isDarkMode,
          onThemeChanged: onThemeChanged,
        ),
      },
      {
        'title': 'Exercise 5 – Common UI Fixes',
        'subtitle': 'Expanded, SingleChildScrollView, setState, Context',
        'icon': Icons.bug_report_outlined,
        'page': const CommonUiFixesDemo(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 – Flutter UI Fundamentals'),
        actions: [
          IconButton(
            tooltip: isDarkMode ? 'Chuyển sang chế độ Sáng' : 'Chuyển sang chế độ Tối',
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => onThemeChanged(!isDarkMode),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header Card: Thông tin sinh viên thực hiện
          Card(
            color: isDarkMode ? Colors.blueGrey.shade900 : Colors.blue.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: isDarkMode ? Colors.blue.shade700 : Colors.blue.shade200,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blue.shade600,
                    child: const Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Đặng Ngọc Toàn',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Mã sinh viên: 26A4041670',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Môn: Lập trình Di động (Lab 4)',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
            child: Text(
              'DANH SÁCH BÀI TẬP (EXERCISES)',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 4),

          // Render danh sách 5 bài tập như yêu cầu ở trang 1
          ...exercises.map((item) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    item['icon'] as IconData,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  item['title'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  item['subtitle'] as String,
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => item['page'] as Widget,
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
