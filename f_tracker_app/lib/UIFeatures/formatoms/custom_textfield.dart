import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:f_tracker_app/UIFeatures/models.dart';
import 'package:f_tracker_app/UIFeatures/utils.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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

  String? Function(String?) get validators {
    List<String? Function(String?)> validators = [];

    if (type == FieldType.integer) {
      validators.add(FormBuilderValidators.integer());
      validators.add(FormBuilderValidators.min(1));
    } else {
      validators.add(FormBuilderValidators.minLength(3));
    }

    if (isRequired == false) {
      return (value) {
        if (!Global.isEmpty(value)) {
          final validator = FormBuilderValidators.compose(validators);
          return validator(value);
        }
        return null;
      };
    } else {
      validators.insert(0, FormBuilderValidators.required());
      return FormBuilderValidators.compose(validators);
    }
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
      validator: validators,
      style: const TextStyle(fontSize: 12.0),
    );
  }
}
