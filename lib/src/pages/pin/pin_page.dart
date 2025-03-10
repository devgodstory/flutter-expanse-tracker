import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/src/pages/home/home_screen.dart';

class PinEntryScreen extends StatefulWidget {
  @override
  _PinEntryScreenState createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  String enteredPin = "";
  final String correctPin = "123456";

  void _onKeyPressed(String value) {
    if (value != "") {
      if (value == "del") {
        if (enteredPin.isNotEmpty) {
          setState(() {
            enteredPin = enteredPin.substring(0, enteredPin.length - 1);
          });
        }
      } else {
        if (enteredPin.length < 6) {
          setState(() {
            enteredPin += value;
          });
        }
      }
    }
  }

  void _onSubmit() {
    if (enteredPin == correctPin) {
      Navigator.push(
        context,
        // MaterialPageRoute(builder: (context) => SuccessScreen()),
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("รหัสไม่ถูกต้อง! ลองใหม่อีกครั้ง")),
      );
    }
  }

  Widget _buildPinDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: index < enteredPin.length ? Color(0xFF304FFE) : Colors.grey[300],
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildKeypad() {
    List<String> keys = [
      "7", "8", "9",
      "4", "5", "6",
      "1", "2", "3",
      "", "0", "del"
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
      ),
      itemCount: keys.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _onKeyPressed(keys[index]),
          child: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: keys[index] == "del"
                  ? Icon(Icons.backspace, color: Color(0xFF304FFE))
                  : Text(
                keys[index],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "กรุณากรอกรหัส\nเพื่อเข้าสู่ระบบ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildPinDots(),
            SizedBox(height: 20),
            _buildKeypad(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: enteredPin.length == 6 ? _onSubmit : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF304FFE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: Text("เข้าสู่ระบบ", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "เข้าสู่ระบบสำเร็จ!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    );
  }
}
