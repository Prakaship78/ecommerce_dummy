// ignore_for_file: invalid_use_of_protected_member

import 'package:ecommerce/controller/homepage_controller.dart';
import 'package:ecommerce/model/products_model.dart';
import 'package:ecommerce/service/products_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'homepage_test.mocks.dart';

class ProductServiceTest extends Mock implements ProductsService {}

@GenerateMocks([ProductServiceTest])
void main() {
  late HomepageController sut;
  late MockProductServiceTest mockProductServiceTest;

  //SETUP RUN BEFORE EVERY TEST
  setUp(
    () {
      mockProductServiceTest = MockProductServiceTest();
      sut = HomepageController(mockProductServiceTest);
    },
  );

  test('testing repo using mock', () async {
    final model = <ProductsModel>[];
    when(mockProductServiceTest.getProducts()).thenAnswer((_) async {
      return model;
    });
    final res = await mockProductServiceTest.getProducts();

    expect(res, isA<List<ProductsModel>>());
    expect(res, model);
  });

  test('testing fetch repo throws exception', () async {
    when((mockProductServiceTest.getProducts())).thenAnswer((_) async {
      throw Exception();
    });

    final res = mockProductServiceTest.getProducts();
    expect(res, throwsException);
  });

  //TEAR DOWN RUN AFTER EVERY TEST
  // tearDown(body)

  //initial trial test
  test('Just a trial test to check is setup is correct', () {
    expect(sut.products.value, []);
    expect(sut.isLoading.value, false);
  });

  group('Homepage Controller tests', () {
    test('Controller fetch function test', () async {
      final model = <ProductsModel>[
        ProductsModel(brand: 'test branch 1', description: 'test desc 1')
      ];
      when(mockProductServiceTest.getProducts()).thenAnswer((_) async {
        return model;
      });
      expect(sut.isLoading.value, false);
      final future = sut.fetchProducts();
      expect(sut.isLoading.value, true);
      await future;
      expect(sut.products.value, model);
      expect(sut.isLoading.value, false);
    });

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
