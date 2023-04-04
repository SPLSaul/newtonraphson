import 'package:flutter/material.dart';
import 'dart:math';


void main() {
  MetodosNewton metodos = new MetodosNewton();
  List<double> error = [0];
  int x = 0;
  metodos.problema1(error, x);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Newton Raphson '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Introduce la funcion: ',
                ),
                onChanged: (text) {},
              ),
              SizedBox(height: 10), //separar el textfield de los botones
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Valor inicial de x:',
                      ),
                      onChanged: (text) {},
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Error a encontrar:',
                      ),
                      onChanged: (text) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10), //separar el textfield de los botones
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Selecciona el metodo"),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Mensaje de ejemplo')));
                    },
                    child: Text('Newton Raphson'),
                    style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
                  ),
                  SizedBox(width: 10), // Separación entre botones
                  ElevatedButton(
                    onPressed: () {
                      // Acción del segundo botón
                    },
                    child: Text('Newton Raphson Mejorado'),
                    style: ElevatedButton.styleFrom(primary: Colors.yellow),
                  ),
                ],
              ),
              DataTable(
                columns: _columns,
                rows: _rows,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
List<DataColumn> _columns = [    DataColumn(label: Text('Iteracion')),    DataColumn(label: Text('x')),    DataColumn(label: Text('Error')),  ];
List<DataRow> _rows = [    DataRow(cells: [      DataCell(Text('0')),      DataCell(Text('{xi[1]}')),      DataCell(Text('2')),    ]),
  DataRow(cells: [
    DataCell(Text('3')),
    DataCell(Text('4')),
    DataCell(Text('5')),
  ]),
];


class MetodosNewton{
  List<DataRow> _rows = [    DataRow(cells: [      DataCell(Text('0')),      DataCell(Text('')),      DataCell(Text('')),    ]),
  ];
  void problema1(List<double> error, int x) {  //Newton Raphson normal
    List<double> xi = [0];
    double errorP = 99;
    while (errorP > 1) {
      //print("$x --- ${xi[x]} --- ${error[x]}");
      double fxi =
          pow(xi[x],4) - 6 * pow(xi[x],3) + 12 *pow(xi[x],2) - 10 * xi[x] + 3;
      double dfxi = 4 * pow(xi[x],3) - 18 * pow(xi[x],2) + 24 * xi[x] - 10;
      double ecuacionNR = xi[x] - fxi / dfxi;
      xi.add((ecuacionNR * 100000).roundToDouble() / 100000);
      errorP = ((xi[x + 1] - xi[x]) / xi[x + 1]).abs() * 100;
      error.add((errorP * 100000).roundToDouble() / 100000);
      x++;
    }
    _rows = _rows.asMap().entries.map((entry) {
      int index = entry.key;
      DataRow row = entry.value;
      return DataRow(cells: [
        DataCell(Text(index.toString())),
        DataCell(Text(xi.length > index + 1 ? xi[index + 1].toString() : '')),
        DataCell(Text(error.length > index ? error[index].toString() : '')),
      ]);
    }).toList();
  }
}
