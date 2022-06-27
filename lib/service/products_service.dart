import 'package:ecommerce/model/products_model.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

class ProductsService {
  Future<List<ProductsModel>> getProducts() async {
    var client = http.Client();

    var response = await client.get(
      Uri.parse(Constant.url),
    );
    if (response.statusCode == 200) {
      return productsModelFromJson(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
