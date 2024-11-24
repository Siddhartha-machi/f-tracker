import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:f_tracker_app/UIFeatures/atoms/custom_button.dart';
import 'package:f_tracker_app/UIFeatures/formatoms/custom_textfield.dart';
import 'package:f_tracker_app/UIFeatures/formatoms/enum_dropdown.dart';
import 'package:f_tracker_app/UIFeatures/models.dart';

class AddWorkoutForm extends StatelessWidget {
  const AddWorkoutForm(this.addWorkoutHandler, this.formKey, {super.key});

  final void Function(CWorkoutActivity) addWorkoutHandler;
  final GlobalKey<FormBuilderState> formKey;

  Widget _successMessageTemplate(BuildContext context) {
    return AlertDialog.adaptive(
      icon: const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 50,
      ),
      title: const Text(
        'Added successfully!',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Workout activity item was added successfully.',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the popup
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  void showSuccessMessage(BuildContext context) {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return _successMessageTemplate(context);
        },
      );
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return _successMessageTemplate(context);
        },
      );
    }
  }

  void _addWorkout(context) {
    if (formKey.currentState!.saveAndValidate()) {
      final formValues = formKey.currentState?.value;

      addWorkoutHandler(
        CWorkoutActivity(
          exercise: formValues!['exercise'],
          duration: int.parse(formValues['duration']),
          calories: int.parse(formValues['calories']),
          type: formValues['workoutType'],
          day: formValues['day'],
          time: formValues['time'],
        ),
      );
      showSuccessMessage(context);
      formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FormBuilder(
        key: formKey,
        child: Column(
          children: [
            const CustomTextfield(
              label: 'Exercise',
              type: FieldType.text,
              accessKey: 'exercise',
            ),
            const SizedBox(height: 10),
            const CustomTextfield(
              label: 'Calories Burned',
              type: FieldType.integer,
              accessKey: 'calories',
            ),
            const SizedBox(height: 10),
            const CustomTextfield(
              label: 'Duration (min)',
              type: FieldType.integer,
              accessKey: 'duration',
            ),
            const SizedBox(height: 10),
            EnumDropdown<ActivityType>(
              label: 'Workout Type',
              options: ActivityType.values,
              formKey: formKey,
              accessKey: 'workoutType',
            ),
            const SizedBox(height: 10),
            const CustomTextfield(
              label: 'Notes',
              type: FieldType.text,
              isRequired: false,
              accessKey: 'notes',
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: EnumDropdown<Weekday>(
                    label: 'Day',
                    options: Weekday.values,
                    formKey: formKey,
                    accessKey: 'day',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: EnumDropdown<DayShift>(
                    label: 'Time',
                    options: DayShift.values,
                    formKey: formKey,
                    accessKey: 'time',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CustomButtom(
              label: 'Submit',
              action: () => _addWorkout(context),
              isFilled: true,
            ),
            CustomButtom(
              label: 'Cancel',
              action: Navigator.of(context).pop,
            ),
          ],
        ),
      ),
    );
  }
}
