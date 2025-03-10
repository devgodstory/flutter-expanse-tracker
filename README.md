# flutter_expense_tracker

## My Readme

ลง Android Studio และ Xcode ให้เรียบร้อย

# ขั้นตอนการสร้างโปรเจค (ใน Android Studio)
*** ใน Android Studio เพิ่ม Extension Flutter Enhancement Suite ใช้เพื่อช่วย generate code flutter
- ตั้งชื่อโปรเจค : ตามที่เราต้องการ เช่น mystock
- ตั้งชื่อ Package name (เป็นเหมือนเลขประจำตัวประชาชนของแอพ) (ตัวอย่าง) : com.mycompany.mystock
- Platform Chanel language (เลือก Kotlin กับ Swift ได้เลย)


# ขั้นตอนการสร้างโปรเจค (ใน VS code ปัจจุบันแนะนำวิธีนี้)
*** ติดตั้ง Flutter และ Dart extension ใน VSCode โดยเปิด VSCode แล้วไปที่ Extensions (หรือกด Ctrl + Shift + X), ค้นหา "Flutter" และ "Dart" แล้วติดตั้ง
- เปิด VSCode แล้วกด Ctrl + Shift + P (Windows/Linux) หรือ Cmd + Shift + P (macOS) เพื่อเปิด Command Palette
- พิมพ์คำว่า Flutter: New Project แล้วกด Enter
- เลือกประเภทของโปรเจคที่ต้องการสร้าง เช่น "Flutter Application"
- กำหนดชื่อโปรเจคและเลือกโฟลเดอร์ที่จะเก็บโปรเจค
- เมื่อโปรเจคถูกสร้างเสร็จ VSCode จะเปิดไฟล์โปรเจคขึ้นมา

# ทดสอบ Run โปรเจค แนะนำบน Android Studio
*** Create Device Android ก่อน แล้วค่อยกด Run
*** ถ้าจะทดสอบ iOS ให้เปิด Simulator ของ iOS ขึ้นมาก่อน ค่อยมากด Run ใน Android Studio (ถ้าติดปัญหาเรื่อง pod ให้ลง cocoapods ก่อน)
$ sudo gem install cocoapods


# โปรเจค Structure พื้นฐาน
- โฟลเดอร์ android และ ios เอาไว้เขียน code ด้วย Native ของแต่ละภาษาได้ เช่น java, kotlin, swift
- pubspec.yaml เป็นไฟล์เอาไว้ config ของ Flutter (ต้องพิมพ์ให้ถูก Format เท่านั้น)
- โฟลเดอร์ lib จะมี main.dart การเขียน code จะเริ่มต้นจากตรงนี้


# Custom โปรเจค Structure
- โฟลเดอร์ src (ที่สร้างขึ้นเอง) ที่อยู่ในโฟลเดอร์ lib *** ภายใน src จะมีโฟลเดอร์ - widgets :: widgets ที่เราสร้างเองที่เอาไว้แชร์ใช้ในหลายๆหน้าจอ เช่น Dialog ต่างๆ  - config :: เอาไว้ config ทั่วไปในแอพ เช่น เส้นทาง, ธีม, Preferance หรือ Settings ต่างๆ - constants :: เอาไว้เก็บค่าคงที่ต่างๆ เช่น รูปภาพ, Api, หรือ Settings ที่เป็นค่าคงที่ - models :: เป็น Class ที่เอาไว้ Mapping Network - pages :: หน้าจอต่างๆ - services :: บริการต่างๆ เช่น การติดต่อ Network - utils :: Utilities ชุดฟังก์ชันหรือเครื่องมือ จะเน้นไปที่การทำงานที่ใช้ซ้ำๆ


# พื้นฐาน StatelessWidget กับ StatefulWidget
- StatelessWidget: ใช้เมื่อ UI ไม่ต้องการเปลี่ยนแปลงสถานะในระหว่างที่แอปทำงาน (static)
- StatefulWidget: ใช้เมื่อ UI ต้องการการเปลี่ยนแปลงสถานะระหว่างที่แอปทำงาน (dynamic)


# การจัด Format Code
- command + option + l (แอล)


