import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function function;
  bool showProgress;

  AppButton({@required this.text, @required this.function, this.showProgress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: ElevatedButton(
        onPressed: function,
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
