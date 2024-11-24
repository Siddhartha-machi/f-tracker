import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom(
      {super.key,
      required this.label,
      required this.action,
      this.isFilled,
      this.margin});

  final String label;
  final void Function() action;
  final bool? isFilled;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      child: TextButton(
        onPressed: action,
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor:
              isFilled == true ? Theme.of(context).primaryColor : null,
          foregroundColor:
              isFilled == true ? Theme.of(context).colorScheme.onPrimary : null,
        ),
        child: Text(label),
      ),
    );
  }
}
