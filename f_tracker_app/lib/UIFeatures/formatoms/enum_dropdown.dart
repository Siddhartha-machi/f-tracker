import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:f_tracker_app/UIFeatures/utils.dart';

class EnumDropdown<T extends Enum> extends StatelessWidget {
  const EnumDropdown({
    super.key,
    required this.label,
    required this.options,
    required this.accessKey,
    required this.formKey,
  });

  final String label;
  final String accessKey;
  final List<T> options;
  final GlobalKey<FormBuilderState> formKey;

  T get _initialValue {
    T? stateInitValue = formKey.currentState?.initialValue[label];

    return Global.isSafe(stateInitValue) ? stateInitValue! : options[0];
  }

  Key get generatedKey {
    return Key('${accessKey}Dropdown');
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<T>(
      key: generatedKey,
      name: accessKey,
      initialValue: _initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
        border: const OutlineInputBorder(),
      ),
      items: options.map((value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(Global.firstCap(value.name)),
        );
      }).toList(),
    );
  }
}
