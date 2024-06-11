import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int cantidad = 1;

class QuantitySelection extends StatefulWidget {
  const QuantitySelection({super.key});

  @override
  _QuantitySelectionState createState() => _QuantitySelectionState();
}

class _QuantitySelectionState extends State<QuantitySelection> {
  final int limitSelectQuantity;
  final int value;
  final double width;
  final double height;
  //final Function onChanged;
  final Color color;

  _QuantitySelectionState({
    this.value = 10,
    this.width = 130.0,
    this.height = 50.0,
    this.limitSelectQuantity = 100,
    this.color = Colors.black,
    //this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(CupertinoIcons.minus_circle),
              onPressed: () {
                setState(() {
                  cantidad--;
                  if (cantidad < 1) {
                    cantidad = 1;
                  }
                  print(cantidad);
                });
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  cantidad.toString(),
                  style: TextStyle(fontSize: 14, color: color),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.plus_circle),
              onPressed: () {
                setState(() {
                  cantidad++;
                  print(cantidad);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
