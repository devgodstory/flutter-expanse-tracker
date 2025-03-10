import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String title;

  HomePage({required this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ตัวแปรเก็บข้อมูล transactions
  List<dynamic> transactions = [];

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    // ใช้ IP ของเครื่องสำหรับทดสอบบน Android Emulator
    final response = await http.get(Uri.parse('https://nodejs-expense-tracker.vercel.app/api/transactions'));

    if (response.statusCode == 200) {
      // ถ้า request สำเร็จ แปลงข้อมูล JSON เป็น List
      setState(() {
        transactions = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  // backgroundImage: AssetImage('assets/images/profile.png'), // ใช้รูปโปรไฟล์ที่มี
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome back,', style: TextStyle(fontSize: 16)),
                    Text('Marisa Khongdee', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          // Balance section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF788AFC),
                    Color(0xFF4D63E8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ยอดเงินคงเหลือ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 10),
                      Text('฿ 3500', style: TextStyle(fontSize: 42, color: Colors.white, fontWeight: FontWeight.w900)),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 160.0,
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2, offset: Offset(0, 3))],
                            ),
                            child: Column(
                              children: [
                                Text('รายรับ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                Text('฿ 500', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.green)),
                              ],
                            ),
                          ),
                          Container(
                            width: 160.0,
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2, offset: Offset(0, 3))],
                            ),
                            child: Column(
                              children: [
                                Text('รายจ่าย', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                Text('฿ 1500', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900 , color: Colors.orange)),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Latest Transactions Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ธุรกรรมล่าสุด', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                  'ดูทั้งหมด',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          ),
          // Pull-to-refresh
          Expanded(
            child: RefreshIndicator(
              onRefresh: fetchTransactions,
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  var transaction = transactions[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade50, width: 1),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: Icon(Icons.shopping_cart, color: Colors.blue),
                      title: Text(transaction['description'] ?? 'ไม่มีชื่อธุรกรรม'), // ใช้ null-aware operator
                      subtitle: Text(
                        transaction['time'] ?? 'ไม่มีเวลา', // ใช้ null-aware operator
                        style: TextStyle(fontSize: 10.0),
                      ),
                      trailing: Text(
                        '${transaction['transactionType'] == 'expense' ? '-' : '+'} ฿ ${transaction['amount'].abs()}',
                        // '${transaction['amount'] < 0 ? '-' : '+'} ฿ ${transaction['amount'].abs()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: transaction['transactionType'] == 'expense' ? Colors.red : Colors.green,
                          // color: transaction['amount'] < 0 ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
