// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculate BMI',
      theme: ThemeData(
        // This is the theme of your application.
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: PassDataDemo(),
    );
  }
}

class PassDataDemo extends StatefulWidget {
  const PassDataDemo({Key? key}) : super(key: key);
  @override
  State<PassDataDemo> createState() => _PassDataDemoState();
}

class _PassDataDemoState extends State<PassDataDemo> {
  final myController = TextEditingController();
  final myControllertwo = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller
    // when the widget is disposed.
    myController.dispose();
    myControllertwo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("BMI Calculator"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Container(
              height: 50,
              width: 300,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                controller: myController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
                  labelText: 'Enter Weight kg',
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0, // Customize the thickness
                      color: Colors.grey, // Customize the color
                    ),
                  ),
                  // Defines the appearance when the field is focused (clicked on)
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Colors.blueAccent, // Customize the focused color
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
            Container(
              height: 50,
              width: 300,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                controller: myControllertwo,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
                  labelText: 'Enter Height m',
                  border: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0, // Customize the thickness
                      color: Colors.grey, // Customize the color
                    ),
                  ),
                  // Defines the appearance when the field is focused (clicked on)
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Colors.blueAccent, // Customize the focused color
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
            SizedBox(
              height: 150,
            ),
            // Step 1 <-- SEE HERE
            ElevatedButton(
              onPressed: () {
                double weight = double.tryParse(myController.text) ?? 0;
                double height = double.tryParse(myControllertwo.text) ?? 0;

                double bmi = 0;
                if (height > 0) {
                  bmi = weight / (height * height);
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      weight: weight.toString(),
                      height: height.toString(),
                      bmi: bmi.toStringAsFixed(2),
                    ),
                  ),
                );
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final String weight;
  final String height;
  final String bmi;

  const DetailScreen({
    Key? key,
    required this.weight,
    required this.height,
    required this.bmi,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Modify the function to return both the color and the message
  Map<String, dynamic> getBmiCategory(String bmiString) {
    double bmi = double.tryParse(bmiString) ?? 0;

    if (bmi < 18.5) {
      return {
        'color': Colors.blue,
        'message': 'Underweight'
      };
    } else if (bmi < 24.9) {
      return {
        'color': Colors.green,
        'message': 'Normal Weight'
      };
    } else if (bmi < 29.9) {
      return {
        'color': Colors.orange,
        'message': 'Overweight'
      };
    } else {
      return {
        'color': Colors.red,
        'message': 'Obesity'
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the BMI category and color from the function
    var bmiCategory = getBmiCategory(widget.bmi);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Result"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            Text("Weight: ${widget.weight} kg", style: TextStyle(fontSize: 23)),
            Text("Height: ${widget.height} m", style: TextStyle(fontSize: 23)),
            Text(
              "BMI: ${widget.bmi}",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: bmiCategory['color'], // Use color from bmiCategory
              ),
            ),
            SizedBox(height: 20),
            Text(
              bmiCategory['message'], // Display BMI category message
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: bmiCategory['color'], // Same color for the message
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
