// balance_card.dart

import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ยินดีต้อนรับกลับ, Marisa Khongdee',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  radius: 20,
                  // backgroundImage: AssetImage('assets/images/profile.png'),  // ใช้ภาพโปรไฟล์
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'ยอดเงินคงเหลือ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '฿ 3500',
              style: TextStyle(fontSize: 32, color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('รายรับ', style: TextStyle(fontSize: 14)),
                    Text('฿ 500', style: TextStyle(fontSize: 18, color: Colors.green)),
                  ],
                ),
                Column(
                  children: [
                    Text('รายจ่าย', style: TextStyle(fontSize: 14)),
                    Text('฿ 1500', style: TextStyle(fontSize: 18, color: Colors.orange)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
