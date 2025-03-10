import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions = [
    {"name": "ข้าวเข้า", "amount": -45, "time": "25 ก.พ. - 09:54"},
    {"name": "งานพิเศษ", "amount": 100, "time": "25 ก.พ. - 08:00"},
    {"name": "เครื่องสำอาง", "amount": -250, "time": "24 ก.พ. - 20:00"},
    {"name": "ข้าวเย็น", "amount": -50, "time": "24 ก.พ. - 17:45"},
    {"name": "ข้าวเย็น", "amount": -20, "time": "24 ก.พ. - 13:22"},
    {"name": "ซาเย็น", "amount": -20, "time": "24 ก.พ. - 13:00"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        var transaction = transactions[index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black), // เส้นขอบสีเทาอ่อน
            borderRadius: BorderRadius.circular(8), // มุมโค้งเล็กน้อย
          ),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8), // ระยะห่างรอบ item
          child: ListTile(
            leading: Icon(Icons.shopping_cart, color: Colors.blue),
            title: Text(transaction['name']),
            subtitle: Text(transaction['time']),
            trailing: Text(
              '฿ ${transaction['amount']}',
              style: TextStyle(
                color: transaction['amount'] < 0 ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
