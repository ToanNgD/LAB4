// =======================================================================
// BÀI TẬP 3: LAYOUT BASICS (COLUMN, ROW, PADDING, LISTVIEW)
// Sinh viên thực hiện: Hà Hưng Phước
// Mã sinh viên: 26A4041653
// Mục tiêu: Xây dựng bố cục phân chia theo section tương tự màn hình Home thực tế
// =======================================================================

import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  // Danh sách các bộ phim mẫu để hiển thị trong ListView.builder
  static const List<Map<String, String>> movies = [
    {
      'title': 'Avatar',
      'genre': 'Sci-Fi / Adventure',
      'description': 'Sample description',
    },
    {
      'title': 'Inception',
      'genre': 'Action / Sci-Fi',
      'description': 'Sample description',
    },
    {
      'title': 'Interstellar',
      'genre': 'Adventure / Drama',
      'description': 'Sample description',
    },
    {
      'title': 'Joker',
      'genre': 'Crime / Drama',
      'description': 'Sample description',
    },
    {
      'title': 'Oppenheimer',
      'genre': 'Biography / Drama',
      'description': 'Sample description',
    },
    {
      'title': 'The Dark Knight',
      'genre': 'Action / Crime',
      'description': 'Sample description',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Khoảng cách quy chuẩn theo yêu cầu bài học (8, 12, 16 px)
    const double spacingSmall = 8.0;
    const double spacingMedium = 12.0;
    const double spacingLarge = 16.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 – Layout Demo'),
      ),
      // Sử dụng Column để tạo các section theo chiều dọc
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Banner thông tin sinh viên
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: spacingLarge,
              vertical: spacingSmall,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: spacingSmall,
                horizontal: spacingMedium,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.badge, color: Colors.blue, size: 20),
                  SizedBox(width: spacingSmall),
                  Expanded(
                    child: Text(
                      'Họ tên: Hà Hưng Phước | MSV: 26A4041653',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Section 2: Header section sử dụng Row và Text
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: spacingLarge,
              vertical: spacingSmall,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Now Playing',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Xem toàn bộ danh sách')),
                    );
                  },
                  child: const Text('See all'),
                ),
              ],
            ),
          ),

          const SizedBox(height: spacingSmall),

          // Section 3: Danh sách ListView.builder tối ưu hiển thị danh sách dài
          // Sử dụng Expanded để ListView chiếm trọn phần không gian còn lại trong Column
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: spacingLarge),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                final initialChar = movie['title']!.substring(0, 1);

                return Padding(
                  padding: const EdgeInsets.only(bottom: spacingMedium),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.2),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: spacingLarge,
                        vertical: spacingSmall,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        foregroundColor: Colors.blue.shade800,
                        child: Text(
                          initialChar,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        movie['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        movie['description']!,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Đã chọn phim: ${movie['title']}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
