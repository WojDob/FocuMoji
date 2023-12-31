import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'about_screen.dart';
import 'terms_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  Future<String> getAppVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    return info.version;
  }

  void sendEmail() async {
    final Email email = Email(
      body: 'Description of the issue:',
      subject: 'Focumoji Feedback',
      recipients: ['goodfolkdev@gmail.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutScreen()),
                        );
                      },
                      leading: _buildIconContainer(
                        Icons.info_outline,
                      ),
                      title: const Text('About'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TermsOfUseScreen()),
                        );
                      },
                      leading: _buildIconContainer(
                        Icons.assignment_outlined,
                      ),
                      title: const Text('Terms of Use'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      onTap: sendEmail,
                      leading: _buildIconContainer(
                        Icons.feedback_outlined,
                      ),
                      title: const Text('Send Feedback'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      onTap: () {
                        launchURL('https://twitter.com/GoodfolkDev');
                      },
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
            Expanded(
              child: Container(),
            ),
            FutureBuilder<String>(
              future: getAppVersion(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Text(
                          'FocuMoji',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text('v${snapshot.data}'),
                      ],
                    ),
                  );
                }
              },
            ),
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
