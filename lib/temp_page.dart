import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class TempPage extends StatefulWidget {
  const TempPage({super.key});

  @override
  State<TempPage> createState() => _TempPageState();
}

class ExchangeRateService {
  // final String url = dotenv.env['EXCHANGE_RATE_API_URL'] ?? '';
  final String url = "https://v6.exchangerate-api.com/v6/##/latest/USD";

  Future<double?> getUsdToInrRate() async {
    try {
      if (url.isEmpty) {
        throw Exception("API URL not configured correctly.");
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rates = data['conversion_rates'];
        return rates['INR'];
      } else {
        throw Exception("Failed to fetch rates. HTTP Status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching exchange rate: $e");
      return null;
    }
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const CustomButton({
    required this.label,
    required this.onPressed,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundColor: Colors.white,
          elevation: 10,
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(label),
      ),
    );
  }
}

class _TempPageState extends State<TempPage> {
  final TextEditingController _textController = TextEditingController();
  double exchangeRate = 0.0;
  double convertedValue = 0.0;
  String apiErrorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
  }

  Future<void> fetchExchangeRate() async {
    final rate = await ExchangeRateService().getUsdToInrRate();
    setState(() {
      if (rate != null) {
        exchangeRate = rate;
      } else {
        apiErrorMessage = "Failed to fetch the exchange rate. Using fallback value.";
        exchangeRate = 85.76;
      }
    });
  }

  void convertAmount() {
    final double dollars = double.tryParse(_textController.text) ?? 0.0;

    if (dollars == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid USD amount.")),
      );
      return;
    }

    setState(() {
      convertedValue = dollars * exchangeRate;
    });
  }

  void reset() {
    setState(() {
      convertedValue = 0.0;
      _textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 241, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 208, 241, 247),
        centerTitle: true,
        title: const Text('USD to INR'),
      ),
      body: Center(
        child: Container(
          height: 350,
          width: 350,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 157, 235, 245),
                Color.fromARGB(255, 195, 237, 243),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                offset: Offset(2, 2),
                color: Color.fromARGB(255, 6, 15, 16),
                spreadRadius: 0.2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: convertedValue > 0.0
                    ? Text(
                        "INR ${convertedValue.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : exchangeRate > 0.0
                        ? const Text("Enter USD to Convert", style: TextStyle(fontSize: 16))
                        : const CircularProgressIndicator(),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  controller: _textController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      child: const Text(
                        "\$",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    hintText: 'Enter USD',
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomButton(
                      label: "CONVERT",
                      onPressed: convertAmount,
                      color: const Color.fromARGB(255, 27, 95, 151),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      label: "RESET",
                      onPressed: reset,
                      color: const Color.fromARGB(255, 238, 33, 33),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (apiErrorMessage.isNotEmpty)
                Text(
                  apiErrorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
