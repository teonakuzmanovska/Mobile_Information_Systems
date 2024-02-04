import 'package:flutter/material.dart';

void clothingExistsMessage(BuildContext context, String clothing){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Clothing already exists',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
}