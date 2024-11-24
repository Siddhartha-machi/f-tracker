import 'package:flutter/material.dart';

import 'package:f_tracker_app/UIFeatures/utils.dart';
import 'package:f_tracker_app/UIFeatures/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.bottomSheetHandler,
    required this.workoutItems,
    required this.filtersHandler,
    required this.deleteHandler,
    required this.deleteBulkHandler,
  });

  final void Function(BuildContext, {CWorkoutActivity? item})
      bottomSheetHandler;
  final List<CWorkoutActivity> workoutItems;
  final Function() filtersHandler;
  final Function(CWorkoutActivity) deleteHandler;
  final Function() deleteBulkHandler;

  final double _padding = 10.0;

  static String _formattedDate(DateTime date) {
    final ref = DateTime.now();
    final elapsedDays = ref.difference(date).inDays.abs();
    var rValue = 'Several years ago';

    if (elapsedDays == 0) {
      rValue = 'Just now';
    } else if (elapsedDays < 7) {
      rValue = 'A week ago';
    } else if (elapsedDays < 31) {
      rValue = 'A month ago';
    } else if (elapsedDays < 365) {
      rValue = '${(elapsedDays / 30).ceil()} months ago';
    } else {
      final elapsedYears = (elapsedDays / 365).ceil();
      if (elapsedYears < 25) rValue = '$elapsedYears years ago';
    }
    return rValue;
  }

  Map<String, dynamic> get aggregations {
    final Map<String, dynamic> result = {
      'total_calories': 0,
      'total_duration': 0,
      'most_frequent_type': '',
    };
    Map<String, int> frequencyMap = {};
    int maxValue = -1;

    for (final item in workoutItems) {
      result['total_calories'] += item.calories;
      result['total_duration'] += item.duration;
      frequencyMap[item.type.name] = (frequencyMap[item.type.name] ?? 0) + 1;
    }
    frequencyMap.forEach((key, value) {
      if (value > maxValue) {
        maxValue = value;
        result['most_frequent_type'] = key;
      }
    });

    return result;
  }

  // Helper widgets
  Widget _statItem(
    double width,
    String label,
    IconData icon,
    String val,
    Color color,
  ) {
    return SizedBox.square(
      dimension: width,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withAlpha(100), color, color.withAlpha(200)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 25, color: Colors.white),
            const SizedBox(height: 5.0),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              val,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItems(BuildContext context) {
    const double gap = 10.0;
    double width =
        (MediaQuery.sizeOf(context).width - (_padding * 2) - (gap * 2)) / 3;

    return Row(children: [
      _statItem(
        width,
        'Calories',
        Icons.local_fire_department_rounded,
        '${aggregations['total_calories']} cal',
        Colors.red,
      ),
      const SizedBox(width: gap),
      _statItem(
        width,
        'Time spent',
        Icons.timelapse_rounded,
        '${aggregations['total_duration']} min',
        Colors.blue,
      ),
      const SizedBox(width: gap),
      _statItem(
        width,
        'Category',
        Icons.looks_one_rounded,
        aggregations['most_frequent_type'],
        Colors.green,
      ),
    ]);
  }

  Widget get _activityItemsHeader {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Workout Activity',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            TextButton(
              onPressed: deleteBulkHandler,
              child: const Text('Delete all'),
            ),
            const SizedBox(width: 5.0),
            IconButton(
              onPressed: filtersHandler,
              icon: const Icon(Icons.filter_alt_rounded),
            ),
          ],
        ),
      ],
    );
  }

  Widget _activityValue(String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.purple[400],
        ),
        const SizedBox(width: 3),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _activityItem(CWorkoutActivity item) {
    return Row(
      children: [
        Image.asset(
          'assets/${item.type.name}.png',
          width: 60,
          fit: BoxFit.contain,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.exercise,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      _formattedDate(item.createdAt),
                      style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                if (item.notes != null) ...[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.notes!,
                          style: const TextStyle(
                              fontSize: 12.0, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _activityValue(
                      '${item.calories.toString()} cal',
                      Icons.local_fire_department_rounded,
                    ),
                    _activityValue(
                      '${item.duration..toString()} min',
                      Icons.timelapse_rounded,
                    ),
                    _activityValue(
                      Global.firstCap(item.day.name.substring(0, 3)),
                      Icons.wb_sunny_rounded,
                    ),
                    _activityValue(
                      Global.firstCap(item.time.name),
                      Icons.watch_later_rounded,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _activityItems(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (final item in workoutItems) ...[
              _dissmibleWrap(item),
              const Divider(),
            ]
          ],
        ),
      ),
    );
  }

  Widget _dissmibleWrap(CWorkoutActivity item) {
    return Dismissible(
      background: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      key: ValueKey(item.id),
      onDismissed: (direction) => deleteHandler(item),
      child: _activityItem(item),
    );
  }

  Widget get _noDatePlaceholder {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/emptybox.png',
            fit: BoxFit.contain,
            width: 80,
          ),
          const SizedBox(height: 12),
          Text(
            'No data to show.\n Try adding some by clicking on the add button now.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: _padding,
        right: _padding,
        bottom: _padding * 2,
        left: _padding,
      ),
      child: Column(children: [
        _statItems(context),
        SizedBox(height: _padding),
        _activityItemsHeader,
        workoutItems.isEmpty ? _noDatePlaceholder : _activityItems(context)
      ]),
    );
  }
}
