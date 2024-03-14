import 'package:flutter/material.dart';

class EncabezadoListaPertenencias extends StatelessWidget {
  const EncabezadoListaPertenencias({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _IconButton(
          icon: Icons.location_on_rounded,
          onTap: () {},
          onLongPress: () {},
        ),
        Text(
          'Nombre',
          style: TextStyle(
            fontSize: theme.textTheme.titleMedium?.fontSize,
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        _IconButton(
          icon: Icons.luggage_rounded,
          onTap: () {},
          onLongPress: () {},
        ),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onTap,
    required this.onLongPress,
  });

  final IconData icon;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        width: 50,
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Icon(
            icon,
            color: theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}