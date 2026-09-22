// =======================================================================
// BÀI TẬP 5: DEBUG & FIX COMMON UI ERRORS
// Sinh viên thực hiện: Hà Hưng Phước
// Mã sinh viên: 26A4041653
// Mục tiêu: Khắc phục và giải thích 4 lỗi giao diện thường gặp nhất trong Flutter
// 1. Sửa lỗi ListView trong Column bằng Expanded
// 2. Sửa lỗi tràn màn hình (Overflow) bằng SingleChildScrollView
// 3. Sửa lỗi không cập nhật UI bằng setState()
// 4. Sửa lỗi BuildContext không hợp lệ khi gọi DatePicker
// =======================================================================

import 'package:flutter/material.dart';

class CommonUiFixesDemo extends StatefulWidget {
  const CommonUiFixesDemo({super.key});

  @override
  State<CommonUiFixesDemo> createState() => _CommonUiFixesDemoState();
}

class _CommonUiFixesDemoState extends State<CommonUiFixesDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // State cho Task 3: Thử nghiệm setState
  int _counter = 0;
  String _lastActionText = 'Chưa có thao tác nào';

  // State cho Task 4: DatePicker với BuildContext hợp lệ
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 – Common UI Fixes'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.view_list), text: '1. ListView + Column'),
            Tab(icon: Icon(Icons.screen_rotation), text: '2. Overflow Fix'),
            Tab(icon: Icon(Icons.refresh), text: '3. setState Fix'),
            Tab(icon: Icon(Icons.calendar_today), text: '4. DatePicker Context'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Banner thông tin sinh viên cố định trên đầu trang
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: const Row(
              children: [
                Icon(Icons.badge, color: Colors.blue, size: 20),
                SizedBox(width: 8),
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

          // Nội dung các tab giải quyết 4 lỗi
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTask1ExpandedListView(),
                _buildTask2SingleChildScrollView(),
                _buildTask3SetStateDemo(),
                _buildTask4DatePickerContext(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // TASK 1: Fix ListView inside Column using Expanded (Khớp ảnh giao diện mẫu)
  // Lỗi gốc: ListView mặc định vô hạn chiều cao (unbounded height), khi đặt
  // trong Column (cũng vô hạn chiều dọc) sẽ văng ngoại lệ:
  // "Vertical viewport was given unbounded height".
  // Khắc phục: Bao bọc ListView bằng widget Expanded (hoặc Flexible).
  // =========================================================================
  Widget _buildTask1ExpandedListView() {
    final List<String> sampleMovies = [
      'Movie A',
      'Movie B',
      'Movie C',
      'Movie D',
      'Movie E',
      'Movie F',
      'Movie G',
      'Movie H',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề giải thích khớp chính xác giao diện trong PDF:
        // "Correct ListView inside Column using Expanded"
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Correct ListView inside Column using Expanded',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Giải thích: Column cung cấp chiều cao vô hạn, ListView cần kích thước xác định. Bọc bằng Expanded giúp ListView chiếm trọn chiều cao còn lại.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),

        // Sửa lỗi bằng cách bao bọc ListView trong Expanded
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: sampleMovies.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(
                  Icons.local_movies_rounded,
                  color: Colors.blueGrey,
                ),
                title: Text(
                  sampleMovies[index],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Đã chọn: ${sampleMovies[index]}'),
                      duration: const Duration(milliseconds: 700),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // TASK 2: Fix overflow in small screens using SingleChildScrollView
  // Lỗi gốc: Khi nội dung trong Column hoặc Row vượt quá kích thước màn hình
  // (ví dụ thiết bị nhỏ hoặc khi mở bàn phím ảo), Flutter báo lỗi:
  // "A RenderFlex overflowed by xxx pixels" với vạch vàng đen.
  // Khắc phục: Bao bọc nội dung bằng SingleChildScrollView.
  // =========================================================================
  Widget _buildTask2SingleChildScrollView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Colors.amber.shade50,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.orange.shade800),
                      const SizedBox(width: 8),
                      const Text(
                        'Nguyên nhân lỗi RenderFlex Overflow:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Khi tổng chiều cao các phần tử con vượt quá chiều cao màn hình (hoặc bàn phím trồi lên), Column thông thường sẽ bị tràn pixel và báo lỗi sọc vàng đen.',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Cách khắc phục: Bọc toàn bộ nội dung trong SingleChildScrollView để kích hoạt khả năng cuộn mượt mà.',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Form mẫu chứa nhiều ô nhập liệu để minh chứng khả năng chống tràn
          for (int i = 1; i <= 6; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Thông tin trường #$i (Thử cuộn màn hình)',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.edit),
                ),
              ),
            ),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nội dung cuộn an toàn không bị tràn!')),
              );
            },
            icon: const Icon(Icons.check_circle),
            label: const Text('Xác nhận & Kiểm tra cuộn an toàn'),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // TASK 3: Fix state update issue by adding setState()
  // Lỗi gốc: Lập trình viên thay đổi biến cục bộ nhưng quên gọi setState(),
  // khiến framework Flutter không kích hoạt build() lại UI.
  // Khắc phục: Bao bọc lệnh gán giá trị biến bên trong setState(() { ... }).
  // =========================================================================
  Widget _buildTask3SetStateDemo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: Colors.green.shade50,
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Nguyên tắc State: Flutter sử dụng Declarative UI. Khi một biến dữ liệu thay đổi, ta bắt buộc phải gọi setState() để thông báo widget tree tiến hành re-render.',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Giá trị Counter: $_counter',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Trạng thái: $_lastActionText',
            style: const TextStyle(color: Colors.blueGrey, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Nút mô phỏng LỖI: Quên setState (không cập nhật giao diện)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100),
                onPressed: () {
                  // LỖI: Tăng biến nhưng không gọi setState -> UI không đổi!
                  _counter++;
                  _lastActionText = 'Đã tăng biến nhưng KHÔNG gọi setState (UI không đổi)';
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Giá trị biến đã tăng trong bộ nhớ nhưng UI chưa re-render do thiếu setState()!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Bấm KHÔNG setState\n(Gây lỗi)', textAlign: TextAlign.center),
              ),
              const SizedBox(width: 16),
              // Nút ĐÃ SỬA LỖI: Có gọi setState
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // ĐÃ SỬA: Gọi setState để cập nhật UI ngay lập tức
                  setState(() {
                    _counter++;
                    _lastActionText = 'Đã gọi setState() thành công (UI cập nhật)';
                  });
                },
                child: const Text('Bấm CÓ setState\n(Đã sửa lỗi)', textAlign: TextAlign.center),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () {
              setState(() {
                _counter = 0;
                _lastActionText = 'Đã đặt lại về 0';
              });
            },
            icon: const Icon(Icons.restart_alt),
            label: const Text('Reset Counter'),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // TASK 4: Fix DatePicker build context errors by calling from valid widget tree
  // Lỗi gốc: Gọi showDatePicker sử dụng context chưa gắn vào Navigator (hoặc
  // gọi trong initState khi tree chưa sẵn sàng, hoặc widget đã unmounted).
  // Khắc phục:
  // 1. Sử dụng BuildContext hợp lệ nằm dưới Navigator.
  // 2. Kiểm tra if (!mounted) return trước khi cập nhật State sau async.
  // =========================================================================
  Widget _buildTask4DatePickerContext() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            color: Colors.purple.shade50,
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nguyên nhân lỗi BuildContext khi dùng DatePicker:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '1. Context nằm ngoài MaterialApp/Navigator khiến showDatePicker không tìm thấy Navigator.\n'
                    '2. Context bị hủy (unmounted) trong khi chờ async khiến việc gọi setState gây memory leak.\n'
                    'Khắc phục: Sử dụng Builder widget hoặc BuildContext trong build() đã có Navigator và luôn kiểm tra "if (!mounted) return".',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _selectedDate == null
                ? 'Chưa chọn ngày'
                : 'Ngày đã chọn: ${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Sử dụng Builder để đảm bảo có BuildContext con hợp lệ nằm chuẩn dưới Scaffold & Navigator
          Builder(
            builder: (BuildContext validContext) {
              return ElevatedButton.icon(
                onPressed: () async {
                  // Gọi showDatePicker với validContext
                  final DateTime? picked = await showDatePicker(
                    context: validContext,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );

                  // Kiểm tra mounted để đảm bảo State vẫn còn sống
                  if (!mounted) return;

                  if (picked != null) {
                    setState(() {
                      _selectedDate = picked;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Đã chọn ngày hợp lệ: ${picked.day}/${picked.month}/${picked.year}'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.date_range),
                label: const Text('Mở DatePicker với Valid BuildContext'),
              );
            },
          ),
        ],
      ),
    );
  }
}
