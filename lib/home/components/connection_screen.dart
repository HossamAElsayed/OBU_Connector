import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PairingScreen extends StatefulWidget {
  final String deviceName;
  const PairingScreen(this.deviceName, {Key? key}) : super(key: key);

  @override
  State<PairingScreen> createState() => _PairingScreenState();
}

class _PairingScreenState extends State<PairingScreen> {
  bool isPaired = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isPaired = !isPaired;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(widget.deviceName,
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 70.0),
                isPaired
                    ? Icon(
                        Iconsax.link,
                        size: 80,
                        color: Colors.blue[600],
                      )
                    : const SizedBox(
                        height: 80,
                        width: 80,
                        child: Center(child: CircularProgressIndicator())),
                // Image.asset("assets/icons/accept.png", width: 80.0),
                const SizedBox(height: 50.0),
                Text(isPaired ? 'Connection completed' : 'Connecting...',
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                const SizedBox(height: 30.0),
                SizedBox(
                  width: size.width - 120.0,
                  child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[400],
                          height: 1.4),
                      textAlign: TextAlign.center),
                ),
                const SizedBox(height: 50.0),
                isPaired
                    ? TextButton(
                        onPressed: () {
                          debugPrint('Trying to unpair device');
                        },
                        child: const Text('Remove this device',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0)),
                      )
                    : Container(),
                const SizedBox(height: 200.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                  child: Container(
                      height: 50.0,
                      width: size.width,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: const Center(
                        child: Text('Back to home',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0)),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
