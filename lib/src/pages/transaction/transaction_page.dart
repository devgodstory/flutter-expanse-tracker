import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  // จำลองข้อมูลธุรกรรมในรูปแบบ JSON
  final String transactionsJson = '''
  [
    {"name": "ข้าวเข้า", "amount": -45, "time": "25 ก.พ. - 09:54", "category": "อาหาร"},
    {"name": "งานพิเศษ", "amount": 100, "time": "25 ก.พ. - 08:00", "category": "รายรับ"},
    {"name": "เครื่องสำอาง", "amount": -250, "time": "24 ก.พ. - 20:00", "category": "ของใช้"},
    {"name": "ข้าวเย็น", "amount": -50, "time": "24 ก.พ. - 17:45", "category": "อาหาร"},
    {"name": "ข้าวเย็น", "amount": -20, "time": "24 ก.พ. - 13:22", "category": "อาหาร"},
    {"name": "ซาเย็น", "amount": -20, "time": "24 ก.พ. - 13:00", "category": "อาหาร"}
  ]
  ''';

  // ตัวแปรสำหรับเก็บข้อมูลธุรกรรมที่แปลงจาก JSON
  List<dynamic> transactions = [];
  List<dynamic> filteredTransactions = [];
  String selectedCategory = 'รายจ่าย';  // เริ่มต้นเลือก 'รายจ่าย'

  @override
  void initState() {
    super.initState();
    transactions = jsonDecode(transactionsJson);
    filterTransactions();
  }

  // ฟังก์ชันกรองธุรกรรมตามประเภท
  void filterTransactions() {
    setState(() {
      filteredTransactions = transactions
          .where((transaction) => (selectedCategory == 'รายรับ')
          ? transaction['amount'] > 0
          : transaction['amount'] < 0)
          .toList();
    });
  }

  // ฟังก์ชันดึงข้อมูลจาก API
  Future<void> fetchTransactions() async {
    // ใช้ IP ของเครื่องสำหรับทดสอบบน Android Emulator
    final response = await http.get(Uri.parse('https://nodejs-expense-tracker.vercel.app/api/transactions'));

    if (response.statusCode == 200) {
      // ถ้า request สำเร็จ แปลงข้อมูล JSON เป็น List
      setState(() {
        transactions = jsonDecode(response.body);
        filterTransactions();  // รีเฟรชข้อมูลที่แสดง
      });
    } else {
      // ถ้าเกิดข้อผิดพลาด
      throw Exception('Failed to load transactions');
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
        title: Text('รายการธุรกรรม'),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,  // เรียกฟังก์ชันเมื่อทำการดึงเพื่อรีเฟรช
        child: Column(
          children: [
            // เลือกประเภทธุรกรรม (รายรับ/รายจ่าย)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: selectedCategory == 'รายรับ' ? Colors.blue : Colors.grey[300],
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'รายรับ';
                          filterTransactions();
                        });
                      },
                      child: Text(
                        'รายรับ',
                        style: TextStyle(
                          color: selectedCategory == 'รายรับ' ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: selectedCategory == 'รายจ่าย' ? Colors.blue : Colors.grey[300],
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'รายจ่าย';
                          filterTransactions();
                        });
                      },
                      child: Text(
                        'รายจ่าย',
                        style: TextStyle(
                          color: selectedCategory == 'รายจ่าย' ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // แสดงรายการธุรกรรม
            Expanded(
              child: ListView.builder(
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  var transaction = filteredTransactions[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blue.shade50,
                          width: 1),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: Icon(Icons.shopping_cart, color: Colors.blue),
                      title: Text(transaction['description'] ?? 'ไม่มีชื่อธุรกรรม'),  // ใช้ null-aware operator
                      subtitle: Text(
                        transaction['time'] ?? 'ไม่มีเวลา',  // ใช้ null-aware operator
                        style: TextStyle(fontSize: 10.0),
                      ),
                      trailing: Text(
                        '${transaction['amount'] < 0 ? '-' : '+'} ฿ ${transaction['amount'].abs()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: transaction['amount'] < 0
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
