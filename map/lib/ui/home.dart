import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

import '../models/lat_lng.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late YandexMapController controller;
  double minZoom = 1;
  double maxZoom = 10;

  double currentZoom = 5;
  Point currentPosision = Point(
      latitude: const EkbLocation().lat, longitude: const EkbLocation().long);

  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 2.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Текущее местоположение'),
      ),
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (YandexMapController yandexMapController) async {
              controller = yandexMapController;
              _moveToCurrentLocation(const EkbLocation());
              minZoom = await controller.getMinZoom();
              maxZoom = await controller.getMaxZoom();
              setState(() {});
            },
            onCameraPositionChanged: (cameraPosition, reason, finished) {
              currentZoom = cameraPosition.zoom;
              currentPosision = cameraPosition.target;
              setState(() {});
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 100,
              child: Row(
                children: [
                  Slider(
                    value: currentZoom,
                    min: minZoom,
                    max: maxZoom,
                    onChanged: (double value) async {
                      await controller.moveCamera(CameraUpdate.zoomTo(value));
                    },
                  ),
                  Joystick(
                    mode: JoystickMode.all,
                    base: const JoystickSquareBase(mode: JoystickMode.all),
                    stickOffsetCalculator:
                        const RectangleStickOffsetCalculator(),
                    listener: (details) async {
                      currentPosision = Point(
                          latitude: currentPosision.latitude - details.y * 0.01,
                          longitude:
                              currentPosision.longitude + details.x * 0.01);
                      await controller.moveCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target: Point(
                                  latitude: currentPosision.latitude,
                                  longitude: currentPosision.longitude),
                              zoom: currentZoom)));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _moveToCurrentLocation(
    AppLatLong appLatLong,
  ) async {
    await (controller).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 12,
        ),
      ),
    );
  }
}
