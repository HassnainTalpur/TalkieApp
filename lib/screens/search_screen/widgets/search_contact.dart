import 'package:flutter/material.dart';
import 'package:talkie/utils/constants/colors.dart';
import 'package:talkie/utils/constants/text.dart';

class SearchContact extends StatelessWidget {
  const SearchContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tContainerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(2),

      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          print(value);
        },
        keyboardType: TextInputType.webSearch,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search Contact',
          hintStyle: TText.labelLarge,
        ),
      ),
    );
  }
}
