import 'package:flutter/material.dart';

class CustomEgyptianFlag extends StatelessWidget {
  const CustomEgyptianFlag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.red.shade600,
            thickness: 3,
          ),
        ),
        const Expanded(
          child: Divider(color: Colors.white, thickness: 3),
        ),
        const Expanded(
          child: Divider(color: Colors.black, thickness: 3),
        ),
      ],
    );
  }
}
