import 'package:flutter/material.dart';

class NumeroButton extends StatelessWidget {
  const NumeroButton({
    super.key,
    required this.numero,
    required this.onPressed,
    required this.onLongPress,
  });

  final int numero;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: Text(
          '$numero',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
