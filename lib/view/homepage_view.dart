// ignore_for_file: invalid_use_of_protected_member

import 'package:ecommerce/controller/homepage_controller.dart';
import 'package:ecommerce/view/cart_view.dart';
import 'package:ecommerce/widgets/product_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/cart_counter_widget.dart';

class HomePageView extends StatelessWidget {
  HomePageView({Key? key}) : super(key: key);

  final _controller = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
          title: Row(
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Image.asset('assets/handwave.png'),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Good Morning',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Prakash',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            ],
          ),
          actions: [
            Obx(() {
              return CartCounterWidget(
                onTap: () => Get.to(() => CartView(),
                    transition: Transition.rightToLeft),
                count: _controller.cartProducts.length.toString(),
              );
            })
          ],
        ),
        body: Obx(() {
          return _controller.isLoading.value
              ? const Center(
                  child: CupertinoActivityIndicator(
                  radius: 12,
                ))
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Products',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GridView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _controller.products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.7,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: (context, index) {
                              return ProductCardWidget(
                                onAdd: () => onAdd(index),
                                onRemove: () => onRemove(index,
                                    _controller.products.value[index].id!),
                                title: _controller.products[index].name ?? '',
                                price:
                                    '\$${_controller.products[index].price ?? ''}',
                                imageUrl:
                                    _controller.products[index].imageLink ?? '',
                                isAddToCart: _controller.cartProductIds
                                    .contains(
                                        _controller.products.value[index].id!),
                              );
                            }),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }

  onAdd(int index) {
    //store id seperately
    _controller.cartProductIds.add(_controller.products[index].id!);

    //Store element in cart list
    _controller.addToCart(
        _controller.products[index].id!,
        _controller.products[index].name ?? '',
        _controller.products[index].imageLink ?? '',
        double.parse(_controller.products[index].price ?? ''),
        1);
    //calculate
    _controller.calculateAddPrice(
        price: double.parse(_controller.products[index].price ?? '0.0'));
    //to refresh the ui to update the color of add button and update count on cart
    _controller.cartProductIds.refresh();
    _controller.products.refresh();
  }

  onRemove(int index, int id) {
    //removing the id stored seperately
    _controller.cartProductIds.remove(_controller.products[index].id);

    //removing the product from main list
    _controller.cartProducts.removeWhere((element) {
      if (element.id == id) {
        _controller.calculateRemovePrice(
            price: element.price!, quantity: element.quantity!);
      }

      return element.id == id;
    });

    _controller.products.refresh();
  }
}
