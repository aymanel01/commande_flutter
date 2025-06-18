import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../viewmodels/cart_view_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context, listen: false);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: Image.network(item.product.thumbnail, width: 50, fit: BoxFit.cover),
        title: Text(item.product.title),
        subtitle: Row(
          children: [
            Text('Quantité: '),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                cart.updateQuantity(item.product, item.quantity - 1);
              },
            ),
            Text('${item.quantity}'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                cart.updateQuantity(item.product, item.quantity + 1);
              },
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${item.totalPrice.toStringAsFixed(2)} \$'),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                cart.removeFromCart(item.product);
              },
            ),
          ],
        ),
      ),
    );
  }
}
