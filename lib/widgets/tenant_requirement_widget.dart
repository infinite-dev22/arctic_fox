import 'package:flutter/material.dart';

class TenantRequirementWidget extends StatelessWidget {
  final String image;
  final String requirement;

  const TenantRequirementWidget(
      {super.key, required this.image, required this.requirement});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Image.asset(image), Text(requirement)],
      ),
    );
  }
}
