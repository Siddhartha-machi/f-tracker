import 'package:flutter/material.dart';

void main() {
  runApp(const WorkoutTrackerApp());
}

class WorkoutTrackerApp extends StatelessWidget {
  const WorkoutTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Tracker',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const WorkoutHomePage(),
    );
  }
}

class WorkoutHomePage extends StatefulWidget {
  const WorkoutHomePage({super.key});

  @override
  _WorkoutHomePageState createState() => _WorkoutHomePageState();
}

class _WorkoutHomePageState extends State<WorkoutHomePage> {
  // Flutter recommends immutable approach for state variables
  List<Map<String, dynamic>> _workouts = [];
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String _selectedType = 'Cardio';
  String _selectedTime = 'Morning';
  String _selectedDay = 'Monday';

  // Filter parameters
  String? _filterDay;
  String? _filterTime;

  String? _errorMessage;

  void _addWorkout() {
    // Extract all fields values
    final exercise = _exerciseController.text;
    final duration = _durationController.text;
    final calories = _caloriesController.text;
    final notes = _notesController.text;

    // Run validations and set appropriate error messages
    if (CValid.isNull(exercise) ||
        CValid.isNull(duration) ||
        CValid.isNull(calories)) {
      return setState(() {
        _errorMessage = 'All fields are required!';
      });
    } else if (CValid.isNotNum(duration) || CValid.isNotNum(calories)) {
      return setState(() {
        _errorMessage = 'Duration and Calories must be numeric!';
      });
    }

    // Add the new workout to the list
    _workouts.add({
      'exercise': exercise,
      'duration': int.parse(duration),
      'calories': int.parse(calories),
      'notes': notes,
      'type': _selectedType,
      'day': _selectedDay,
      'time': _selectedTime
    });

    // Reset values in the controllers and error state
    _selectedType = 'Cardio';
    _selectedDay = 'Monday';
    _selectedTime = 'Morning';
    _errorMessage = null;
    _exerciseController.clear();
    _durationController.clear();
    _caloriesController.clear();
    _notesController.clear();

    setState(() {});
  }

  void _deleteWorkout(int index) {
    final deleteItem = _workouts[index];
    setState(() {
      _workouts = _workouts.where((item) => deleteItem != item).toList();
    });
  }

  void _deleteAllWorkouts() {
    setState(() {
      _workouts = [];
    });
  }

  int get _totalCalories {
    return _workouts.fold(0, (sum, item) => sum + (item['calories'] as int));
  }

  List<Map<String, dynamic>> get _filteredWorkouts {
    List<Map<String, dynamic>> filteredList = _workouts;
    if (_filterDay != null) {
      filteredList =
          _workouts.where((item) => item['day'] == _filterDay).toList();
    }
    if (_filterTime != null) {
      filteredList =
          filteredList.where((item) => item['time'] == _filterTime).toList();
    }

    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  key: const Key('errorMessage'),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      _exerciseController,
                      'Exercise',
                      const Key('exerciseField'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      _durationController,
                      'Duration (min)',
                      const Key('durationField'),
                      TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      _caloriesController,
                      'Calories Burned',
                      const Key('caloriesField'),
                      TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedType,
                      key: const Key('workoutTypeDropdown'),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedType = newValue;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Workout Type',
                        border: OutlineInputBorder(),
                      ),
                      items: <String>['Cardio', 'Strength', 'Flexibility']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildTextField(
                _notesController,
                'Notes',
                const Key('notesField'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedDay,
                      key: const Key('dayDropdown'),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedDay = newValue;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Day',
                        border: OutlineInputBorder(),
                      ),
                      items: <String>[
                        'Monday',
                        'Tuesday',
                        'Wednesday',
                        'Thursday',
                        'Friday',
                        'Saturday',
                        'Sunday'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedTime,
                      key: const Key('timeDropdown'),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedTime = newValue;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        border: OutlineInputBorder(),
                      ),
                      items: <String>['Morning', 'Evening', 'Night']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    key: const Key('addWorkoutButton'),
                    onPressed: _addWorkout,
                    child: const Text('Add Workout'),
                  ),
                  ElevatedButton(
                    key: const Key('deleteAllWorkoutsButton'),
                    onPressed: _deleteAllWorkouts,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Delete All Workouts'),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _filterDay,
                      key: const Key('filterDayDropdown'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _filterDay = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Filter by Day',
                        border: OutlineInputBorder(),
                      ),
                      items: <String?>
                        [
                        null,
                        'Monday',
                        'Tuesday',
                        'Wednesday',
                        'Thursday',
                        'Friday',
                        'Saturday',
                        'Sunday'
                      ].map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value ?? 'All Days'),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _filterTime,
                      key: const Key('filterTimeDropdown'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _filterTime = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Filter by Time',
                        border: OutlineInputBorder(),
                      ),
                      items: <String?>
                      [
                        null, 
                        'Morning', 
                        'Evening', 
                        'Night'
                      ].map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value ?? 'All Times'),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredWorkouts.length,
                itemBuilder: (ctx, index) {
                  final workout = _filteredWorkouts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        workout['exercise'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Type: ${workout['type']}, Duration: ${workout['duration']} min, '
                        'Calories: ${workout['calories']}\nNotes: ${workout['notes']}\nDay: ${workout['day']}, Time: ${workout['time']}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteWorkout(index),
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                'Total Calories Burned: $_totalCalories',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    Key key, [
    TextInputType keyboardType = TextInputType.text,
  ]) {
    return TextField(
      key: key,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      ),
      keyboardType: keyboardType,
    );
  }
}

// A class to validate field values
class CValid {
  static bool isNull(value) {
    return value == null || (value is String && value.isEmpty);
  }

  static bool isNotNum(value) {
    return (int.tryParse(value as String) == null) || (int.parse(value) <= 0);
  }
}
