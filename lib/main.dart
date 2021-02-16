import 'package:flutter/material.dart';
import 'package:flutter_mqtt/home.dart';
import 'package:flutter_mqtt/dialogConstan.dart';
import 'dart:async';
import 'package:ez_mqtt_client/ez_mqtt_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  EzMqttClient mqttClient;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    mqttClient = EzMqttClient.nonSecure(
      url: "10.0.2.2",
      port: 1883,
      enableLogs: false,
      clientId: Utils.uuid,
    );
    print('[$TAG] is client connected: ${mqttClient.isConnected}');
    await mqttClient
        .connect()
        .then((connected) => '[$TAG] mqtt client connected : $connected')
        .catchError(
            (error) => print('[$TAG] unable to connect, error: $error'));
    print('[$TAG] is client connected: ${mqttClient.isConnected}');

    //final topic = "pengamat/masker";
    subscribe('pengamat/distance');
    subscribe('pengamat/mask');
  }

  Future<void> subscribe(String topic) async {
    await mqttClient
        .subscribeToTopic(
            topic: topic,
            onMessage: (topic, message) => {
                  if (topic == 'pengamat/distance')
                    {
                      print(message),
                      //print("abaudsfjkl"),
                      //Shistory.duration.add(int.parse(message)),
                      Shistory.distance.add(int.parse(message)),
                      print(Shistory.distance)
                      //Shistory.driveDuration.add("Abyan"),
                      //print(Shistory.duration.toString() + "Abyan")
                    }
                    else if (topic == "pengamat/mask") {
                      Shistory.mask.add(int.parse(message))
                    }
                })
        .then((value) => print('[$TAG] subscribed to topic: $value'))
        .catchError((error) => print(
            '[$TAG] failed to subscribe to topic: $topic. \n\nerror: \n$error'));
    IndexArray.array = IndexArray.array + 1;
    print("ini isi List Array nya : ");
    print(Shistory.distance);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
