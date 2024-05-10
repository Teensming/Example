import 'package:flutter/material.dart';

class Listpage extends StatefulWidget {
  const Listpage({Key? key});

  @override
  State<Listpage> createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  List<int> fibonacciNumbers = [];

  @override
  void initState() {
    super.initState();

    calculateFibonacci(41);
  }

  void calculateFibonacci(int n) {
    int a = 0, b = 1;
    if (n >= 1) {
      fibonacciNumbers.add(a);
    }
    if (n >= 2) {
      fibonacciNumbers.add(b);
    }
    for (int i = 2; i < n; i++) {
      int next = a + b;
      fibonacciNumbers.add(next);
      a = b;
      b = next;
    }
  }

  void _showFilteredItems(int index) {
    int tappedNumber = fibonacciNumbers[index];
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: tappedNumber.bitLength,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  'Filtered Item ${index}, Number ${fibonacciNumbers[index]}'),
              onTap: () {
                setState(() {
                  fibonacciNumbers.remove(tappedNumber);
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Example')),
      ),
      body: ListView.builder(
        itemCount: fibonacciNumbers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _showFilteredItems(index);
            },
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Index: $index, Number: ${fibonacciNumbers[index]}'),
                  GestureDetector(
                    onTap: () {
                      _showFilteredItems(index);
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