# setState ใช้ได้แค่ใน StatefulWidget เท่านั้น
*** setState เป็นคำสั่งสำหรับ reDraw  *** เมื่อใช้คำสั่ง setState ฤังก์ชัน build จะถูก build ใหม่หรือสร้างใหม่
ตัวอย่าง
setState(() {

});

# การสร้างไฟล์ใหม่
- คลิกขวาที่โฟลเดอร์ที่จะเก็บไฟล์ -> new -> Dart File หรือตั้งชื่อไฟล์เป็น .dart เช่น abc_defg.dart
- ถ้ายังไม่รู้ว่าจะมีการเปลี่ยนแปลงหรือเปล่า ให้ใช้ StatelessWidget ไปก่อน คีย์ลัด stl

# Widgets ที่ใช้บ่อย
- Column แนวตั้ง
- Row แนวนอน
- Scaffold เป็น widget ที่ใช้สร้างโครงสร้างหลักของหน้าจอแอป เช่น AppBar, Drawer, และเนื้อหาหลักของหน้า ช่วยให้การจัดการ layout ง่ายและเป็นระเบียบ
- Child (มี widget อันเดียว)
- Chidrean (มี widget ได้หลายอัน)
- Stack ทำให้ widgets ขึ้นซ้อนกันได้

# คลิกไปหน้าอื่น
- Navogator.pushName

# ที่รวบรวม Package ต่างๆให้โหลดใช้ได้ของ dart
- pub.dev

# Flutter Outline
- c หมายถึงคลาส
- m หมายถึง Method
- f คือฟิลด์หหรือตัวแปร


# เครื่องมือแนะนำ
- Flutter DevTools ใน Android Studio ให้คลิกที่เมนู View > Tool Windows และดูว่ามี "Flutter DevTools ให้เลือกหรือไม่ Flutter DevTools คือ เครื่องมือที่ช่วยให้คุณดีบักและวิเคราะห์ประสิทธิภาพของแอป Flutter โดยตรวจสอบการใช้ CPU, หน่วยความจำ, เครือข่าย, และ UI ได้ง่ายขึ้น.
- Flutter Inspector คือเครื่องมือที่ช่วยให้คุณดูและตรวจสอบโครงสร้างของ widget tree ในแอป Flutter เพื่อช่วยในการดีบักและปรับปรุง UI ให้ถูกต้อง.


# คีย์ลัด
- command + option + l (แอล) ใช้จัด Format Code
- Ctrl + Spacebar กดแล้วจะมีการแนะนำ code เด้งขึ้นมา (บางเครื่องอาจตรงกับฟังชันเปลี่ยนภาษาขออง Macbook ต้องตั้งค่าเพิ่ม)



# กรณีมีปัญหา
ข้อผิดพลาด "zsh: command not found: flutter" หมายความว่า terminal ของคุณไม่สามารถหาคำสั่ง flutter ได้ ซึ่งแสดงว่า Flutter อาจไม่ได้ติดตั้ง หรือไม่ได้ตั้งค่า PATH ให้ถูกต้อง
ลองทำตามขั้นตอนนี้เพื่อแก้ไขปัญหา:

ตั้งค่า PATH สำหรับ Flutter
หลังจากติดตั้ง Flutter แล้ว คุณต้องตั้งค่า PATH ให้สามารถเรียกใช้ Flutter จาก terminal ได้:
เปิด terminal และพิมพ์คำสั่ง nano ~/.zshrc
 เพิ่มบรรทัดนี้เข้าไปที่ไฟล์ export PATH="$PATH:[path_to_flutter_directory]/flutter/bin”
 โดยให้แทนที่ [path_to_flutter_directory] ด้วยที่อยู่ที่คุณเก็บ Flutter (เช่น /Users/username/flutter)
กด CTRL + X แล้วกด Y เพื่อบันทึกและออกจาก nano

***** หมายเหตุ สามารถย่อ path ได้ เช่น
Path เต็ม คือ  export PATH="$PATH:/Users/macbook/development/flutter/bin"
ย่อได้เป็น export PATH="$PATH:$HOME/development/flutter/bin"