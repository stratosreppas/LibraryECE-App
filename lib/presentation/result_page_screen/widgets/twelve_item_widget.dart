import 'package:flutter/material.dart';
import 'package:library_ece/core/app_export.dart';
import 'package:library_ece/widgets/custom_search_view.dart';

// ignore: must_be_immutable
class TwelveItemWidget extends StatelessWidget {
  TwelveItemWidget({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 18.v,
      ),
      decoration: AppDecoration.fillBlueGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 15.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: CustomSearchView(
              controller: searchTextController,
              hintText: "  Αναζητήστε εδώ",
            ),
          ),
          SizedBox(height: 20.v),
          Text(
            "Αναζήτηση για: Συστήματα",
            style: CustomTextStyles.bodyMediumBlack900,
          ),
        ],
      ),
    );
  }
}
