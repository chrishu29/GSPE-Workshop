import 'package:flutter/material.dart';

class DiagnosisMatrixTable {
  static Center table() {
    return Center(
      child: Table(
        border: TableBorder.all(
            color: Colors.grey,
            width: 2.0,
            style: BorderStyle.solid,
            borderRadius: BorderRadius.circular(10)),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
          4: FlexColumnWidth(1),
        },
        children: [
          TableRow(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            children: [
              TableCell(
                child: Center(
                    child: Text(
                  'No.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              TableCell(
                child: Center(
                    child: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              TableCell(
                child: Center(
                    child: Text(
                  'Estimated Duration (minutes)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              TableCell(
                child: Center(
                    child: Text(
                  'Level',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              TableCell(
                child: Center(
                    child: Text(
                  'Action',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Center(
                    child: Text(
                  '1',
                  style: TextStyle(fontSize: 16),
                )),
              ),
              TableCell(
                child: Center(
                    child: Text(
                  'Cell 4',
                  style: TextStyle(fontSize: 16),
                )),
              ),
              TableCell(
                child: Center(
                    child: Text(
                  'Cell 5',
                  style: TextStyle(fontSize: 16),
                )),
              ),
              TableCell(
                child: Center(
                    child: Text(
                  'Cell 6',
                  style: TextStyle(fontSize: 16),
                )),
              ),
              TableCell(
                child: Center(
                    child: Text(
                  'Cell 7',
                  style: TextStyle(fontSize: 16),
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
