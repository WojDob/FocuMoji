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
                    SquaresGrid(
                        totalNumberOfSquares:
                            timerProvider.initialTimeInMinutes),
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
  final int totalNumberOfSquares;

  SquaresGrid({required this.totalNumberOfSquares});

  @override
  _SquaresGridState createState() => _SquaresGridState();
}

class _SquaresGridState extends State<SquaresGrid> {
  List<bool> squaresShown = [];
  List<bool> squaresFilled = [];

  @override
  void initState() {
    super.initState();

    squaresShown = List.generate(widget.totalNumberOfSquares, (index) => false);

    revealSquares();
  }

  Future<void> revealSquares() async {
    for (int i = 0; i < widget.totalNumberOfSquares; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        squaresShown[i] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int rowCount =
        (sqrt(widget.totalNumberOfSquares)).ceil(); // Calculate the rowCount
    double gridWidth = rowCount * 24.0; // Width for the GridView.
    final timerProvider = context.watch<TimerManager>();
    int numberOfActiveSquares =
        (timerProvider.totalRemainingSeconds / 60).ceil();

    List<bool> squaresFilled = List.generate(widget.totalNumberOfSquares,
        (index) => index < numberOfActiveSquares ? true : false);

    return Column(
      children: [
        Text(
          widget.totalNumberOfSquares.toString(),
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 16),
        SizedBox(
          // Wrap the GridView.builder with Container
          width: gridWidth, // Set the width for the Container.
          height: gridWidth, // Set the height for the Container.
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.totalNumberOfSquares,
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
                color:
                    (squaresFilled[index]) ? Colors.yellow : Colors.transparent,
                border: Border.all(
                  color:
                      squaresShown[index] ? Colors.black : Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
