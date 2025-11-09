// Created by Simba Z for Unit 7 PizzaList Project
// Purpose: Data model defining pizza sizes, prices, and descriptions

// Constant lists that remain unchanged throughout the app
final PIZZA_PRICES = [7.99, 9.99, 12.99, 14.99];
final PIZZA_SIZES = ["Small", "Medium", "Large", "X-Large"];

class Pizza {
  // Core properties for each pizza
  String toppings;
  String description;
  double price;
  int size; // 0=Small, 1=Medium, 2=Large, 3=X-Large

  // Constructor assigns a topping and a size index, and calculates the rest
  Pizza(this.toppings, this.size)
      : price = PIZZA_PRICES[size],
        description =
            'A ${PIZZA_SIZES[size]} pizza topped with $toppings, priced at \$${PIZZA_PRICES[size].toStringAsFixed(2)}.0';

  // Returns a properly formatted string for the pizza price
  String getPrice() {
    return '\$${price.toStringAsFixed(2)}';
  }

  // Converts pizza details into an easy-to-read string (useful for debugging)
  @override
  String toString() {
    return 'Pizza Details: $description';
  }
}
