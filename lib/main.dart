import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balanced Substrings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BalancedSubstringScreen(),
    );
  }
}

class BalancedSubstringScreen extends StatefulWidget {
  @override
  _BalancedSubstringScreenState createState() =>
      _BalancedSubstringScreenState();
}

class _BalancedSubstringScreenState extends State<BalancedSubstringScreen> {
  TextEditingController _inputController = TextEditingController();
  List<String> _result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balanced Substrings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _inputController,
              decoration: InputDecoration(labelText: 'Enter a string'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _result = getBalancedSubstrings(_inputController.text);
                });
              },
              child: Text('Get Balanced Substrings'),
            ),
            SizedBox(height: 20),
            Text(
              'Result: ${_result.isEmpty ? "No balanced substrings found" : _result.join(", ")}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  List<String> getBalancedSubstrings(String S) {
    List<String> balancedSubstrings = [];

    for (int i = 0; i < S.length; i++) {
      for (int j = i + 2; j <= S.length; j++) {
        String substring = S.substring(i, j);
        if (isBalanced(substring)) {
          if (balancedSubstrings.isEmpty ||
              substring.length > balancedSubstrings.first.length) {
            balancedSubstrings = [substring];
          } else if (substring.length == balancedSubstrings.first.length) {
            balancedSubstrings.add(substring);
          }
        }
      }
    }

    return balancedSubstrings;
  }

  bool isBalanced(String s) {
    if (s.length < 2) return false;

    Set<String> uniqueChars = s.split('').toSet();
    if (uniqueChars.length != 2) return false;

    int count1 = s.split(uniqueChars.first).length - 1;
    int count2 = s.split(uniqueChars.last).length - 1;

    return count1 == count2;
  }
}
