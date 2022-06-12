import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.grey),
      child: Center(
        child: Lottie.asset('assets/sucess.json'),
      ),
    );
  }
}
