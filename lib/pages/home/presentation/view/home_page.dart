import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/pages/cart/data/repo/cart_repo.dart';
import 'package:guruh3/pages/home/data/models/category_model.dart';
import 'package:guruh3/pages/home/presentation/cubit/vendors/vendors_categories_cubit.dart';
import 'package:guruh3/pages/home/presentation/cubit/vendors/vendors_cubit.dart';
import 'package:guruh3/pages/home/presentation/cubit/vendors/vendors_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      appBar: AppBar(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await CartRepo().getCart();
          print(result[0].quantity);
          // final SharedPreferences prefs = await SharedPreferences.getInstance();
          // final String? token = prefs.getString('token');
          // if (token != null) {
          //   print(token);
          // } else {
          //   print('Null keldi');
          // }
        },
      ),
    );
  }
}
