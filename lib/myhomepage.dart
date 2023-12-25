import 'package:dl/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer:
      const Menu(),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
             'Welcome to the Image Classification App',
            style: TextStyle(
              fontSize: 20, // Adjust the font size as needed
              fontWeight: FontWeight.bold,
               ),
            ),
            const SizedBox(height: 40,),
            SvgPicture.asset(
              'assets/robot.svg',
              height: 200, // Set the desired height
              width: 200, // Set the desired width
            ),

          ],
        ),
      ),
    );
  }
}
