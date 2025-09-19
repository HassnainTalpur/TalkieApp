import 'package:flutter/material.dart';
import 'package:talkie/utils/constants/colors.dart';

class NewContactTile extends StatelessWidget {
  const NewContactTile({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: tContainerColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 25,
                    child: Icon(icon, color: tOnBackgroundColor),
                  ),
                  SizedBox(width: 10),
                  Text(text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
