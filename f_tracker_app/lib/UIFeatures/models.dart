import 'package:uuid/uuid.dart';

var uuid = const Uuid();

// Enums
enum ActivityType { cardio, strength, flexibility }

enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

enum DayShift { morning, evening, night }

// Models
class CWorkoutActivity {
  CWorkoutActivity(
      {required this.exercise,
      required this.duration,
      required this.calories,
      required this.type,
      required this.day,
      required this.time,
      this.notes,
      createdAt})
      : id = uuid.v4(),
        createdAt = createdAt ?? DateTime.now();

  // Required fields
  final String id;
  final String exercise;
  final int duration;
  final int calories;
  final DateTime createdAt;
  final Weekday day;
  final DayShift time;
  final ActivityType type;

  // Optional fields
  final String? notes;
}

// Forms enums
enum FieldType { text, integer }

// Misc
enum FormOpenMode { add, edit }
