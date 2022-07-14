// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

part 'mqtt_state.dart';

class MqttCubit extends Cubit<MqttState> {
  MqttCubit() : super(const MqttState(false, false, false, false)) {
    _client.logging(on: false);
    _client.setProtocolV311();
    _client.keepAlivePeriod = 20;

    // client.onDisconnected = onDisconnected;

    // client.onConnected = onConnected;

    // client.onSubscribed = onSubscribed;

    // client.pongCallback = pong;
    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    _client.connectionMessage = connMess;
  }

  Future<void> connectToServer() async {
    try {
      await _client.connect();
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('EXAMPLE::client exception - $e');
      _client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print('EXAMPLE::socket exception - $e');
      _client.disconnect();
    }

    /// Check we are connected
    if (_client.connectionStatus!.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
      emit(state.copyWith(isConnectedwithServer: true));
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${_client.connectionStatus}');
      emit(state.copyWith(isConnectedwithServer: false));
      _client.disconnect();
    }
    StreamSubscription listenToPublishers =
        _client.published!.listen((MqttPublishMessage message) {
      print(
          'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
    });
    listenToChanges();
  }

  // setup server
  final _client = MqttServerClient('192.168.1.2', '');
  final _topic = 'obu/connect'; // topic name
  var _pongCount = 0; // Pong counter
  bool _haltState = false;
  // To stop and start Detection Algorithm
  void sendDetectionTask() {
    final builder = MqttClientPayloadBuilder();

    if (state.isConnectedwithServer && state.isDetectionRunning) {
      print("Sending >> Stop alogrithm");
      builder.addString('StopDetectionAlgorithm'); // message to be sent
      _client.subscribe(_topic, MqttQos.exactlyOnce);

      /// Publish it
      _client.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
    } else if (state.isConnectedwithServer && !state.isDetectionRunning) {
      print("Sending >> Start alogrithm");
      builder.addString('StartDetectionAlgorithm'); // message to be sent
      _client.subscribe(_topic, MqttQos.exactlyOnce);

      /// Publish it
      _client.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
      // emit(state.copyWith(isDetectionRunning: !state.isDetectionRunning));
    }
  }

  void sendOpenLFHost() {
    final builder = MqttClientPayloadBuilder();

    if (state.isConnectedwithServer) {
      print("Sending >> Start Live Feed Host");
      builder.addString('OpenLiveFeedHost'); // message to be sent
      _client.subscribe(_topic, MqttQos.exactlyOnce);

      /// Publish it
      _client.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
    }
  }

  void haltOBU() {
    final builder = MqttClientPayloadBuilder();

    if (state.isConnectedwithServer) {
      print("Sending >> Halt Request");
      builder.addString('HaltMachine'); // message to be sent
      _client.subscribe(_topic, MqttQos.exactlyOnce);

      /// Publish it
      _client.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
      Timer(const Duration(seconds: 3), () {
        if (!state.machineState) {
          print("unable to halt machine for some unkown reason");
        }
      });
    }
  }

  void listenToChanges() {
    _client.subscribe(_topic, MqttQos.atMostOnce);

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    _client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->\n');
      if (pt == 'AlgorithmTurnedOffSuccessfully' ||
          pt == 'AlgorithmTurnedOnSuccessfully') {
        emit(state.copyWith(isDetectionRunning: !state.isDetectionRunning));
      } else if (pt == 'HaltingIn3Sec') {
        emit(state.copyWith(machineState: true));
      } else if (pt == 'HostisLive') {
        emit(state.copyWith(isLiveFeedHostRunning: true));
      } else if (pt == 'UnableToOpenLiveFeedHost') {
        emit(state.copyWith(isLiveFeedHostRunning: false));
      }
    });
  }

  void disconnectWithOBU() async {
    /// Finally, unsubscribe and exit gracefully
    // print('EXAMPLE::Unsubscribing');
    // _client.unsubscribe(_topic);

    /// Wait for the unsubscribe message from the broker if you wish.
    // await MqttUtilities.asyncSleep(2);
    print('EXAMPLE::Disconnecting');
    _client.disconnect();
    print('EXAMPLE::Exiting normally');
  }

  // void disposalAllListeners() {
  //   listenToPublishers.cancel();
  // }
}
