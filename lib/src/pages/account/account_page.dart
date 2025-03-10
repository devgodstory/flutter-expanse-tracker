import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccountPage(),
      theme: ThemeData(
        fontFamily: 'CustomFontIBMPlexSansThai',
      ),
    );
  }
}

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isLoggedIn = false;
  bool notificationsEnabled = true; // ค่าเริ่มต้นการแจ้งเตือนเปิดใช้งาน

  // ฟังก์ชันสำหรับการเข้าสู่ระบบและออกจากระบบ
  void _loginLogout() {
    setState(() {
      isLoggedIn = !isLoggedIn;
    });
  }

  // ฟังก์ชันแสดงการตั้งค่าบัญชี
  void _goToAccountSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountSettingsPage()),
    );
  }

  // ฟังก์ชันแสดงการตั้งค่าการแจ้งเตือน
  void _goToNotificationSettings() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('การตั้งค่าการแจ้งเตือน'),
          content: Row(
            children: [
              Text('เปิดการแจ้งเตือน'),
              Switch(
                value: notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ปิดการตั้งค่าการแจ้งเตือน
              },
              child: Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('บัญชีของฉัน'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // เมนูสำหรับเข้าสู่ระบบ/ออกจากระบบ
            ListTile(
              leading: Icon(isLoggedIn ? Icons.exit_to_app : Icons.login),
              title: Text(isLoggedIn ? 'ออกจากระบบ' : 'เข้าสู่ระบบ'),
              onTap: _loginLogout,
            ),
            Divider(),
            // เมนูตั้งค่าบัญชี
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('ตั้งค่าบัญชี'),
              onTap: () => _goToAccountSettings(context),
            ),
            Divider(),
            // เมนูตั้งค่าการแจ้งเตือน
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('ตั้งค่าการแจ้งเตือน'),
              onTap: _goToNotificationSettings,
            ),
            Divider(),
            // แสดงสถานะการเข้าสู่ระบบ
            if (isLoggedIn)
              Text('ยินดีต้อนรับ, คุณสามารถเข้าถึงข้อมูลต่างๆ ได้'),
            if (!isLoggedIn)
              Text('กรุณาเข้าสู่ระบบเพื่อเข้าถึงข้อมูล'),
          ],
        ),
      ),
    );
  }
}

// หน้า Account Settings สำหรับการแก้ไขข้อมูลส่วนตัว
class AccountSettingsPage extends StatefulWidget {
  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "John Doe";
  String _email = "johndoe@example.com";

  // ฟังก์ชันบันทึกข้อมูล
  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ข้อมูลของคุณถูกบันทึก')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตั้งค่าบัญชี'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ข้อมูลส่วนตัว',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // ฟอร์มการกรอกข้อมูล
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'ชื่อ'),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกชื่อ';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'อีเมล'),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกอีเมล';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('บันทึกข้อมูล'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
