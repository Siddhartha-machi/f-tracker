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
  final List<Map<String, dynamic>> _workouts = [];
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


    /*
      
       Extract User Input:
          Extract the values from the text fields.
          Extract exercise (workout name), duration (workout length), calories, and notes.

      Add Input Validation (Empty Fields Check):
          Add a check to ensure that none of the required fields (i.e., exercise, duration, and calories) are empty:
          If any field is empty, set an error message 'All fields are required!' and return from the function to prevent further execution.

      Add Input Validation (Numeric Values Check):
          Add validation to ensure that duration and calories contain numeric values only:
          If the input is non-numeric, set an error message 'Duration and Calories must be numeric!' and prevent further execution.

      Add the Workout to the List:
          If all validations pass, create object that holds the workout details, including the exercise name, duration, calories burned, workout type, and any optional notes.
          Append this workout to the _workouts list.


      Clear Input Fields After Submission:
          Once a workout is added, clear the input fields so the user can add the next workout:
          Reset the dropdown for workout type back to the default ('Cardio').
          Clear any previously set error messages.
            
    */


  }

  void _deleteWorkout(int index) {
    
    /*
    
      Allow the user to delete a specific workout from the list by its index.
    
    */

  }

  void _deleteAllWorkouts() {
    
    /*
      
      Allow the user to delete all workouts at once from the workout list.
    
    */

  }

  int get _totalCalories {

    /*
    
      Calculate the total calories burned from all the workouts in the list.
    
    */
    
    return 0;

  }

  List<Map<String, dynamic>> get _filteredWorkouts {
    
    /*
      
      Allow the user to filter all workouts according to day and time of workout.
    
    */

    return _workouts;

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
