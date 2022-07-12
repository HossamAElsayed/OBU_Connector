part of 'mqtt_cubit.dart';

class MqttState extends Equatable {
  final bool isConnectedwithServer;
  final bool isDetectionRunning;
  final bool machineState;
  const MqttState(
      this.isConnectedwithServer, this.isDetectionRunning, this.machineState);

  @override
  List<Object> get props =>
      [isConnectedwithServer, isDetectionRunning, machineState];

  MqttState copyWith({
    bool? isConnectedwithServer,
    bool? isDetectionRunning,
    bool? machineState,
  }) {
    return MqttState(
      isConnectedwithServer ?? this.isConnectedwithServer,
      isDetectionRunning ?? this.isDetectionRunning,
      machineState ?? this.machineState,
    );
  }
}
