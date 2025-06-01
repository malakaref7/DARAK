import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ARViewWidget(),
      ),
    );
  }
}

class ARViewWidget extends StatefulWidget {
  @override
  _ARViewWidgetState createState() => _ARViewWidgetState();
}

class _ARViewWidgetState extends State<ARViewWidget> {
  late ARSessionManager arSessionManager;

  @override
  Widget build(BuildContext context) {
    return ARView(
      onARViewCreated: onARViewCreated,
    );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    arSessionManager = arSessionManager;
    arObjectManager = arObjectManager;

    // this.arSessionManager.onInitialize(
    //       showFeaturePoints: false,
    //       showPlanes: true,
    //       showWorldOrigin: true,
    //       handleTaps: false,
    //     );

    arObjectManager.onInitialize();
  

  // Load and place the 3D model
  ARNode node = ARNode(
    type: NodeType.webGLB,
    uri: 'https://modelviewer.dev/assets/ShopifyModels/Chair.glb',  // Replace with a link to your 3D model
    scale: Vector3(0.5, 0.5, 0.5),
    position: Vector3(0, 0, -1),  
  );

  // arObjectManager.addNode(node);

  ARNode node2 = ARNode(
    type: NodeType.webGLB,
    uri: 'https://modelviewer.dev/assets/ShopifyModels/Chair.glb',  // Replace with a link to your 3D model
    scale: Vector3(0.5, 0.5, 0.5),
    position: Vector3(0, 1, -1),  // 1 meter in front of the user
  );

  arObjectManager.addNode(node2);
 }

  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
  }
}




