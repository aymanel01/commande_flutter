import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../viewmodels/cart_view_model.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _isSending = false;
  String? _confirmationMessage;

  Future<void> _submitOrder() async {
    setState(() {
      _isSending = true;
      _confirmationMessage = null;
    });

    final cart = Provider.of<CartViewModel>(context, listen: false);
    final items = cart.items
        .map((e) => {
              'productId': e.product.id,
              'title': e.product.title,
              'quantity': e.quantity,
              'total': e.totalPrice,
            })
        .toList();

    final payload = json.encode({
      'items': items,
      'totalPrice': cart.totalPrice,
      'timestamp': DateTime.now().toIso8601String(),
    });

    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Content-Type': 'application/json'},
        body: payload,
      );

      if (response.statusCode == 201) {
        setState(() {
          _confirmationMessage = 'Commande envoyée avec succès !';
        });
        cart.clearCart(); // vider le panier après succès
      } else {
        setState(() {
          _confirmationMessage = 'Échec de l’envoi. Code : ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _confirmationMessage = 'Erreur : $e';
      });
    }

    setState(() {
      _isSending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Validation de commande')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isSending
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total : ${cart.totalPrice.toStringAsFixed(2)} \$', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _submitOrder,
                    icon: Icon(Icons.send),
                    label: Text('Envoyer la commande'),
                  ),
                  if (_confirmationMessage != null) ...[
                    SizedBox(height: 20),
                    Text(_confirmationMessage!, style: TextStyle(color: Colors.green, fontSize: 16)),
                  ]
                ],
              ),
      ),
    );
  }
}
