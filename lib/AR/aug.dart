import 'dart:async';
import 'bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart' as vec;
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: 'AR Anchors Demo',
      home: ObjectGesturesWidget(), // Main widget for the AR view
    );
  }
}

class ObjectGesturesWidget extends StatefulWidget {
  const ObjectGesturesWidget({super.key});

    @override
  // ignore: library_private_types_in_public_api
  _ObjectGesturesWidgetState createState() => _ObjectGesturesWidgetState();
}


class _ObjectGesturesWidgetState extends State<ObjectGesturesWidget> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  String? selectedNodeName;
  String? pendingModelUrl;
  Map<ARNode, ARAnchor> nodeAnchorMap = {};
  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];


  @override
  void dispose() {
    super.dispose();
    arSessionManager?.dispose();
  }

 bool isMenuExpanded = false;

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        ARView(
          onARViewCreated: onARViewCreated,
          planeDetectionConfig: PlaneDetectionConfig.horizontal,
        ),
        // Floating vertical menu in bottom-left corner
// Add furniture button (top-right)
Positioned(
  bottom: 40,
  right: 20,
  child: FloatingActionButton(
    backgroundColor: Colors.brown,
    child: Icon(Icons.add),
    onPressed: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return BottomSheetWidget(
            categories: ['Chairs', 'Sofa', 'Lamps', 'Beds', 'Mirrors','Side tables', 'Coffee tables', 'Dining table','Dressing table', 'Wardrobe','TV Tables', 'Carpets'], // Add your actual categories here
            onModelSelected: (String glbUrl) async {
              Navigator.of(context).pop(); // Close bottom sheet
              setState(() {
                pendingModelUrl = glbUrl;
              });
              // Now wait for user tap on AR plane to place model
            },
          );
        },
      );
    },
  ),
),
// Floating vertical menu in bottom-left corner
Positioned(
  bottom: 20,
  left: 10,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // The full-height menu stack space
      AnimatedCrossFade(
        firstChild: Column(
          children: [
            arMenuButton(Icons.zoom_in, "Scale +", () => onScaleSelectedNode(1.1)),
            arMenuButton(Icons.zoom_out, "Scale -", () => onScaleSelectedNode(0.9)),
            arMenuButton(Icons.delete_forever, "Remove All", onRemoveEverything),
            arMenuButton(Icons.delete_outline, "Remove One", onRemoveSelectedNodeAndAnchor),
            arMenuButton(Icons.camera_alt, "Snapshot", onTakeScreenshot),
            const SizedBox(height: 8),
          ],
        ),
        secondChild: const SizedBox(
          height: 220, // Same height as above to preserve layout
        ),
        crossFadeState: isMenuExpanded
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 300),
      ),

      // Always-aligned arrow toggle
      IconButton(
        icon: Icon(
          isMenuExpanded
              ? Icons.keyboard_arrow_down
              : Icons.keyboard_arrow_up,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          setState(() {
            isMenuExpanded = !isMenuExpanded;
          });
        },
      ),
    ],
  ),
),
      ],
    ),
  );
}
Widget arMenuButton(IconData icon, String label, VoidCallback onTap) {
  return TextButton(
    onPressed: onTap,
    style: TextButton.styleFrom(
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    ),
    child: Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    ),
  );
}






  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          handlePans: true,
          handleRotation: true,
      
        );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager!.onPanStart = onPanStarted;
    this.arObjectManager!.onPanChange = onPanChanged;
    this.arObjectManager!.onPanEnd = onPanEnded;
    this.arObjectManager!.onRotationStart = onRotationStarted;
    this.arObjectManager!.onRotationChange = onRotationChanged;
    this.arObjectManager!.onRotationEnd = onRotationEnded;

  }


/////// Removes all anchors and nodes from the AR session.
Future<void> onRemoveEverything() async {
  for (final anchor in anchors) {
    await arAnchorManager!.removeAnchor(anchor);
  }
  anchors.clear();

  // Remove all nodes
  for (final node in nodes) {
    await arObjectManager!.removeNode(node);
  }
  nodes.clear();
  nodeAnchorMap.clear();
  selectedNodeName = null;

  setState(() {});
}





  /// Handles taps on the AR view to add a new anchor and node.


