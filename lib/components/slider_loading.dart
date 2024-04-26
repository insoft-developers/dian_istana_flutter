import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SliderLoading extends StatelessWidget {
  const SliderLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: AspectRatio(
                aspectRatio: 16 / 8,
                child: Container(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
