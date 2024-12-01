import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab_assessment_1/authWrapper.dart';
import 'package:lab_assessment_1/providers/is_logged_in_provider.dart';
import 'package:lab_assessment_1/providers/theme_provider.dart';
import 'package:lab_assessment_1/screens/add_workout_screen.dart';
import 'package:lab_assessment_1/screens/homepage.dart';
import 'package:provider/provider.dart';
import 'package:lab_assessment_1/services/shared_prefs_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>isLogged()),
        ChangeNotifierProvider(create: (context)=>theme()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes: {

        '/workouts': (context) => WorkoutsPage(),
        '/createWorkout': (context) => CreateWorkoutPage(),
      },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:context.watch<theme>().dark? ThemeData.dark(): ThemeData.light(),
        home: const AuthWrapper(),
    );
  }
}
