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
            width: 300,
            height: 200,
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

// class CountdownScreen extends StatelessWidget {
//   const CountdownScreen({Key? key, required String title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final timerProvider = context.watch<TimerManager>();

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text('Countdown Screen'),
//       ),
//       body: Center(
//         child: Card(
//           child: SizedBox(
//             width: 300,
//             height: 200,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       '${timerProvider.minutes.toString().padLeft(2, '0')}:${timerProvider.seconds.toString().padLeft(2, '0')}',
//                       style: TextStyle(fontSize: 48),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
