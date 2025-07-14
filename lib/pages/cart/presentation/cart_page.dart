import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/core/widgets/app_buttons.dart';
import 'package:guruh3/pages/cart/presentation/cubit/cart_cubit.dart';
import 'package:guruh3/pages/cart/presentation/cubit/cart_state.dart';
import 'package:guruh3/pages/orders/presentation/cubit/order_cubit.dart';
import 'package:guruh3/pages/orders/presentation/view/order_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else if (state is CartSuccess) {
            final cartItems = state.cartItems;
            if (cartItems.isEmpty) {
              return Center(child: Text('Your cart is empty'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final book = cartItems[index].book;
                      return ListTile(
                        title: Text(book.title),
                        subtitle: Text('Price: \$${book.price}'),
                        trailing:
                            Text('Quantity: ${cartItems[index].quantity}'),
                      );
                    },
                  ),
                ),
                PrimaryButton(
                  radius: 48.0,
                  height: 48.0,
                  text: 'Order',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BlocProvider(
                            create: (context) => OrderCubit(),
                            child: OrderPage(cart: state.cartItems),
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.0)
              ],
            );
          }
          return Center(child: Text('Unexpected state'));
        },
      ),
    );
  }
}
