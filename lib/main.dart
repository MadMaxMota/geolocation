import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GeolocationPage(title: 'Pagina de Geolocalização'),
    );
  }
}

class GeolocationPage extends StatefulWidget {
  const GeolocationPage({super.key, required this.title});

  final String title;

  @override
  State<GeolocationPage> createState() => _GeolocationPageState();
}



class _GeolocationPageState extends State<GeolocationPage> {
  Position? _currentPosition;

  void _getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      print("Permissions not given");
    } else {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        setState(() {
          _currentPosition = position;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _currentPosition != null
                ? Text(
                    "LAT: ${_currentPosition!.latitude} \nLONG: ${_currentPosition!.longitude}")
                : const Text(""),
            TextButton(
                onPressed: () {
                  _getCurrentPosition();
                },
                child: const Text("Pegar minha localização"))
          ],
        ),
      ),
    );
  }
}
