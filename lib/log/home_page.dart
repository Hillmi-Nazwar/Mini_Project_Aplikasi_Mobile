import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'fet.dart';
class HomePage extends StatefulWidget {
  final String fullName;

  const HomePage({super.key, required this.fullName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MenuItem> _makanan = [
    MenuItem(name: "Makanan 1", price: 5000),
    MenuItem(name: "Makanan 2", price: 5000),
    MenuItem(name: "Makanan 3", price: 5000),
    MenuItem(name: "Makanan 4", price: 5000),
    MenuItem(name: "Makanan 5", price: 5000),
  ];

  final List<MenuItem> _minuman = [
    MenuItem(name: "Minuman 1", price: 7000),
    MenuItem(name: "Minuman 2", price: 7000),
    MenuItem(name: "Minuman 3", price: 7000),
    MenuItem(name: "Minuman 4", price: 7000),
    MenuItem(name: "Minuman 5", price: 7000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MENUS', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text("Makanan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ..._makanan.map((item) => MenuItemCard(item: item, onChanged: () => setState(() {}))).toList(),
            const SizedBox(height: 20),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text("Minuman", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ..._minuman.map((item) => MenuItemCard(item: item, onChanged: () => setState(() {}))).toList(),
            const SizedBox(height: 50),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to transaction page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Transaction"),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _makanan.forEach((item) => item.quantity = 0);
                    _minuman.forEach((item) => item.quantity = 0);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Reset"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  final String name;
  final double price;
  int quantity;

  MenuItem({required this.name, required this.price, this.quantity = 0});
}

class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onChanged;

  const MenuItemCard({super.key, required this.item, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(item.quantity.toString()),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text("Rp. ${item.price.toStringAsFixed(0)}", style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (item.quantity > 0) {
                      item.quantity--;
                      onChanged();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text("-", style: TextStyle(fontSize: 20)),
                  ),
                ),
                const VerticalDivider(width: 1),
                GestureDetector(
                  onTap: () {
                    item.quantity++;
                    onChanged();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text("+", style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
