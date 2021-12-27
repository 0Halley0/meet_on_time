import 'package:meet_on_time/screens/home_page.dart';
import 'package:meet_on_time/utils/authentication.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class GoogleButton extends StatefulWidget {
  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: const Color(0xFF678983), width: 3),
        ),
        color: const Color(0xFFF0E9D2),
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: const Color(0xFFE6DDC4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: const Color(0xFF678983), width: 3),
          ),
          elevation: 0,
        ),
        onPressed: () async {
          setState(() {
            _isProcessing = true;
          });
          await signInWithGoogle().then((result) {
            print(result);
            if (result != null) {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => HomePage(),
                ),
              );
            }
          }).catchError((error) {
            print('Registration Error: $error');
          });
          setState(() {
            _isProcessing = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: _isProcessing
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    const Color(0xFF678983),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Image(
                      image: AssetImage("lib/assets/images/google_logo.png"),
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF181D31),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
