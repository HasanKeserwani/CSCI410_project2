import 'package:flutter/material.dart';

import 'home.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(12, 65, 91, 1.0),
      body: Column(
        children: [
          //logo
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/images/logo.png', height: 400, width: 400,),
          ),
          //Unique and Wide Collection of Pet Products
          const Padding(
            padding: EdgeInsets.all(11.0),
            child: Text(
              'Unique and Wide Collection of Pet Products',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(50.0),
            child: Text(
              'Delivery Time 3-5 Business Days',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Home())
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(11.0),
                    child: Text(
                      'Shop Now',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(12, 65, 91, 1.0)
                      ),
                    ),
                  )
              )
          )
        ],
      ),
    );
  }
}