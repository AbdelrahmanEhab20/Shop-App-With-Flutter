import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders_provider.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem orderData;

  OrderItemWidget(this.orderData);

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var _expandedOrder = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$${widget.orderData.amount.toStringAsFixed(3)}'),
          subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.orderData.dateTime)),
          trailing: IconButton(
            icon: Icon(_expandedOrder
                ? Icons.expand_less_sharp
                : Icons.expand_more_sharp),
            onPressed: () {
              setState(() {
                _expandedOrder = !_expandedOrder;
              });
            },
          ),
        ),
        if (_expandedOrder)
          Container(
            /// hight with Math Package To control the height of the container
            height: min(widget.orderData.products.length * 20.0 + 60.0, 100),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: ListView(
              children: widget.orderData.products
                  .map((prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            prod.title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text('${prod.quantity} X   \$${prod.price}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 72, 71, 71)))
                        ],
                      ))
                  .toList(),
            ),
          )
      ]),
    );
  }
}
