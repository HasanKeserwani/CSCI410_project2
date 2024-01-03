import 'dart:convert';
import 'package:flutter/material.dart';
import 'product.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // controller to store product pid
  final TextEditingController _controllerID = TextEditingController();
  String _text = ''; // displays product info or error message

  @override
  void dispose() {
    _controllerID.dispose();
    super.dispose();
  }

  // update product info or display error message
  void update(String text) {
    setState(() {
      _text = text;
    });
  }

  // called when user clicks on the find button
  void getProduct() {
    try {
      int pid = int.parse(_controllerID.text);
      searchProduct(update, pid); // search asynchronously for product record
    }
    catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('wrong arguments')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(12, 65, 91, 1.0),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(12, 65, 91, 1.0),
        title: Image.asset('assets/images/logo.png', height: 100, width: 100,),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Row(
              children: [
                const SizedBox(width: 10),
                SizedBox(
                    width: 250,
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.white, // Change this color to set the text color
                      ),
                      controller: _controllerID,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white, // Change this color to set the border color
                            width: 1.0, // Change the border width if needed
                          ),
                        ),
                        hintText: 'Enter ID',
                        hintStyle: TextStyle(
                          color: Colors.white, // Change this color to set the hint text color
                        ),
                      ),
                    )
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                    onPressed: getProduct,
                    child: const Text(
                        'Find',
                        style: TextStyle(fontSize: 18)
                    )
                ),
              ],
            ),
            const SizedBox(height: 40),
            Flexible(
                child: Text(
                    _text,
                    style: const TextStyle(fontSize: 18, color: Colors.white)
                )
            ),
          ],
        ),
      ),
    );
  }
}
