//Flutter app that displays and adds pizzas dynamically to an order list

import 'package:flutter/material.dart';
import 'package:unit7_pizzalist/pizza.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // The main widget that initializes the app theme and home page
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: "Simba's Pizza Place"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Store pizzas added to the order here
  List<Pizza> pizzasInOrder = [];

  @override
  void initState() {
    super.initState();
    // Add a few pizzas at start just for display purposes
    pizzasInOrder.add(Pizza("Cheese", 1));
    pizzasInOrder.add(Pizza("Sausage", 2));
  }

  void _addPizza() {
    // Placeholder for dialog function
    print("addPizza called");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        // number of pizza items to render
        itemCount: pizzasInOrder.length,
        // defines the layout for each pizza card
        itemBuilder: (BuildContext context, int index) {
          final currentPizza = pizzasInOrder[index];

          // Create a card-style display for each pizza entry
          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              leading: const Icon(Icons.local_pizza, color: Colors.deepOrange),
              title: Text(currentPizza.description),
              subtitle: Text("Price: ${currentPizza.getPrice()}"),
              trailing: Text(PIZZA_SIZES[currentPizza.size]),
            ),
          );
        },
      ),
      // Floating button for adding a new pizza
      floatingActionButton: FloatingActionButton(
        onPressed: _addPizzaSimpler,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Opens a dialog for adding a new pizza entry
  void _addPizzaSimpler() {
    final TextEditingController toppingsController = TextEditingController();
    int tempSizeIndex = 0;

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Build Your Pizza'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: toppingsController,
                    decoration: const InputDecoration(labelText: 'Toppings'),
                  ),
                  const SizedBox(height: 20),
                  Text('Size: ${PIZZA_SIZES[tempSizeIndex]}'),

                  // Slider to select pizza size interactively
                  Slider(
                    value: tempSizeIndex.toDouble(),
                    min: 0,
                    max: (PIZZA_SIZES.length - 1).toDouble(),
                    divisions: PIZZA_SIZES.length - 1,
                    onChanged: (double newValue) {
                      setState(() {
                        tempSizeIndex = newValue.round();
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Create a new pizza and add to main list
                final newPizza =
                    Pizza(toppingsController.text.trim(), tempSizeIndex);

                // Refresh the state to show new item in UI
                setState(() {
                  pizzasInOrder.add(newPizza);
                });
                Navigator.pop(dialogContext);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
