// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
// import 'package:mapbox_gl_example/full_map.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

// import 'package:mapbox_gl_example/offline_regions.dart';

// import 'animate_camera.dart';
// import 'full_map.dart';
// import 'line.dart';
// import 'map_ui.dart';
// import 'move_camera.dart';
// import 'page.dart';
// import 'place_circle.dart';
// import 'place_source.dart';
// import 'place_symbol.dart';
// import 'place_fill.dart';
// import 'scrolling_map.dart';

final List<ExamplePage> _allPages = <ExamplePage>[
  // MapUiPage(),
  FullMapPage(),
  // AnimateCameraPage(),
  // MoveCameraPage(),
  // PlaceSymbolPage(),
  // PlaceSourcePage(),
  // LinePage(),
  // PlaceCirclePage(),
  // PlaceFillPage(),
  // ScrollingMapPage(),
  // OfflineRegionsPage(),
];

class MapsDemo extends StatelessWidget {
  //FIXME: Add your Mapbox access token here
  static const String ACCESS_TOKEN =
      "pk.eyJ1Ijoic3lmdWxpbiIsImEiOiJja2piZm15MG0yaWp1MnlucXhiZDdldDJsIn0.QFwhbjbDJ6ejo7N-tOp5Cg";

  void _pushPage(BuildContext context, ExamplePage page) async {
    if (!kIsWeb) {
      final location = Location();
      final hasPermissions = await location.hasPermission();
      if (hasPermissions != PermissionStatus.GRANTED) {
        await location.requestPermission();
      }
    }
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text(page.title)),
              body: page,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MapboxMaps examples')),
      body: ListView.builder(
        itemCount: _allPages.length,
        itemBuilder: (_, int index) => ListTile(
          leading: _allPages[index].leading,
          title: Text(_allPages[index].title),
          onTap: () => _pushPage(context, _allPages[index]),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MapsDemo()));
}

class FullMapPage extends ExamplePage {
  FullMapPage() : super(const Icon(Icons.map), 'Full screen map');

  @override
  Widget build(BuildContext context) {
    return const FullMap();
  }
}

class FullMap extends StatefulWidget {
  const FullMap();

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: MapboxMap(
      accessToken: MapsDemo.ACCESS_TOKEN,
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(55.030030, 82.920644),
        zoom: 11.5,
      ),
      onStyleLoadedCallback: onStyleLoadedCallback,
    ));
  }

  void onStyleLoadedCallback() {}
}

abstract class ExamplePage extends StatelessWidget {
  const ExamplePage(this.leading, this.title);

  final Widget leading;
  final String title;
}
