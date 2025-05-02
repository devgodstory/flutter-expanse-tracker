import 'package:flutter/material.dart';

class SurgeonEntry {
  String? surgeonName;
  List<String?> operations = [];
}

class SurgeonOperationForm extends StatefulWidget {
  @override
  _SurgeonOperationFormState createState() => _SurgeonOperationFormState();
}

class _SurgeonOperationFormState extends State<SurgeonOperationForm> {
  final _formKey = GlobalKey<FormState>();
  final List<SurgeonEntry> _entries = [];

  // ตัวอย่างข้อมูล dropdown
  final List<String> _allSurgeons = ['Dr. A', 'Dr. B', 'Dr. C'];
  final List<String> _allOperations = ['Op. 1', 'Op. 2', 'Op. 3', 'Op. 4'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Column(
              children: [
                // สร้างรายการ surgeon entries
                ..._entries.asMap().entries.map((e) {
                  final idx = e.key;
                  final entry = e.value;
                  return Card(
                    color: Colors.amberAccent,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // แถวเลือก surgeon + ปุ่มลบ
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(labelText: 'Surgeon'),
                                  items: _allSurgeons
                                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                                      .toList(),
                                  value: entry.surgeonName,
                                  onChanged: (v) {
                                    setState(() => entry.surgeonName = v);
                                  },
                                  validator: (v) =>
                                  v == null ? 'กรุณาเลือก surgeon' : null,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() => _entries.removeAt(idx));
                                },
                              ),
                            ],
                          ),

                          // รายการ operations ใน surgeon นี้
                          ...entry.operations.asMap().entries.map((opE) {
                            final opIdx = opE.key;
                            return Padding(
                              padding: EdgeInsets.only(left: 16, top: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      decoration:
                                      InputDecoration(labelText: 'Operation'),
                                      items: _allOperations
                                          .map((op) =>
                                          DropdownMenuItem(value: op, child: Text(op)))
                                          .toList(),
                                      value: entry.operations[opIdx],
                                      onChanged: (v) {
                                        setState(() => entry.operations[opIdx] = v);
                                      },
                                      validator: (v) =>
                                      v == null ? 'กรุณาเลือก operation' : null,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline,
                                        color: Colors.grey[700]),
                                    onPressed: () {
                                      setState(() => entry.operations.removeAt(opIdx));
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),

                          // ปุ่มเพิ่ม operation (จำกัดสูงสุด 3 รายการ)
                          if (entry.operations.length < 3)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                onPressed: () {
                                  setState(() => entry.operations.add(null));
                                },
                                icon: Icon(Icons.add_circle_outline),
                                label: Text('Add Operation'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),

                // ปุ่มเพิ่ม surgeon (จำกัดสูงสุด 2 รายการ)
                if (_entries.length < 2)
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() => _entries.add(SurgeonEntry()));
                        },
                        icon: Icon(Icons.person_add),
                        label: Text('Add Surgeon'),
                      ),
                    ),
                  ),

                SizedBox(height: 24),
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {

                      // print("_entries ::: " +  _entries.toString());

                      // เก็บค่าหรือส่ง API
                      for (var entry in _entries) {
                        print('Surgeon: ${entry.surgeonName}');
                        for (var op in entry.operations) {
                          print('  Operation: $op');
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
