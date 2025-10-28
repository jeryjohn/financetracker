import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;

  final double amount;
  const CategoryCard({
    super.key,
    required this.title,
    required this.amount,
  });
//by calling category card the container box and designs set here can be accessed and by entering data it will be able to do
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'Antonio',
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ],
            ),
            Text(
              '${amount.toString()} ₹',
            )
          ],
        ),
      ),
    );
  }
}
