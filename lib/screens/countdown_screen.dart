import 'dart:math';

import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:provider/provider.dart';

class CountdownScreen extends StatelessWidget {
  CountdownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerProvider = context.watch<TimerManager>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Card(
          child: SizedBox(
            // width: 300,
            // height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${timerProvider.minutes.toString().padLeft(2, '0')}:${timerProvider.seconds.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 48),
                    ),
                    SquaresGrid(number: timerProvider.minutes),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SquaresGrid extends StatefulWidget {
  final int number;

  SquaresGrid({required this.number});

  @override
  _SquaresGridState createState() => _SquaresGridState();
}

class _SquaresGridState extends State<SquaresGrid> {
  List<bool> gridStates = [];

  @override
  void initState() {
    super.initState();
    gridStates = List.generate(widget.number, (index) => false);
    revealSquares();
  }

  Future<void> revealSquares() async {
    for (int i = 0; i < widget.number; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        // Update gridStates to reveal the next square
        gridStates[i] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int rowCount =
        (sqrt(widget.number.toDouble())).ceil(); // Calculate the rowCount
    double gridWidth = rowCount * 24.0; // Width for the GridView.

    return Column(
      children: [
        Text(
          widget.number.toString(),
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 16),
        Container(
          // Wrap the GridView.builder with Container
          width: gridWidth, // Set the width for the Container.
          height: gridWidth, // Set the height for the Container.
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.number,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowCount,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (context, index) => Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: gridStates[index] ? Colors.yellow : Colors.transparent,
                border: Border.all(
                  color: gridStates[index] ? Colors.yellow : Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
