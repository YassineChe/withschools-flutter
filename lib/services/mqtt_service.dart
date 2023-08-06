import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
//@configs
import '/configs/constants.dart';

class MqttService {
  //@instances
  MqttServerClient? client;

  //@inits
  init() async {
    try {
      //Init the client
      client = MqttServerClient.withPort(
        mqttHost,
        Random().nextInt(10).toString(),
        mqttPort,
      );

      //Set security context
      SecurityContext securityContext = SecurityContext()
        ..setTrustedCertificatesBytes(
          (await rootBundle.load('assets/certs/mqtt.crt')).buffer.asInt8List(),
        );

      //set client secure
      client?.secure = true;
      //set security context to client
      client?.securityContext = securityContext;

      //Conntect
      await client?.connect('demo_school', 'demo_school@2023');
    } catch (e) {
      print('------------------------------------------');
      print(e.toString());
      print('------------------------------------------');
      return null;
    }
  }

  publish({String? topic, var message}) {
    client?.publishMessage(
      topic!,
      MqttQos.atLeastOnce,
      MqttClientPayloadBuilder()
          .addString(
            message.toString(),
          )
          .payload!,
    );
  }
}
