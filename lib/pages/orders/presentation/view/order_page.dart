import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/core/constants/app_colors.dart';
import 'package:guruh3/core/widgets/app_buttons.dart';
import 'package:guruh3/pages/cart/data/models/cart_model.dart';
import 'package:guruh3/pages/orders/presentation/cubit/order_cubit.dart';
import 'package:guruh3/pages/orders/presentation/cubit/order_state.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  final List<CartItemModel> cart;
  const OrderPage({super.key, required this.cart});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  double sum = 0.0;

  @override
  void initState() {
    super.initState();
    for (var item in widget.cart) {
      sum += item.book.price * item.quantity;
    }
  }

  DateTime? _selectedDate;
  final DateFormat format = DateFormat('dd.MM.yyyy HH:mm');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                spacing: 10.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summary',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price'),
                      Text('\$$sum'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping'),
                      Text('\$2'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total payment'),
                      Text('\$${sum + 2}'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                spacing: 10.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summary',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  ListTile(
                    onTap: () async {
                      final result = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: _selectedDate ?? DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 30)),
                      );
                      if (result != null) {
                        _selectedDate = result;
                        final timeResult = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (timeResult != null) {
                          _selectedDate = DateTime(
                            _selectedDate!.year,
                            _selectedDate!.month,
                            _selectedDate!.day,
                            timeResult.hour,
                            timeResult.minute,
                          );

                          final minTime =
                              DateTime.now().add(Duration(hours: 2));

                          if (_selectedDate!.isBefore(minTime)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Please select a time at least 2 hours from now.'),
                              ),
                            );
                          } else {
                            setState(() {});
                          }
                        }
                      }
                    },
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    title: _selectedDate == null
                        ? Text('Date & time')
                        : Text(format.format(_selectedDate!)),
                    subtitle: _selectedDate == null
                        ? Text('Choose date and time ')
                        : null,
                    trailing: Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
            BlocConsumer<OrderCubit, OrderState>(
              listener: (context, state) {
                if (state is OrderError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is OrderSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Order placed successfully!')),
                  );
                }
              },
              builder: (context, state) {
                return PrimaryButton(
                  radius: 48.0,
                  height: 48.0,
                  text: state is OrderLoading ? 'Loading' : 'Order',
                  onPressed: state is OrderLoading
                      ? null
                      : _selectedDate == null
                          ? null
                          : () {
                              context.read<OrderCubit>().placeOrder(
                                    41.2995,
                                    69.2401,
                                    format.format(_selectedDate!),
                                  );
                            },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
