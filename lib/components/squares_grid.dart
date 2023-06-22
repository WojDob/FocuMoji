import 'dart:math';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../models/timer_manager.dart';

class SquaresGrid extends StatefulWidget {
  final int totalNumberOfSquares;

  const SquaresGrid({super.key, required this.totalNumberOfSquares});

  @override
  _SquaresGridState createState() => _SquaresGridState();
}

class _SquaresGridState extends State<SquaresGrid> {
  List<bool> squaresShown = [];

  @override
  void initState() {
    super.initState();

    squaresShown = List.generate(widget.totalNumberOfSquares, (index) => false);
    revealSquares();
  }

  Future<void> revealSquares() async {
    for (int i = 0; i < widget.totalNumberOfSquares; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        squaresShown[i] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int rowCount = (sqrt(widget.totalNumberOfSquares)).ceil();
    double gridWidth = rowCount * 24.0;
    final timerProvider = context.watch<TimerManager>();
    int numberOfActiveSquares =
        (timerProvider.totalRemainingSeconds / 60).ceil();

    List<bool> squaresFilled = List.generate(widget.totalNumberOfSquares,
        (index) => index < numberOfActiveSquares ? true : false);

    return SizedBox(
      width: gridWidth,
      height: gridWidth,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.totalNumberOfSquares,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: rowCount,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemBuilder: (context, index) => _buildSquare(index, squaresFilled),
      ),
    );
  }

  Container _buildSquare(int index, List<bool> squaresFilled) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: (squaresFilled[index] && squaresShown[index])
            ? Colors.yellow
            : Colors.transparent,
        border: Border.all(
          color: (!squaresFilled[index] && squaresShown[index])
              ? Colors.yellow
              : Colors.transparent,
        ),
      ),
    );
  }
}
