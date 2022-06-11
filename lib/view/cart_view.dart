import 'package:ecommerce/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/cart_checkout_widget.dart';
import '../widgets/cart_listtile_widget.dart';

class CartView extends StatelessWidget {
  CartView({Key? key}) : super(key: key);
  final _controller = Get.find<HomepageController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          leading: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey, width: 0)),
            child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                )),
          ),
          title: const Text(
            'Back to Home',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Obx(() {
          return _controller.cartProducts.isEmpty
              ? const Center(
                  child: Text(
                    'Your cart is empty',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                )
              : Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: ListView.builder(
                    itemCount: _controller.cartProducts.length,
                    itemBuilder: (context, index) {
                      return CartListileWidget(
                        imageUrl: _controller.cartProducts[index].imageUrl,
                        title: _controller.cartProducts[index].name,
                        price: _controller.cartProducts[index].price.toString(),
                        quantity: 1.toString(),
                        onRemove: () {
                          _controller.cartProductIds
                              .remove(_controller.cartProducts[index].id);
                          _controller.cartProducts.removeAt(index);

                          _controller.products.refresh();
                        },
                      );
                    },
                  ),
                );
        }),
        bottomNavigationBar: Obx(() {
          return _controller.cartProducts.isEmpty
              ? const SizedBox()
              : const CartCheckoutWidget();
        }),
      ),
    );
  }
}
