import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.green[100]),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.health_and_safety,
              size: 20,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(name)
          ],
        ),
      ),
    );
  }
}
