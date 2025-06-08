import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Calc(), debugShowCheckedModeBanner: false));

class Calc extends StatefulWidget {
  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  String inp = "", op = "";
  double n1 = 0;

  void tap(String v) {
    setState(() {
      if (v == "C") {
        inp = "";
        op = "";
        n1 = 0;
      } else if (["+", "-", "×"].contains(v)) {
        n1 = double.tryParse(inp) ?? 0;
        op = v;
        inp = "";
      } else if (v == "=") {
        double n2 = double.tryParse(inp) ?? 0;
        inp = (op == "+") ? "${n1 + n2}" :
              (op == "-") ? "${n1 - n2}" :
              (op == "×") ? "${n1 * n2}" : "Err";
      } else {
        inp += v;
      }
    });
  }

  Widget b(String t) => Expanded(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: ElevatedButton(
            onPressed: () => tap(t),
            child: Text(t, style: TextStyle(fontSize: 22)),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calc")),
      body: Column(children: [
        Expanded(
          child: Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(20),
            child: Text(inp, style: TextStyle(fontSize: 32)),
          ),
        ),
        ...[
          ["1", "2", "3"],
          ["4", "5", "6"],
          ["7", "8", "9"],
          ["0", "+", "-"],
          ["×", "=", "C"],
        ].map((r) => Row(children: r.map(b).toList()))
      ]),
    );
  }
}
