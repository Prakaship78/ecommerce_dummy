// ignore_for_file: invalid_use_of_protected_member

import 'package:ecommerce/model/cart_item.dart';
import 'package:ecommerce/model/products_model.dart';
import 'package:ecommerce/service/products_service.dart';
import 'package:get/get.dart';

class HomepageController extends GetxController {
  RxBool isLoading = false.obs;

  var products = <ProductsModel>[].obs;
  var cartProducts = <CartItem>[].obs;
  var cartProductIds = <int>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

//function to fetch 1st api call when page loads
  void fetchProducts() async {
    isLoading.value = true;
    products.value = await ProductsService.getProducts();
    if (products.isNotEmpty) {
      isLoading.value = false;
    }
  }

  //function to add products in cart
  addToCart(int id, String name, String imageUrl, double price, quantity) {
    cartProducts.value.add(CartItem(
        id: id,
        imageUrl: imageUrl,
        name: name,
        price: price,
        quantity: quantity));
    cartProducts.refresh();
  }
}
