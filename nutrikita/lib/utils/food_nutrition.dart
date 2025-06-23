import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodNutrient {
  final String name;
  final double calories;
  final double carbs;
  final double fat;
  final double protein;
  final double servingWeightGrams;

  FoodNutrient({
    required this.name,
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.servingWeightGrams,
  });

  factory FoodNutrient.fromJson(Map<String, dynamic> json) {
    return FoodNutrient(
      name: json['food_name'] ?? '',
      calories: (json['nf_calories'] ?? 0).toDouble(),
      carbs: (json['nf_total_carbohydrate'] ?? 0).toDouble(),
      fat: (json['nf_total_fat'] ?? 0).toDouble(),
      protein: (json['nf_protein'] ?? 0).toDouble(),
      servingWeightGrams: (json['serving_weight_grams'] ?? 1).toDouble(),
    );
  }
}

Map<String, double> unitToGram = {
  'gram': 1,
  'ml': 1, // asumsikan 1ml = 1g untuk cairan
  'porsi': 100,
  'cup': 50,
  'sendok': 15,
  // tambahkan satuan lain sesuai kebutuhan
};

double convertToGram(double amount, String unit) {
  if (unitToGram.containsKey(unit)) {
    return amount * unitToGram[unit]!;
  }
  // fallback: jika tidak diketahui, return amount (anggap sudah gram)
  return amount;
}

FoodNutrient calculateNutrientByWeight(FoodNutrient base, double userWeight) {
  double multiplier = userWeight / base.servingWeightGrams;
  return FoodNutrient(
    name: base.name,
    calories: base.calories * multiplier,
    carbs: base.carbs * multiplier,
    fat: base.fat * multiplier,
    protein: base.protein * multiplier,
    servingWeightGrams: userWeight,
  );
}

FoodNutrient parseFoodNutrient(Map<String, dynamic> foodJson) {
  return FoodNutrient.fromJson(foodJson);
}

Future<String> translateToEnglish(String text) async {
  final url = Uri.parse('https://api.mymemory.translated.net/get?q=$text&langpair=id|en');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['responseData']['translatedText'] ?? text;
  }
  return text;
}

