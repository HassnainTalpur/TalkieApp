import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class NewContactTile extends StatelessWidget {
  const NewContactTile({required this.icon, required this.text, super.key});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Row(
          children: [
            DecoratedBox(
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
                  const SizedBox(width: 10),
                  Text(text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}
