import 'package:flutter/material.dart';
import 'package:lab_assessment_1/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:lab_assessment_1/services/firebase_service.dart';
import 'add_workout_screen.dart';
import 'workout_details_screen.dart';
import 'package:lab_assessment_1/providers/is_logged_in_provider.dart';
import 'package:lab_assessment_1/providers/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth to get the user's name

class WorkoutsPage extends StatefulWidget {
  @override
  _WorkoutsPageState createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> workouts = [];
  String selectedStatus = "Not Done"; // Default filter to "Not Done"
  String userName = ""; // Store the user's name

  @override
  void initState() {
    super.initState();
    _fetchWorkouts();
    _getUserName(); // Fetch the user's name
  }

  Future<void> _fetchWorkouts() async {
    var data = await _firestoreService.getData("workouts");
    setState(() {
      workouts = data;
    });
  }

  Future<void> _getUserName() async {
    User? user = authService().currentUser;
    if (user != null) {
      // Using FirestoreService to get the user document from the 'users' collection
      Map<String, dynamic>? userData = await _firestoreService.getDocument('Users', user.uid); // 'users' collection and user UID
      setState(() {

        userName = userData?['name']; //?? user.email ?? 'User'; // Fallback to email if 'name' is not available
      });
    }
  }

  List<Map<String, dynamic>> _filterWorkouts(String status) {
    var filteredWorkouts = workouts.where((workout) {
      return status == "All" ||
          (status == "Done" && workout['isDone'] == true) ||
          (status == "Not Done" && workout['isDone'] == false);
    }).toList();
    return filteredWorkouts;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<theme>(context);
    final filteredWorkouts = _filterWorkouts(selectedStatus);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.dark ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              themeProvider.changeTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService().signOut();
              context.read<isLogged>().changeState();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Text(
              'Hello, $userName!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: themeProvider.dark ? Colors.white : Colors.black,
              ),
            ),
          ),
          // Filter Buttons for Status
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterButton("All", 'status'),
                  _buildFilterButton("Done", 'status'),
                  _buildFilterButton("Not Done", 'status'),
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchWorkouts,
              child: ListView.builder(
                itemCount: filteredWorkouts.length,
                itemBuilder: (context, index) {
                  var workout = filteredWorkouts[index];
                  return _buildWorkoutCard(workout, context, themeProvider.dark);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateWorkoutPage()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Create New Workout',
      ),
    );
  }

  Widget _buildFilterButton(String label, String filterType) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedStatus = label; // Only handle the status filter
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedStatus == label
              ? Colors.purple
              : Colors.grey.shade300,
          foregroundColor: selectedStatus == label
              ? Colors.white
              : Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildWorkoutCard(Map<String, dynamic> workout, BuildContext context, bool isDarkTheme) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          workout['name'],
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          "Tap to view the details",
          style: TextStyle(
            color: isDarkTheme ? Colors.white70 : Colors.black54,
            fontSize: 14,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: workout['isDone'] ?? false,
              onChanged: (bool? value) {
                setState(() {
                  workout['isDone'] = value;
                  _firestoreService.updateData('workouts', workout['ID'], {'isDone': value}); // Update status in Firestore
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutDetailsPage(workoutId: workout['ID']),
                  ),
                );
              },
              child: const Text('View'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
