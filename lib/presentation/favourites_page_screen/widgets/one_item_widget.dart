import 'package:flutter/material.dart';
import 'package:library_ece/core/app_export.dart';
import 'package:library_ece/widgets/custom_search_view.dart';

// ignore: must_be_immutable
class OneItemWidget extends StatelessWidget {
  OneItemWidget({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 29.h,
        vertical: 18.v,
      ),
      decoration: AppDecoration.fillBlueGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 15.v),
          CustomSearchView(
            controller: searchTextController,
            hintText: "  Αναζητήστε εδώ",
          ),
          SizedBox(height: 20.v),
          Text(
            "Αγαπημένα",
            style: CustomTextStyles.bodyMediumBlack900,
          ),
        ],
      ),
    );
  }
}
