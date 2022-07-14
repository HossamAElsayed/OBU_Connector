part of 'mqtt_cubit.dart';

class MqttState extends Equatable {
  final bool isConnectedwithServer;
  final bool isDetectionRunning;
  final bool machineState;
  final bool isLiveFeedHostRunning;
  const MqttState(this.isConnectedwithServer, this.isDetectionRunning,
      this.machineState, this.isLiveFeedHostRunning);

  @override
  List<Object> get props => [
        isConnectedwithServer,
        isDetectionRunning,
        machineState,
        isLiveFeedHostRunning
      ];

  MqttState copyWith({
    bool? isConnectedwithServer,
    bool? isDetectionRunning,
    bool? machineState,
    bool? isLiveFeedHostRunning,
  }) {
    return MqttState(
      isConnectedwithServer ?? this.isConnectedwithServer,
      isDetectionRunning ?? this.isDetectionRunning,
      machineState ?? this.machineState,
      isLiveFeedHostRunning ?? this.isLiveFeedHostRunning,
    );
  }
}
