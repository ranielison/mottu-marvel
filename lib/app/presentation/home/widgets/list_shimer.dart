import 'package:flutter/material.dart';
import 'package:mottu_marvel/app/core/widgets/data_shimmer.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          DataShimmer(height: 84),
          SizedBox(height: 4),
          DataShimmer(height: 84),
          SizedBox(height: 4),
          DataShimmer(height: 84),
          SizedBox(height: 4),
          DataShimmer(height: 84),
          SizedBox(height: 4),
          DataShimmer(height: 84),
        ],
      ),
    );
  }
}