Future<void> onPlaneOrPointTapped(List<ARHitTestResult> hitTestResults) async {
  if (pendingModelUrl == null) {
    // No model selected to place, optionally show message or ignore tap
    return;
  }
    vec.Vector3 scale = vec.Vector3(0.2, 0.2, 0.2); // default
    if (pendingModelUrl!.contains("carpet")) {
      scale = vec.Vector3(0.1, 0.1, 0.1); // smaller scale for carpet
    }
  var singleHitTestResult = hitTestResults.firstWhere(
      (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);

  var newAnchor =
      ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
  bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);

  if (didAddAnchor!) {
    anchors.add(newAnchor);

    String nodeName = "PlacedModel_${DateTime.now().millisecondsSinceEpoch}";
    var newNode = ARNode(
      name: nodeName,
      type: NodeType.webGLB,
      uri: pendingModelUrl!, // Use the selected model URL
      scale: scale,
      position: vec.Vector3(0.0, 0.0, 0.0),
      rotation: vec.Vector4(1.0, 0.0, 0.0, 0.0),
    );

     bool? didAddNode =
          await arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
          
          
    if (didAddNode!) {
      nodes.add(newNode);
      nodeAnchorMap[newNode] = newAnchor;
      selectedNodeName = nodeName;
      setState(() {
        pendingModelUrl = null;  // Clear after placement
      });
    } else {
      arSessionManager!.onError("Adding Node to Anchor failed");
    }
  } else {
    arSessionManager!.onError("Adding Anchor failed");
  }
}


Future<void> placeObjectAboveSelectedNode(String glbUrl) async {
  if (selectedNodeName == null) {
    arSessionManager?.onError("No item selected to place above.");
    return;
  }

  ARNode? selectedNode;
  try {
    selectedNode = nodes.firstWhere((n) => n.name == selectedNodeName);
  } catch (e) {
    arSessionManager?.onError("Selected node not found.");
    return;
  }

  final vec.Matrix4 originalTransform = selectedNode.transform;

  final vec.Vector3 position = vec.Vector3.zero();
  final vec.Quaternion rotation = vec.Quaternion.identity();
  final vec.Vector3 scale = vec.Vector3.zero();
  originalTransform.decompose(position, rotation, scale);

  final vec.Vector3 newPosition = vec.Vector3(position.x, position.y + 0.3, position.z);

  final newNode = ARNode(
    name: "AboveModel_${DateTime.now().millisecondsSinceEpoch}",
    type: NodeType.webGLB,
    uri: glbUrl,
    scale: vec.Vector3(0.2, 0.2, 0.2),
    position: newPosition,
    rotation: vec.Vector4(0.0, 0.0, 0.0, 1.0),
  );

  final ARAnchor? anchor = nodeAnchorMap[selectedNode];
  if (anchor is! ARPlaneAnchor) {
    arSessionManager?.onError("Selected anchor is not a plane anchor.");
    return;
  }

  final didAdd = await arObjectManager?.addNode(newNode, planeAnchor: anchor);
  if (didAdd == true) {
    nodes.add(newNode);
    nodeAnchorMap[newNode] = anchor;
  } else {
    arSessionManager?.onError("Failed to place object above.");
  }
}


// Future<void> _addModelToScene(String glbUrl) async {
//   // Perform a hit test straight ahead from the center of the screen
//   // (you can also perform onTap on ARView to get hit results)

//   final hitTestResults = await arSessionManager?.hitTest(
//     planeType: ARHitTestResultType.plane,
//     screenPosition: Offset(
//       MediaQuery.of(context).size.width / 2,
//       MediaQuery.of(context).size.height / 2,
//     ),
//   );

//   if (hitTestResults == null || hitTestResults.isEmpty) {
//     arSessionManager?.onError("No plane detected in front.");
//     return;
//   }

//   // Find the first hit on a plane
//   final planeHit = hitTestResults.firstWhere(
//     (hit) => hit.type == ARHitTestResultType.plane,
//     orElse: () => hitTestResults.first,
//   );

//   // Create an anchor on the plane hit transform
//   var newAnchor = ARPlaneAnchor(transformation: planeHit.worldTransform);

