import 'dart:math';

import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:provider/provider.dart';

class CountdownScreen extends StatelessWidget {
  const CountdownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerProvider = context.watch<TimerManager>();

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Card(
          child: SizedBox(
            width: 300,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  _buildTimeText(timerProvider),
                  SizedBox(height: 16),
                  Expanded(
                    child: SquaresGrid(
                      totalNumberOfSquares: timerProvider.initialTimeInMinutes,
                    ),
                  ),
                  Visibility(
                    visible: timerProvider.timerEnded,
                    child: ElevatedButton(
                      onPressed: () {
                        _showModal(context);
                      },
                      child: Text('Open Modal'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Text _buildTimeText(TimerManager timerProvider) {
    return Text(
      '${timerProvider.minutes.toString().padLeft(2, '0')}:${timerProvider.seconds.toString().padLeft(2, '0')}',
      style: TextStyle(fontSize: 48),
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            constraints: BoxConstraints(maxHeight: 350),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure "),
                ],
              ),
            ),
          ),
        );
      },
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
        physics: NeverScrollableScrollPhysics(),
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
