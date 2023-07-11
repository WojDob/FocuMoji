import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FocuMoji'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              elevation: 5,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      onTap: () {},
                      leading: _buildIconContainer(
                        Icons.info_outline,
                      ),
                      title: const Text('About'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: _buildIconContainer(
                        Icons.assignment_outlined,
                      ),
                      title: const Text('Terms of Use'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: _buildIconContainer(
                        Icons.feedback_outlined,
                      ),
                      title: const Text('Feedback'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: _buildIconContainer(
                        FontAwesomeIcons.twitter,
                      ),
                      title: const Text('Follow on Twitter'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ).toList(),
              ),
            ),
            // The rest of your widgets.
            // ...
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(IconData icon) {
    Color iconColor = Colors.white;
    Color boxColor = const Color.fromARGB(156, 255, 255, 0);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: boxColor,
        border: Border.all(
          color: boxColor,
        ),
      ),
      padding: const EdgeInsets.all(1),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
