
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_subtitle.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class LocationPageScreen extends StatefulWidget {
  const LocationPageScreen({Key? key}) : super(key: key);

  @override
  State<LocationPageScreen> createState() => _LocationPageScreenState();
}

class _LocationPageScreenState extends State<LocationPageScreen> {
  ArCoreController? arCoreController;

  _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    _addArrow(arCoreController);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableUpdateListener: true, // Enable the update listener
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 30,
      leading: GestureDetector(
        onTap: () {
          onTapArrowLeft(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 5),
          child: Icon(
            Icons.arrow_back,
            color: appTheme.blueGray100,
            size: 28,
          ),
        ),
      ),
      title: AppbarSubtitle(
        text: "Νavigation",
        margin: EdgeInsets.only(left: 14),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  void _addArrow(ArCoreController? arCoreController) async {
    final ByteData textureBytes =
    await rootBundle.load('assets/images/img_location.png');
    final materials = ArCoreMaterial(
      color: Colors.blue,
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final arrow = ArCoreCylinder(
      materials: [materials],
      radius: 0.05,
      height: 0.5,
    );

    final initialPosition = vector.Vector3(-1, 0, -2);

    final node = ArCoreNode(
      shape: arrow,
      position: initialPosition,
      rotation: vector.Vector4(1, 0, 0, -1),
    );

    arCoreController!.addArCoreNode(node);
  }
}
