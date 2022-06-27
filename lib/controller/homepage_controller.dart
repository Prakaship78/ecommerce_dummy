// ignore_for_file: invalid_use_of_protected_member

import 'package:ecommerce/model/cart_item.dart';
import 'package:ecommerce/model/products_model.dart';
import 'package:ecommerce/service/products_service.dart';
import 'package:get/get.dart';

class HomepageController extends GetxController {
  final ProductsService _productsService;
  HomepageController(this._productsService);
  RxBool isLoading = false.obs;

  var products = <ProductsModel>[].obs;
  var cartProducts = <CartItem>[].obs;
  var cartProductIds = <int>[].obs;
  var subTotal = 0.0.obs;
  var charges = 5.0.obs;
  var totalPrice = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

//function to fetch 1st api call when page loads
  Future<void> fetchProducts() async {
    isLoading.value = true;
    products.value = await _productsService.getProducts();
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

  //calculate add price
  calculateAddPrice({int quantity = 1, double price = 0.0}) {
    final sub = price * quantity;
    subTotal.value += sub;
    totalPrice.value = subTotal.value + charges.value;
  }

  //calculate remove price
  calculateRemovePrice({int quantity = 1, double price = 0.0}) {
    final sub = price * quantity;
    subTotal.value -= sub;
    totalPrice.value = subTotal.value + charges.value;
  }

  //add quantity
  onAdd(int index) {
    if (cartProducts.value[index].quantity! < 5) {
      cartProducts.value[index].quantity =
          cartProducts.value[index].quantity! + 1;
      subTotal.value += cartProducts.value[index].price!;
      totalPrice.value = subTotal.value + charges.value;
      cartProducts.refresh();
    }
  }

  //subtract quantity
  onRemove(int index) {
    if (cartProducts.value[index].quantity! > 1) {
      cartProducts.value[index].quantity =
          cartProducts.value[index].quantity! - 1;
      1;
      subTotal.value -= cartProducts.value[index].price!;
      totalPrice.value = subTotal.value + charges.value;
      cartProducts.refresh();
    }
  }
}
