import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../data/response/division_response.dart';

class ItemDivision extends StatelessWidget {
  const ItemDivision({super.key, required this.division});

  final Division division;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0.r),
        border: Border.all(),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(20.0).r,
      child: ListTile(
        onTap: () {},
        title: DrawableText(text: ''),
        subtitle: DrawableText(text: ''),
        leading: ImageMultiType(url: ''),
        trailing: ImageMultiType(url: Icons.arrow_forward_ios, height: 20.0.r, color: Colors.grey),
      ),
    );
  }
}
