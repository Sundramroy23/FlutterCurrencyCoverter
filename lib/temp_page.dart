import 'package:flutter/material.dart';
// import 'packet:flutter/material.dart';

class TempPage extends StatefulWidget {
  const TempPage({super.key});

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  final TextEditingController _textController = TextEditingController();
  double value = 0.0;
  double fetchAmt() {
    double dollars = double.parse(_textController.text);
    _textController.clear();
    setState(() {
      value = dollars * 81;
    });
    return value;
  }

  void reset() {
    value = 0.0;
    _textController.clear();
    setState(() {});
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
                margin: const EdgeInsets.only(top: 75),
                child: Text(
                  "INR $value",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  // prefixIcon: Icon(Icons.currency_rupee_outlined),
                  controller: _textController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                        child: const Text(
                          "\$",
                          style: TextStyle(fontSize: 20),
                        )),
                    // icon: Icon(Icons.currency_rupee_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    hintText: 'Enter USD',
                    // icon: Icon(Icons.currency_rupee_outlined),
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, left: 10, bottom: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          fetchAmt();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 27, 95, 151),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          foregroundColor: Colors.white,
                          elevation: 10,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('CONVERT'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Add spacing between the buttons
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, right: 10, bottom: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          reset();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 151, 52, 27),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          foregroundColor: Colors.white,
                          elevation: 10,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('RESET'),
                      ),
                    ),
                  ),
                ],
              )

              // Container(
              //   margin: EdgeInsets.all(10),
              //   // padding: EdgeInsets.all(10),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       fetchAmt();
              //       // print(value);
              //     },
              //     style: TextButton.styleFrom(
              //       backgroundColor: const Color.fromARGB(
              //         255,
              //         27,
              //         95,
              //         151,
              //       ),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       foregroundColor: Colors.white,
              //       elevation: 10,
              //       minimumSize: const Size(double.infinity, 50),
              //       // fixedSize: Size(double.infinity, 20)
              //     ),
              //     child: const Text('CONVERT'),
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.all(10),
              //   // padding: EdgeInsets.all(10),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       reset();
              //       // print(value);
              //     },
              //     style: TextButton.styleFrom(
              //       backgroundColor: const Color.fromARGB(255, 151, 52, 27),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       foregroundColor: Colors.white,
              //       elevation: 10,
              //       minimumSize: const Size(double.infinity, 50),
              //       // fixedSize: Size(double.infinity, 20)
              //     ),
              //     child: const Text('RESET'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

//use TextButton.styleFrom for styling without using MaterialStatePropertyAll everytime...
