// ignore_for_file: invalid_use_of_protected_member

import 'package:ecommerce/controller/homepage_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomepageController sut;

  //SETUP RUN BEFORE EVERY TEST
  setUp(
    () {
      sut = HomepageController();
    },
  );

  //TEAR DOWN RUN AFTER EVERY TEST
  // tearDown(body)

  //initial trial test
  test('Just a trial test to check is setup is correct', () {
    expect(sut.products.value, []);
    expect(sut.isLoading.value, false);
  });

  group('Homepage Controller tests', () {
    test(
      ''' FETCH DATA FROM JSON
     isLoading 
    Products after api call
    isLoading after api call
    
     ''',
      () async {
        expect(sut.isLoading.value, false);
        await sut.fetchProducts();
        expect(sut.products.value, isNotNull);
        expect(sut.isLoading.value, false);
      },
    );

    test('Add to cart', () {
      expect(sut.cartProducts.value.length, 0);
      sut.addToCart(1, "Test name", "test image", 10, 1);
      sut.addToCart(1, "Test name", "test image", 10, 1);
      expect(sut.cartProducts.value.length, 2);
    });

    test('Calculate Add price', () {
      expect(sut.subTotal.value, 0);
      sut.calculateAddPrice(quantity: 0, price: 10);
      sut.calculateAddPrice(quantity: 01, price: 10);
      sut.calculateAddPrice(quantity: 10, price: 0);
      sut.calculateAddPrice(quantity: 05, price: 5.9);
      sut.calculateAddPrice(quantity: 02, price: 0.01);
      sut.calculateAddPrice(quantity: 0, price: 0);

      expect(sut.subTotal.value, 39.52);
    });

    test('Calculate remove price', () {
      expect(sut.subTotal.value, 0);
      sut.calculateRemovePrice(price: 10, quantity: 10);

      expect(sut.subTotal.value, -100);
    });
  });
}
