import 'package:flutter/material.dart';
import 'product.dart';
import 'search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _load = false; // used to show products list or progress bar

  void update(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) { // API request failed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }


  @override
  void initState() {
    // update data when the widget is added to the tree the first tome.
    updateProducts(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(12, 65, 91, 1.0),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromRGBO(12, 65, 91, 1.0),
          actions: [
            IconButton(
                onPressed: !_load ? null : () {
                  setState(() {
                    _load = false; // show progress bar
                    updateProducts(update); // update data asynchronously
                  });
                  },
                icon: const Icon(Icons.refresh)
            ),
          ],
          title: Image.asset('assets/images/logo.png', height: 100, width: 100,),
          centerTitle: true,
        ),
        floatingActionButton: IconButton(
            color: Colors.white,
            onPressed: () {
              setState(() { // open the search product page
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Search())
                );
              });
              },
            icon: const Icon(Icons.search)
        ),
        // load products or progress bar
        body: _load ? const ShowProducts() : const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
        )
    );
  }
}
