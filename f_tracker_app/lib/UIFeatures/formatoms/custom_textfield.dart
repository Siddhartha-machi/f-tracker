import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:f_tracker_app/UIFeatures/models.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.label,
    required this.type,
    required this.accessKey,
    this.isRequired,
    this.isMultiline,
  });

  final String label;
  final FieldType type;
  final String accessKey;
  final bool? isRequired;
  final bool? isMultiline;

  InputDecoration get _useDecoration {
    String labelSuffix = isRequired == true ? ' *' : '';

    return InputDecoration(
      labelText: label + labelSuffix,
      hintStyle: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
      labelStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
      ),
      border: const OutlineInputBorder(),
    );
  }

  TextInputType get _useKeyboardType {
    return type == FieldType.integer
        ? TextInputType.number
        : TextInputType.text;
  }

  int? get rows {
    return isMultiline == true ? 4 : null;
  }

  Key get generatedKey {
    return Key('${accessKey}Dropdown');
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      key: generatedKey,
      name: accessKey,
      minLines: rows,
      maxLines: rows,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUnfocus,
      keyboardType: _useKeyboardType,
      decoration: _useDecoration,
      style: const TextStyle(fontSize: 12.0),
    );
  }
}
