import 'package:flutter/material.dart';

final List<Color> rainbowColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: const CounterArea(),
    );
  }
}

class CounterArea extends StatefulWidget {
  const CounterArea({super.key});

  @override
  State<CounterArea> createState() => _CounterAreaState();
}

class _CounterAreaState extends State<CounterArea> {
  double _marginTop = 0.0;
  final double _textHeight = 40.0; 

  void _moveTextDown(double maxHeight) {
    setState(() {
      double maxLimit = maxHeight - _textHeight;
      if (_marginTop < maxLimit) {
        _marginTop += 50.0; 
        if (_marginTop > maxLimit) {
          _marginTop = maxLimit;
        }
      }
    });
  }

  void _resetPosition() {
    setState(() {
      _marginTop = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('panuwat takham'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: rainbowColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      
      body: LayoutBuilder(
        builder: (context, constraints) {
          
          return Stack(
            children: [
              Container(
                color: const Color.fromARGB(255, 157, 135, 245),
                width: double.infinity,
                height: double.infinity,
              ),

              Positioned(
                top: _marginTop,
                left: 0,
                right: 0,
                child: Center( // ใช้ Center เพื่อจัดกึ่งกลางแนวนอน
                  child: Text(
                    'Software Engineer',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // ปุ่มกด (อยู่ตรงกลางหน้าจอเสมอ ไม่เลื่อนตาม)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      // ส่งค่า constraints.maxHeight ไปให้ฟังก์ชันคำนวณ
                      onPressed: () => _moveTextDown(constraints.maxHeight),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                      ),
                      child: const Text('Move Down'),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: _resetPosition,
                      child: const Text('Reset',
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}