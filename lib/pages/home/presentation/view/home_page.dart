import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:guruh3/pages/auth/presentation/view/login_page.dart';
import 'package:guruh3/pages/cart/presentation/cart_page.dart';
import 'package:guruh3/pages/cart/presentation/cubit/cart_cubit.dart';
import 'package:guruh3/pages/home/data/models/category_model.dart';
import 'package:guruh3/pages/home/presentation/cubit/vendors/vendors_categories_cubit.dart';
import 'package:guruh3/pages/home/presentation/cubit/vendors/vendors_cubit.dart';
import 'package:guruh3/pages/home/presentation/cubit/vendors/vendors_state.dart';
import 'package:guruh3/pages/orders/presentation/cubit/order_cubit.dart';
import 'package:guruh3/pages/orders/presentation/view/my_orders_page.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<VendorsCategoriesCubit>().getVendorCategories();
    context.read<VendorsCubit>().getVendors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => CartCubit(),
                        child: CartPage(),
                      );
                    },
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: BlocBuilder<VendorsCategoriesCubit, VendorsState>(
                builder: (context, state) {
                  if (state is VendorsLoading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.white,
                      child: ListView.separated(
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 20.0),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is VendorsError) {
                    return Center(child: Text(state.message));
                  } else if (state is VendorsCategoriesSuccess) {
                    return ListView.separated(
                      itemCount: state.categories.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 20.0),
                      itemBuilder: (context, index) {
                        final CategoryModel category = state.categories[index];
                        return InkWell(
                          onTap: () {
                            context.read<VendorsCubit>().getVendors(
                                  category: category.id.toString(),
                                );
                          },
                          child: Text(category.name),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text(state.runtimeType.toString()));
                  }
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<VendorsCubit, VendorsState>(
                builder: (context, state) {
                  if (state is VendorsLoading) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is VendorsError) {
                    return Center(child: Text(state.message));
                  } else if (state is VendorsSuccess) {
                    if (state.vendors.isEmpty) {
                      return Center(
                        child: Text('No vendors found'),
                      );
                    } else {
                      return GridView.builder(
                        itemCount: state.vendors.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.amber,
                            child: Text(state.vendors[index].name),
                          );
                        },
                      );
                    }
                  } else {
                    return Center(child: Text(state.runtimeType.toString()));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 20.0,
        children: [
          FloatingActionButton(
            heroTag: 'order',
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => OrderCubit(),
                      child: MyOrdersPage(),
                    );
                  },
                ),
              );
            },
            child: Icon(Icons.shopping_bag),
          ),
          FloatingActionButton(
            heroTag: 'logout',
            onPressed: () async {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => AuthCubit(),
                          child: LoginPage(),
                        )),
                (route) => false,
              );
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
