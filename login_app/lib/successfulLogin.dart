import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class successfulLogin extends StatelessWidget {
  const successfulLogin({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),),
      body: Center(
        child: GestureDetector(
          child: Stack(
            children: <Widget> [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Text(
                          "Welcome",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                        ),
                      ),

                      ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
