import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_subtitle.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPageScreen extends StatefulWidget {
  const LocationPageScreen({Key? key}) : super(key: key);

  @override
  State<LocationPageScreen> createState() => _LocationPageScreenState();
}

class _LocationPageScreenState extends State<LocationPageScreen> {
  ArCoreController? arCoreController;
  late Position position;
  String? locationText =
      'Φαίνεται πως δε βρίσκεστε στο χώρο της βιβλιοθήκης. Παρακαλώ προσπαθήστε ξανά όταν βρίσκεστε εντός αυτού.';
  final double latitude = 38.0961649;
  final double longitude = 23.8178306;

  _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    _addArrow(arCoreController);
  }

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body: isCloseToTargetLocation() // 38.0961649, 23.8178306
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    locationText ?? 'Loading...',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            : ArCoreView(
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

  Future<void> getLocation() async {
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> requestLocationPermission() async {
    // Check if permission is already granted
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      print("Location permission granted");
      getLocation();
    } else {
      // If permission is not granted, request it
      var result = await Permission.location.request();
      if (result == PermissionStatus.granted) {
        getLocation();
      } else {
        setState(() {
          locationText = 'Permission denied';
        });
      }
    }
  }

  bool isCloseToTargetLocation() {
    print(position.latitude);
    print(position.longitude);
    if (position.latitude == null || position.longitude == null) {
      return false;
    }

    // Define a threshold for proximity (adjust as needed)
    double proximityThreshold = 0.1;

    // Calculate the distance between the current and target locations
    double distance = Geolocator.distanceBetween(
      position.latitude!,
      position.longitude!,
      latitude,
      longitude,
    );

    print(distance);

    // Check if the distance is less than the threshold
    return distance < proximityThreshold;
  }
}
