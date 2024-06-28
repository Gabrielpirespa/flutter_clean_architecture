import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/custom_colors.dart';

class ApodViewButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Function()? onTap;
  const ApodViewButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.description,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CustomColors.black,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: CustomColors.white.withOpacity(.6),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: CustomColors.white,
              size: 36,
            ),
            Text(
              title,
              style: TextStyle(
                color: CustomColors.white,
                fontSize: 16,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: CustomColors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
