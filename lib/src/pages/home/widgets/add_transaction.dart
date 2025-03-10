import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTransactionPage extends StatefulWidget {
  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  String transactionType = 'รายรับ';
  String selectedCategory = 'บัตรเครดิต';
  TextEditingController amountController = TextEditingController(text: ''); // ตัวควบคุมการกรอกจำนวนเงิน

  // หมวดหมู่
  List<Map<String, dynamic>> categories = [
    {"name": "บัตรเครดิต", "icon": Icons.credit_card},
    {"name": "ของใช้", "icon": Icons.shopping_bag},
    {"name": "ค่ารักษา", "icon": Icons.medication},
    {"name": "บันเทิง", "icon": Icons.theaters},
    {"name": "อื่นๆ", "icon": Icons.more_horiz},
  ];

  @override
  void initState() {
    super.initState();
  }

  // ฟังก์ชันสำหรับบันทึกรายการ
  Future<void> _saveTransaction() async {
    String amount = amountController.text;

    // แปลง transactionType ให้เป็น enum ที่ถูกต้อง
    var transactionTypeEnum = transactionType == "รายรับ" ? "income" : "expense";

    // สร้างข้อมูลที่จะส่งไป
    var transactionData = {
      'transactionType': transactionTypeEnum,
      'category': '67c9dffdb8289ddbbc471612', // Example category ID, ensure it's valid
      'user': '67c9dd75b8289ddbbc471604',   // Example user ID, ensure it's valid
      'amount': double.tryParse(amount) ?? 0.0, // Ensure amount is a valid number
      'description': '-', // Optional description
    };

    var url = Uri.parse('https://nodejs-expense-tracker.vercel.app/api/transactions');

    try {
      // ส่ง POST request ไปยัง API
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(transactionData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('บันทึกสำเร็จ')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ไม่สามารถบันทึกได้')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์')),
      );
    }
  }

  // ฟังก์ชันลบตัวเลข
  void _deleteLastCharacter() {
    if (amountController.text.isNotEmpty) {
      setState(() {
        amountController.text = amountController.text.substring(0, amountController.text.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('สร้างรายการธุรกรรม'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              onPressed: _saveTransaction,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF304FFE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                'บันทึก',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // เลือกประเภทของธุรกรรม
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        transactionType = 'รายรับ';
                      });
                    },
                    child: Text('รายรับ'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: transactionType == 'รายรับ' ? Colors.blue.shade50 : Colors.grey.shade50,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: transactionType == 'รายรับ' ? Color(0xFF304FFE) : Colors.grey.shade200, // สีของขอบ
                          width: 1, // ความหนาของขอบ
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        transactionType = 'รายจ่าย';
                      });
                    },
                    child: Text('รายจ่าย'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: transactionType == 'รายจ่าย' ? Colors.blue.shade50 : Colors.grey.shade50,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: transactionType == 'รายจ่าย' ? Color(0xFF304FFE) : Colors.grey.shade200, // สีของขอบ
                          width: 1, // ความหนาของขอบ
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // เลือกหมวดหมู่
              Text('เลือกหมวดหมู่', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Wrap(
                children: categories.map((category) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category['name'];
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          width: 80,
                          height: 50,
                          child: Column(
                            children: [
                              Icon(category['icon'], color: Colors.blue),
                              SizedBox(width: 8),
                              Text(category['name'], style: TextStyle(color: Colors.black, fontSize: 16)),
                            ],
                          ),
                        )
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              // แสดงหมวดหมู่ที่เลือก
              Text('หมวดหมู่ที่เลือก: $selectedCategory', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              // จำนวนเงิน
              Text('จำนวนเงิน', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 2)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'กรอกจำนวนเงิน',
                              hintStyle: TextStyle(fontSize: 18),
                            ),
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // แป้นพิมพ์ตัวเลข
              Row(
                children: [
                  NumberButton('7', onPressed: () => setState(() => amountController.text += '7')),
                  NumberButton('8', onPressed: () => setState(() => amountController.text += '8')),
                  NumberButton('9', onPressed: () => setState(() => amountController.text += '9')),
                ],
              ),
              Row(
                children: [
                  NumberButton('4', onPressed: () => setState(() => amountController.text += '4')),
                  NumberButton('5', onPressed: () => setState(() => amountController.text += '5')),
                  NumberButton('6', onPressed: () => setState(() => amountController.text += '6')),
                ],
              ),
              Row(
                children: [
                  NumberButton('1', onPressed: () => setState(() => amountController.text += '1')),
                  NumberButton('2', onPressed: () => setState(() => amountController.text += '2')),
                  NumberButton('3', onPressed: () => setState(() => amountController.text += '3')),
                ],
              ),
              Row(
                children: [
                  NumberButton('0', onPressed: () => setState(() => amountController.text += '0')),
                  NumberButton('del', onPressed: () => _deleteLastCharacter()),
                  // IconButton(
                  //   icon: Icon(Icons.backspace, color: Colors.black),
                  //   onPressed: _deleteLastCharacter,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget สำหรับปุ่มตัวเลข
class NumberButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  NumberButton(this.label, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
