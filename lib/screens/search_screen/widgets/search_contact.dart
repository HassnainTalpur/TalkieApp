import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text.dart';

class SearchContact extends StatelessWidget {
  const SearchContact({super.key});

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        color: tContainerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(2),

      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          print(value);
        },
        keyboardType: TextInputType.webSearch,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search Contact',
          hintStyle: TText.labelLarge,
        ),
      ),
    );
}
