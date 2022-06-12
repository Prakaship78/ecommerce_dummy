import 'package:ecommerce/widgets/sucess_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class CartCheckoutWidget extends StatelessWidget {
  final String? subtotal;
  final String? charges;
  final String? total;
  const CartCheckoutWidget({
    Key? key,
    this.subtotal,
    this.charges,
    this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      height: MediaQuery.of(context).size.height * 0.28,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Order Info',
            style: TextStyle(
                letterSpacing: 1,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                Text(
                  "\$${subtotal ?? ''}",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Shipping Charges',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                Text(
                  "\$${charges ?? ''}",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                Text(
                  "\$${total ?? ''}",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.black87),
            onPressed: () {
              Get.bottomSheet(const SuccessWidget(), isScrollControlled: false);
            },
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Pay Now ',
                    style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    height: 30,
                    child: Lottie.asset('assets/payment.json'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
