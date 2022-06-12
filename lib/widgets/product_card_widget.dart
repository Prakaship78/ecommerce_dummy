import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  final String? imageUrl;
  final bool? isAddToCart;
  final String? title;
  final String? price;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;
  const ProductCardWidget(
      {Key? key,
      this.imageUrl,
      this.title,
      this.price,
      this.onAdd,
      this.isAddToCart,
      this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? '',
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.error,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'No Image',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: isAddToCart! ? onRemove : onAdd,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor:
                            isAddToCart! ? Colors.red : Colors.black,
                        child: Icon(
                          isAddToCart! ? Icons.remove : Icons.add,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
