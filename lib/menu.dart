

import 'package:dl/ImageClassificationPage.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey,
      child: ListView(
        children:  [
          DrawerHeader(decoration:BoxDecoration(gradient: LinearGradient(colors: [Colors.blue,Colors.purple,Colors.white])),
          child: CircleAvatar(backgroundImage: AssetImage('assets/ai.jpg'),)
            
          ),
          Column(
            children: [
              ListTile(
                title: const Text('Choose an algorithm above'),
                leading: const Icon(Icons.data_array),
              ),
              ListTile(
                title: const Text('ANN'),
                leading: const Icon(Icons.network_cell),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ImageClassificationPage()));
                },
              ),
              ListTile(
                title: Text('CNN'),
                leading: Icon(Icons.network_ping_outlined),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WastedDataClassifier()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}