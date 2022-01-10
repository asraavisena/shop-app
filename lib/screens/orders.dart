import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/orders.dart' as orderprovider;
import '../widgets/order_item.dart' as orderwidget;

class Orders extends StatelessWidget {
  static const routeName = '/orders';
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<orderprovider.Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Order'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemBuilder: (ctx, i) {
            return orderwidget.OrderItem(
              order: orders.orders[i],
            );
          },
          itemCount: orders.orders.length),
    );
  }
}
