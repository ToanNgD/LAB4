// =======================================================================
// BÀI TẬP 2: INPUT WIDGETS (SLIDER, SWITCH, RADIOLISTTILE, DATEPICKER)
// Sinh viên thực hiện: Hà Hưng Phước
// Mã sinh viên: 26A4041653
// Mục tiêu: Xây dựng StatefulWidget cho phép người dùng tương tác và cập nhật giá trị
// =======================================================================

import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // Biến trạng thái lưu giá trị Slider (Rating: 0 - 100)
  double _rating = 50.0;

  // Biến trạng thái lưu công tắc Switch (Trạng thái phim)
  bool _isActive = true;

  // Biến trạng thái lưu thể loại phim đã chọn qua RadioListTile
  String? _selectedGenre = 'Action';

  // Biến trạng thái lưu ngày phát hành được chọn qua DatePicker
  DateTime? _selectedDate;

  // Hàm mở hộp thoại chọn ngày DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      helpText: 'CHỌN NGÀY CHIẾU PHIM',
      cancelText: 'HỦY',
      confirmText: 'CHỌN',
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2 – Input Controls'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông tin sinh viên thực hiện
            Container(
              width: double.infinity,
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
            const SizedBox(height: 20),

            // 1. Slider: Điều chỉnh mức độ đánh giá (Rating)
            const Text(
              'Rating (Slider)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _rating,
              min: 0,
              max: 100,
              divisions: 100,
              label: _rating.round().toString(),
              onChanged: (double newValue) {
                // setState thông báo cho Flutter render lại UI với giá trị mới
                setState(() {
                  _rating = newValue;
                });
              },
            ),
            Text(
              'Current value: ${_rating.round()}',
              style: const TextStyle(color: Colors.black54),
            ),
            const Divider(height: 32),

            // 2. Switch: Bật/Tắt trạng thái hoạt động (Active)
            const Text(
              'Active (Switch)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Is movie active?'),
              value: _isActive,
              onChanged: (bool value) {
                setState(() {
                  _isActive = value;
                });
              },
            ),
            const Divider(height: 32),

            // 3. RadioListTile: Nhóm chọn thể loại (Genre)
            const Text(
              'Genre (RadioListTile)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioGroup<String>(
              groupValue: _selectedGenre,
              onChanged: (String? value) {
                setState(() {
                  _selectedGenre = value;
                });
              },
              child: Column(
                children: const [
                  RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Action'),
                    value: 'Action',
                  ),
                  RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Comedy'),
                    value: 'Comedy',
                  ),
                  RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Drama'),
                    value: 'Drama',
                  ),
                ],
              ),
            ),
            Text(
              'Selected genre: ${_selectedGenre ?? "None"}',
              style: const TextStyle(color: Colors.black54),
            ),
            const Divider(height: 32),

            // 4. DatePicker: Chọn ngày phát hành
            const Text(
              'Release Date (DatePicker)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Center(
              child: OutlinedButton.icon(
                onPressed: () => _selectDate(context),
                icon: const Icon(Icons.calendar_month),
                label: const Text('Open Date Picker'),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                _selectedDate == null
                    ? 'Selected date: None'
                    : 'Selected date: ${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}',
                style: const TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 24),

            // Tóm tắt giá trị người dùng đã chọn
            Card(
              color: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tóm tắt giá trị hiện tại (Summary):',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text('• Điểm đánh giá: ${_rating.round()} / 100'),
                    Text('• Trạng thái hoạt động: ${_isActive ? "Đang chiếu (Active)" : "Ngừng chiếu (Inactive)"}'),
                    Text('• Thể loại phim: ${_selectedGenre ?? "Chưa chọn"}'),
                    Text('• Ngày chiếu: ${_selectedDate != null ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}" : "Chưa chọn"}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