//   bool? didAddAnchor = await arAnchorManager?.addAnchor(newAnchor);

//   if (didAddAnchor != true) {
//     arSessionManager?.onError("Failed to add anchor.");
//     return;
//   }

//   var nodeName = "Model_${DateTime.now().millisecondsSinceEpoch}";

//   // Create the model node
//   var newNode = ARNode(
//     name: nodeName,
//     type: NodeType.webGLB,
//     uri: glbUrl,
//     scale: vec.Vector3(0.2, 0.2, 0.2),
//     position: vec.Vector3(0, 0, 0), // relative to anchor
//     rotation: vec.Vector4(1.0, 0.0, 0.0, 0.0),
//   );

//   bool? didAddNode = await arObjectManager?.addNode(newNode, planeAnchor: newAnchor);

//   if (didAddNode == true) {
//     nodes.add(newNode);
//     anchors.add(newAnchor);
//     nodeAnchorMap[newNode] = newAnchor;
//   } else {
//     arSessionManager?.onError("Failed to add node to anchor.");
//   }
// }








//// Removes the selected node and its associated anchor from the AR session.

Future<void> onRemoveSelectedNodeAndAnchor() async {
  if (selectedNodeName == null) return;

  ARNode? node;
  try {
    node = nodes.firstWhere((n) => n.name == selectedNodeName);
  } catch (e) {
    return;
  }

  final anchor = nodeAnchorMap[node];
  if (anchor != null) {
    await arAnchorManager?.removeAnchor(anchor);
    anchors.remove(anchor);
  }

  await arObjectManager?.removeNode(node);
  nodes.remove(node);
  nodeAnchorMap.remove(node);
  selectedNodeName = null;
}







Future<void> onTakeScreenshot() async {
  var memoryImage = await arSessionManager!.snapshot();

  // Convert MemoryImage to PNG bytes
  final completer = Completer<ui.Image>();
  // ignore: prefer_const_constructors
  memoryImage.resolve(ImageConfiguration()).addListener(
    ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }),
  );

  final uiImage = await completer.future;
  final byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List pngBytes = byteData!.buffer.asUint8List();

  // Ask for permission
  final status = await Permission.storage.request();
  if (!status.isGranted) {
    print('Permission denied');
    return;
  }

  // Save to gallery
  final result = await ImageGallerySaver.saveImage(
    pngBytes,
    quality: 100,
    name: "AR_Screenshot_${DateTime.now().millisecondsSinceEpoch}",
  );

  print("Saved to gallery: $result");

  // Show preview with close button
  await showDialog(
    context: context,
    builder: (_) => Dialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(pngBytes),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(Icons.close, color: Colors.white, size: 24),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}




////// Scales the selected node by the given scale factor.
void onScaleSelectedNode(double scaleFactor) {
  if (selectedNodeName == null) return;

  final node = nodes.firstWhere(
      (n) => n.name == selectedNodeName,
      orElse: () => ARNode(
        type: NodeType.webGLB,
        uri: '',
        scale: vec.Vector3.zero(),
        position: vec.Vector3.zero(),
        rotation: vec.Vector4.zero(),
      ));

  

  final vec.Matrix4 transform = node.transform;

  final vec.Vector3 translation = vec.Vector3.zero();
  final vec.Quaternion rotation = vec.Quaternion.identity();
  final vec.Vector3 scale = vec.Vector3.zero();

  transform.decompose(translation, rotation, scale);

  final vec.Vector3 newScale = scale * scaleFactor;

  final vec.Matrix4 newTransform = vec.Matrix4.compose(
    translation,
    rotation,
    newScale,
  );

  node.transform = newTransform;
}



  // Pan gesture callbacks
  void onPanStarted(String nodeName) {
  }

  void onPanChanged(String nodeName) {
  }

void onPanEnded(String nodeName, Matrix4 newTransform) {
  selectedNodeName = nodeName;
}

  // Rotation gesture callbacks
  void onRotationStarted(String nodeName) {
  }

  void onRotationChanged(String nodeName) {
  }
void onRotationEnded(String nodeName, Matrix4 newTransform) {
  selectedNodeName = nodeName;
}

}





