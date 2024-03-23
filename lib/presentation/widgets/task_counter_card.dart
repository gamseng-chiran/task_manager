import 'package:flutter/material.dart';

class TastkCounterCard extends StatelessWidget {
  const TastkCounterCard({
    Key? key, required this.amount, required this.title,
  }) : super(key: key);
  final int amount;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(children: [
          Text('$amount', style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),),
          Text(title,style: TextStyle(
            color: Colors.grey
          ),)
        ]),
      ),
      
    );
  }
}