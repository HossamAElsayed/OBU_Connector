import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:obu_connector/logic/cubit/mqtt_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceManagerScreen extends StatefulWidget {
  final String name;

  const DeviceManagerScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<DeviceManagerScreen> createState() => _DeviceManagerScreenState();
}

class _DeviceManagerScreenState extends State<DeviceManagerScreen> {
  final String obu_ip = '192.168.1.2';
  final String obu_port = '80';

  Future<void> _launchLiveFeedPage() async {
    final Uri liveFeedURL =
        Uri.parse('http://$obu_ip/video_feed'); // :$obu_port

    if (!await launchUrl(liveFeedURL)) {
      throw 'Could not launch $liveFeedURL';
    }
  }

  MqttCubit mqttCubit = MqttCubit();
  @override
  Widget build(BuildContext context) {
    return BlocListener<MqttCubit, MqttState>(
      listener: (context, state) {
        if (state.isLiveFeedHostRunning) {
          _launchLiveFeedPage();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              widget.name,
              style: const TextStyle(color: Colors.black),
            ),
            leading: const BackButton(
              color: Colors.black,
            ),
            actions: [
              TextButton.icon(
                icon: const Icon(Icons.stream_rounded),
                label: const Text('Live Feed'),
                onPressed: () {
                  BlocProvider.of<MqttCubit>(context).sendOpenLFHost();
                },
              ),
              BlocBuilder<MqttCubit, MqttState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (state.isConnectedwithServer)
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          body: SingleChildScrollView(
              child: SizedBox(
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        FadeInDown(
                          from: 100,
                          duration: const Duration(milliseconds: 1000),
                          child: Container(
                            width: 130,
                            height: 130,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  "assets/images/connect_device.png",
                                  height: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Current State',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<MqttCubit, MqttState>(
                                builder: (context, state) {
                                  return PropertyWidget(
                                      icon: (state.isConnectedwithServer
                                          ? Icons.local_fire_department
                                          : Icons.gps_off),
                                      title: "OBU State",
                                      subtitle: (state.isConnectedwithServer
                                          ? 'Running'
                                          : 'Off'));
                                },
                              ),
                              const PropertyWidget(
                                  icon: Icons.compare_arrows_rounded,
                                  title: "Unkown",
                                  subtitle: 'Unkown'),
                              // Container(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Send to ${widget.name}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    MaterialButton(
                                        onPressed: () {
                                          // If detection if off, start it. and if it is on stop it.
                                          BlocProvider.of<MqttCubit>(context)
                                              .sendDetectionTask();
                                        },
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: Colors.black,
                                        child:
                                            BlocBuilder<MqttCubit, MqttState>(
                                                builder: (context, state) {
                                          return BlocProvider.of<MqttCubit>(
                                                      context)
                                                  .state
                                                  .isDetectionRunning
                                              ? Row(
                                                  children: const [
                                                    Icon(
                                                      Iconsax.stop,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Stop Detecting",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: const [
                                                    Icon(
                                                      Iconsax.check,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Start Detecting",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                );
                                        })),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 130,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50.0),
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red[800],
                                  child: MaterialButton(
                                    onPressed: () {
                                      BlocProvider.of<MqttCubit>(context)
                                          .haltOBU();
                                      // Navigator.of(context).pushReplacementNamed('/');
                                    },
                                    minWidth: double.infinity,
                                    height: 50,
                                    child: const Text(
                                      "Shut OBU down",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])))),
    );
  }

  @override
  void dispose() {
    mqttCubit.disconnectWithOBU();
    super.dispose();
  }
}

class PropertyWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const PropertyWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: Colors.black),
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10.0,
                    )),
                const SizedBox(height: 4.0),
                Text(subtitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0,
                    ).copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
