import 'package:flutter/material.dart';
import 'package:meet_on_time/utils/authentication.dart';
import 'package:meet_on_time/widgets/auth_dialog.dart';

import '../widgets/event_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isProcessing = false;

  final List _isHovering = [false, false, false];

  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: const Color(0xFFEDEBD7),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Text('MEET ON TIME'),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: userEmail != null //Daha sonra kontrol et
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (context) => EventDialog(),
                                );
                              }
                            : null,
                        onHover: (value) {
                          setState(() {
                            _isHovering[0] = value;
                          });
                        },
                        child: Text(
                          'Start Planning',
                          style: TextStyle(
                            color: _isHovering[0]
                                ? const Color(0xFFE3B23C)
                                : const Color(0xFF6E675F),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(width: screenSize.width / 20),
                    ],
                  ),
                ),
                InkWell(
                  onHover: (value) {
                    setState(() {
                      _isHovering[1] = value;
                    });
                  },
                  onTap: userEmail == null
                      ? () {
                          showDialog(
                            context: context,
                            builder: (context) => AuthDialog(),
                          );
                        }
                      : null,
                  child: userEmail == null
                      ? Text(
                          'Sign in',
                          style: TextStyle(
                            color: _isHovering[1]
                                ? const Color(0xFFE3B23C)
                                : const Color(0xFF6E675F),
                          ),
                        )
                      : Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: imageUrl != null
                                  ? NetworkImage(imageUrl!)
                                  : null,
                              child: imageUrl == null
                                  ? const Icon(
                                      Icons.account_circle,
                                      size: 30,
                                    )
                                  : Container(),
                            ),
                            SizedBox(width: 5),
                            Text(
                              name ?? userEmail!,
                              style: TextStyle(
                                color: _isHovering[2]
                                    ? const Color(0xFFE3B23C)
                                    : const Color(0xFF6E675F),
                              ),
                            ),
                            SizedBox(width: 10),
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: const Color(0xFF6E675F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: _isProcessing
                                  ? null
                                  : () async {
                                      setState(() {
                                        _isProcessing = true;
                                      });
                                      await signOut().then((result) {
                                        print(result);
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            fullscreenDialog: true,
                                            builder: (context) => HomePage(),
                                          ),
                                        );
                                      }).catchError((error) {
                                        print('Sign Out Error: $error');
                                      });
                                      setState(() {
                                        _isProcessing = false;
                                      });
                                    },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                child: _isProcessing
                                    ? CircularProgressIndicator()
                                    : Text(
                                        'Sign out',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: const Color(0xFF6E675F),
                                        ),
                                      ),
                              ),
                            )
                          ],
                        ),
                ),
                SizedBox(
                  width: screenSize.width / 50,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: SizedBox(
              height: screenSize.height * 0.45,
              width: screenSize.width,
              child: Image.asset('lib/assets/images/choice.jpg',
                  fit: BoxFit.cover),
            ),
          ),
          Center(
            heightFactor: 1,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.40,
                left: screenSize.width / 5,
                right: screenSize.width / 5,
              ),
              child: Card(
                  //içi sonra doldurulacak
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
