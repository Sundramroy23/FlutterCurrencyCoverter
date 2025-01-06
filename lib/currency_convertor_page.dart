import "dart:developer";

import "package:flutter/material.dart";

class CurrencyConvertorPage extends StatelessWidget {
  const CurrencyConvertorPage({super.key});

  @override
  Widget build(BuildContext context) {
    int result = 0;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 157, 49),
      body: ColoredBox(
        color: Color.fromARGB(255, 183, 234, 241),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Currency Convertor',
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 0, 83, 58),
                  fontWeight: FontWeight.w500),
            ),
            Text('Developed by the great Sundram!'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                // obscureText: true,
                autofocus: false,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.currency_rupee_outlined),
                    prefixIconColor: Color.fromARGB(255, 6, 75, 23),
                    fillColor: Color.fromARGB(255, 191, 243, 212),
                    focusColor: Color.fromARGB(255, 6, 15, 16),
                    filled: true,
                    hintFadeDuration: Duration(seconds: 2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 243, 141, 141),
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'Rupees',
                    hintText: 'Enter the amount in rupees'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 196, 215, 214),
                      elevation: 5),
                  child: const Text(
                    "Im a fooking button!",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextButton(
                  onPressed: () {
                    log("Button Pressed");
                  },
                  child: Text("I am a fooking text button")),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButton<String>(
                value: 'Option 1',
                items: <String>['Option 1', 'Option 2', 'Option 3']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  debugPrint(newValue);
                }, 
              ),
            )
          ],
        ),
      ),
    );
  }
}
