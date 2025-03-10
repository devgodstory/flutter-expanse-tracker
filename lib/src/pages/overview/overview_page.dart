import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  List<dynamic> transactions = [];
  double totalAmount = 0.0;
  String selectedMonth = '';
  List<dynamic> filteredTransactions = [];
  List<String> availableMonths = [];

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  // ฟังก์ชันดึงข้อมูลจาก API
  Future<void> fetchTransactions() async {
    final response = await http.get(Uri.parse('https://nodejs-expense-tracker.vercel.app/api/transactions'));

    if (response.statusCode == 200) {
      setState(() {
        transactions = jsonDecode(response.body);
        availableMonths = _getAvailableMonths(transactions);
        selectedMonth = availableMonths.isNotEmpty ? availableMonths[0] : ''; // เลือกเดือนแรก
        filterTransactions();  // กรองข้อมูลตามเดือนแรกที่มี
      });
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  // ฟังก์ชันที่ใช้ในการดึงเดือนที่ไม่ซ้ำ
  List<String> _getAvailableMonths(List<dynamic> transactions) {
    Set<String> monthsSet = {};
    for (var transaction in transactions) {
      if (transaction['date'] != null) {
        String month = transaction['date'].substring(0, 7); // ดึงแค่เดือน (ปี-เดือน)
        monthsSet.add(month); // เพิ่มเดือนที่ไม่ซ้ำ
      }
    }
    return monthsSet.toList(); // เปลี่ยน Set เป็น List
  }

  // ฟังก์ชันกรองธุรกรรมตามเดือนที่เลือก
  void filterTransactions() {
    setState(() {
      filteredTransactions = transactions
          .where((transaction) =>
      transaction['date'] != null && transaction['date'].substring(0, 7) == selectedMonth)
          .toList();

      // คำนวณยอดรวมทั้งหมดอีกครั้งหลังจากกรองข้อมูล
      totalAmount = filteredTransactions.fold<double>(0.0, (sum, item) {
        return sum + (item['amount'] is int ? (item['amount'] as int).toDouble() : item['amount']);
      });
    });
  }

  // ฟังก์ชันคำนวณข้อมูลสำหรับกราฟวงกลม
  List<PieChartSectionData> _getSections() {
    double total = filteredTransactions.fold<double>(0.0, (sum, item) {
      return sum + (item['amount'] is int ? (item['amount'] as int).toDouble() : item['amount']);
    });

    if (total == 0) {
      return []; // ถ้ายอดรวมเป็น 0, แสดงผลกราฟวงกลมเป็นศูนย์
    }

    return filteredTransactions.map((transaction) {
      double percentage = (transaction['amount'] / total) * 100;
      return PieChartSectionData(
        color: _getCategoryColor(transaction['category']?['name'] ?? 'อื่นๆ'), // ใช้ category.name จาก populate
        value: percentage,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  // ฟังก์ชันเพื่อกำหนดสีของแต่ละหมวดหมู่
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'บัตรเครดิต':
        return Colors.blue;
      case 'ของใช้':
        return Colors.green;
      case 'บันเทิง':
        return Colors.orange;
      case 'ค่ารักษา':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  // ฟังก์ชัน Pull-to-Refresh
  Future<void> _onRefresh() async {
    await fetchTransactions();  // ดึงข้อมูลใหม่
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ภาพรวมรายรับ - รายจ่าย'),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,  // เรียกฟังก์ชันเมื่อทำการดึงเพื่อรีเฟรช
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // เลือกเดือน
                availableMonths.isEmpty
                    ? CircularProgressIndicator()  // ถ้ายังไม่โหลดข้อมูล, แสดง loading
                    : DropdownButton<String>(
                  value: selectedMonth.isEmpty ? null : selectedMonth, // ตรวจสอบค่าของ selectedMonth
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonth = newValue ?? ''; // ถ้า newValue เป็น null จะตั้งค่าเป็นค่าว่าง
                      filterTransactions(); // Filter transactions based on selected month
                    });
                  },
                  items: availableMonths
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),

                // เพิ่มการใช้ Expanded สำหรับกราฟ
                totalAmount > 0
                    ? Center(
                  child: SizedBox(
                    height: 250, // กำหนดขนาดกราฟ
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: _getSections(),
                      ),
                    ),
                  ),
                )
                    : Center(child: Text("ไม่มีข้อมูลสำหรับเดือนที่เลือก")),

                SizedBox(height: 20),

                // แสดงยอดรวม
                Text(
                  'ยอดเงินทั้งหมด: ฿${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // แสดงข้อความ "รายละเอียดหมวดหมู่การใช้จ่าย"
                Text(
                  'รายละเอียดหมวดหมู่การใช้จ่าย',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                // ใช้ Container เพื่อป้องกันการ overflow
                Container(
                  height: 300, // กำหนดขนาดให้กับ ListView
                  child: ListView.builder(
                    shrinkWrap: true, // ใช้เพื่อป้องกันการ overflow
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      var transaction = filteredTransactions[index];
                      double percentage = totalAmount > 0
                          ? (transaction['amount'] / totalAmount) * 100
                          : 0;
                      return ListTile(
                        leading: Icon(
                          Icons.shopping_cart,
                          color: _getCategoryColor(transaction['category']?['name'] ?? 'อื่นๆ'), // ใช้ category.name จาก populate
                        ),
                        title: Text(transaction['description'] ?? 'ไม่มีชื่อ'),
                        subtitle: Text('ประเภท: ${transaction['category']?['name'] ?? 'ไม่มีข้อมูล'}'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${percentage.toStringAsFixed(0)}%',
                              style: TextStyle(
                                  color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                            Text('฿${transaction['amount'] ?? 0}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
